package cloudfunctions

import (
	"context"
	"fmt"
	"log"
	"reflect"
	"strconv"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/zond/corpulentpangolin/backend/data"
)

var FirestoreClient *firestore.Client

func firestoreInit() {
	var err error
	if FirestoreClient, err = firestore.NewClient(context.Background(), ProjectID); err != nil {
		log.Panicf("Unable to initialize Firestore client: %v", err)
	}
}

type FirestoreEvent struct {
	OldValue   FirestoreValue `json:"oldValue"`
	Value      FirestoreValue `json:"value"`
	UpdateMask struct {
		FieldPaths []string `json:"fieldPaths"`
	} `json:"updateMask"`
}

type FirestoreValue struct {
	CreateTime time.Time              `json:"createTime"`
	Name       string                 `json:"name"`
	UpdateTime time.Time              `json:"updateTime"`
	Fields     map[string]interface{} `json:"fields"`
}

func (f *FirestoreValue) Path() string {
	return data.NameToPath(f.Name)
}

func (f *FirestoreValue) assignFirestoreValue(val reflect.Value, fv map[string]interface{}) error {
	switch val.Type().Kind() {
	case reflect.String:
		val.SetString(fmt.Sprint(fv["stringValue"]))
	case reflect.Bool:
		val.SetBool(fmt.Sprint(fv["booleanValue"]) == "true")
	case reflect.Float64:
		strVal, found := fv["doubleValue"]
		if !found {
			strVal, found = fv["floatValue"]
		}
		if !found {
			strVal = fv["integerValue"]
		}
		f, err := strconv.ParseFloat(fmt.Sprint(strVal), 64)
		if err != nil {
			return err
		}
		val.SetFloat(f)
	case reflect.Uint64:
		i, err := strconv.ParseInt(fmt.Sprint(fv["integerValue"]), 10, 64)
		if err != nil {
			return err
		}
		val.SetUint(uint64(i))
	case reflect.Int64:
		i, err := strconv.ParseInt(fmt.Sprint(fv["integerValue"]), 10, 64)
		if err != nil {
			return err
		}
		val.SetInt(int64(i))
	case reflect.Slice:
		if av, found := fv["arrayValue"]; found {
			if v, found := av.(map[string]interface{})["values"]; found {
				newSlice := reflect.MakeSlice(val.Type(), 0, 0)
				val.Set(newSlice)
				for _, e := range v.([]interface{}) {
					newValPtr := reflect.New(val.Type().Elem())
					if err := f.assignFirestoreValue(newValPtr.Elem(), e.(map[string]interface{})); err != nil {
						return err
					}
					val.Set(reflect.Append(val, newValPtr.Elem()))
				}
			}
		}
	default:
		return fmt.Errorf("Unknown value type %v", val)
	}
	return nil
}

func (f *FirestoreValue) Unserialize(i interface{}) error {
	val := reflect.ValueOf(i)
	if val.Kind() != reflect.Ptr && val.Elem().Kind() != reflect.Struct {
		return fmt.Errorf("%#v is not pointer to a struct", i)
	}
	structType := val.Type().Elem()
	for idx := 0; idx < structType.NumField(); idx++ {
		field := structType.Field(idx)
		if fieldVal, found := f.Fields[field.Name]; found {
			if err := f.assignFirestoreValue(val.Elem().Field(idx), fieldVal.(map[string]interface{})); err != nil {
				return err
			}
		}
	}
	return nil
}
