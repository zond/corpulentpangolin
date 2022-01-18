package cloudfunctions

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"reflect"
	"sort"
	"time"

	"google.golang.org/protobuf/types/known/timestamppb"

	cloudtasks "cloud.google.com/go/cloudtasks/apiv2"
	taskspb "google.golang.org/genproto/googleapis/cloud/tasks/v2"
)

var (
	schedulerLogger    Logger
	schedulerFunctions = map[string]*schedulerFunction{}
	errorInterface     = reflect.TypeOf((*error)(nil)).Elem()
	contextInterface   = reflect.TypeOf((*context.Context)(nil)).Elem()
	cloudtasksClient   *cloudtasks.Client
)

func schedulerInit() {
	schedulerLogger = NewLogger("scheduler")
	var err error
	if cloudtasksClient, err = cloudtasks.NewClient(context.Background()); err != nil {
		log.Panicf("Unable to initialize cloudtasks client: %v", err)
	}
}

func schedulerURL() string {
	return fmt.Sprintf("https://us-central1-%s.cloudfunctions.net/HandleSchedulerFunction", ProjectID)
}

func queueParentPath() string {
	return fmt.Sprintf("projects/%s/locations/us-central1", ProjectID)
}

func queuePath(queueName string) string {
	return fmt.Sprintf("%s/queues/%s", queueParentPath(), queueName)
}

type SchedulerFunction interface {
	Schedule(context.Context, time.Time, interface{}) (*taskspb.Task, error)
}

type schedulerFunction struct {
	key      string
	callback func(context.Context, interface{}) error
	arg      reflect.Type
}

func (s *schedulerFunction) Schedule(ctx context.Context, at time.Time, arg interface{}) (*taskspb.Task, error) {
	handler, found := schedulerFunctions[s.key]
	if !found {
		return nil, fmt.Errorf("No scheduler function %q found", s.key)
	}
	if handler != s {
		return nil, fmt.Errorf("Saved scheduler for %q doesn't match scheduler used?", s.key)
	}
	if argType := reflect.TypeOf(arg); handler.arg != argType {
		return nil, fmt.Errorf("Scheduler %q wants argument %v, not %v", s.key, handler.arg, argType)
	}
	b, err := json.Marshal(map[string]interface{}{
		"arg": arg,
		"key": s.key,
	})
	if err != nil {
		return nil, err
	}
	req := &taskspb.CreateTaskRequest{
		Parent: queuePath(handler.key),
		Task: &taskspb.Task{
			ScheduleTime: timestamppb.New(at),
			MessageType: &taskspb.Task_HttpRequest{
				HttpRequest: &taskspb.HttpRequest{
					HttpMethod: taskspb.HttpMethod_POST,
					// This URL must match the task URL _precisely_. E.g. query parameters
					// will make it fail due to 'unauthenticated'.
					Url:  schedulerURL(),
					Body: b,
					AuthorizationHeader: &taskspb.HttpRequest_OidcToken{
						OidcToken: &taskspb.OidcToken{
							// For this cloud task to work, the service account defined here needs to be
							// 'Cloud Functions Invoker' in https://console.cloud.google.com/iam-admin/iam.
							ServiceAccountEmail: fmt.Sprintf("%s@appspot.gserviceaccount.com", ProjectID),
						},
					},
				},
			},
		},
	}
	return cloudtasksClient.CreateTask(ctx, req)
}

func NewSchedulerFunction(key string, callback interface{}) SchedulerFunction {
	ctx := context.Background()
	// For this part to work, the service account using it must be 'Cloud Task Admin' and 'Service Account User'
	// in https://console.cloud.google.com/iam-admin/iam.
	if _, err := cloudtasksClient.GetQueue(ctx, &taskspb.GetQueueRequest{Name: queuePath(key)}); err != nil {
		schedulerLogger.Infof("Queue for %q might not exist, going to create", key)
		if _, err = cloudtasksClient.CreateQueue(ctx, &taskspb.CreateQueueRequest{
			Parent: queueParentPath(),
			Queue: &taskspb.Queue{
				Name: queuePath(key),
			},
		}); err != nil {
			log.Panicf("Unable to create missing queue %q: %v", key, err)
		}
		schedulerLogger.Infof("Created queue for %q", key)
	}
	value := reflect.ValueOf(callback)
	if value.Kind() != reflect.Func {
		log.Panicf("SchedulerFunction %#v not a func", callback)
	}
	typ := value.Type()
	if typ.NumIn() != 2 {
		log.Panicf("SchedulerFunction %#v not a func with 2 arguments!", callback)
	}
	argTyp := typ.In(0)
	if argTyp != contextInterface {
		log.Panicf("SchedulerFunction %#v not a func with a first context.Context argument!", callback)
	}
	argTyp = typ.In(1)
	if argTyp.Kind() != reflect.Ptr || argTyp.Elem().Kind() != reflect.Struct {
		log.Panicf("SchedulerFunction %#v not a func with a second struct pointer argument!", callback)
	}
	if typ.NumOut() != 1 {
		log.Panicf("SchedulerFunction %#v not a func with 1 return value!", callback)
	}
	if typ.Out(0) != errorInterface {
		log.Panicf("SchedulerFunction %#v not a func with error return value!", callback)
	}
	res := &schedulerFunction{
		key: key,
		callback: func(ctx context.Context, arg interface{}) error {
			schedulerLogger.Infof("Calling %q with %+v.", key, arg)
			results := value.Call([]reflect.Value{reflect.ValueOf(ctx), reflect.ValueOf(arg)})
			if !results[0].IsNil() {
				if err := results[0].Interface().(error); err != nil {
					return err
				}
			}
			return nil
		},
		arg: argTyp,
	}
	schedulerFunctions[key] = res
	return res
}

func HandleSchedulerFunction(w http.ResponseWriter, r *http.Request) {
	cpy := &bytes.Buffer{}
	if _, err := io.Copy(cpy, r.Body); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	o := map[string]interface{}{}
	if err := json.NewDecoder(cpy).Decode(&o); err != nil {
		http.Error(w, fmt.Sprintf("Unable to unmarshal %q: %v", cpy.String(), err), http.StatusInternalServerError)
		return
	}
	key := fmt.Sprint(o["key"])
	handler, found := schedulerFunctions[key]
	if !found {
		keys := sort.StringSlice{}
		for k := range schedulerFunctions {
			keys = append(keys, k)
		}
		sort.Sort(keys)
		http.Error(w, fmt.Sprintf("No scheduler function found for %q. Known scheduler functions are %+v.", key, keys), http.StatusInternalServerError)
		return
	}
	argBytes, err := json.Marshal(o["arg"])
	if err != nil {
		http.Error(w, fmt.Sprintf("Unable to marshal %+v: %v", o["arg"], err), http.StatusInternalServerError)
		return
	}
	arg := reflect.New(handler.arg.Elem()).Interface()
	if err := json.Unmarshal(argBytes, arg); err != nil {
		http.Error(w, fmt.Sprintf("Unable to marshal %q into %+v: %v", string(argBytes), arg, err), http.StatusInternalServerError)
		return
	}
	if err := handler.callback(r.Context(), arg); err != nil {
		http.Error(w, fmt.Sprintf("Calling %q with %+v: %v", key, arg, err), http.StatusInternalServerError)
		return
	}
}
