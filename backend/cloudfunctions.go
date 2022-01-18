package emaciatedpangolin

import (
	"context"
	"net/http"
	"time"

	"github.com/zond/corpulentpangolin/backend/cloudfunctions"
	"github.com/zond/corpulentpangolin/backend/cloudfunctions/game"
)

type SchedulerTestArg struct {
	Param string
}

var schedulerTestFunc = cloudfunctions.NewSchedulerFunction("scheduler-test", func(ctx context.Context, a *SchedulerTestArg) error {
	cloudfunctions.DefaultLogger.Infof("Scheduler test: %q", a.Param)
	return nil
})

func HandleSchedulerTest(w http.ResponseWriter, r *http.Request) {
	if _, err := schedulerTestFunc.Schedule(r.Context(), time.Now().Add(time.Minute), &SchedulerTestArg{r.URL.Query().Get("param")}); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func HandleSchedulerFunction(w http.ResponseWriter, r *http.Request) {
	cloudfunctions.HandleSchedulerFunction(w, r)
}

func HandleGameCreated(ctx context.Context, e cloudfunctions.FirestoreEvent) error {
	return game.HandleGame(ctx, e)
}

func HandleGameUpdated(ctx context.Context, e cloudfunctions.FirestoreEvent) error {
	return game.HandleGame(ctx, e)
}
