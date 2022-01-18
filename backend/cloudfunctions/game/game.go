package game

import (
	"context"
	"time"

	"cloud.google.com/go/firestore"
	"github.com/zond/corpulentpangolin/backend/cloudfunctions"
	"github.com/zond/corpulentpangolin/backend/data"
)

type ReprocessGameArg struct {
	GamePath string
}

var reprocessGameFunc cloudfunctions.SchedulerFunction

func init() {
	reprocessGameFunc = cloudfunctions.NewSchedulerFunction("reprocess-game", func(ctx context.Context, a *ReprocessGameArg) error {
		return processGame(ctx, a.GamePath)
	})
}

func HandleGame(ctx context.Context, e cloudfunctions.FirestoreEvent) error {
	return processGame(ctx, e.Value.Path())
}

func processGame(ctx context.Context, gamePath string) error {
	if err := cloudfunctions.FirestoreClient.RunTransaction(ctx, func(ctx context.Context, tx *firestore.Transaction) error {
		return data.ProcessGame(&data.DocumentContext{
			TX:  tx,
			Ref: cloudfunctions.FirestoreClient.Doc(gamePath),
			ReprocessAt: func(t time.Time) error {
				_, err := reprocessGameFunc.Schedule(ctx, t, &ReprocessGameArg{gamePath})
				return err
			},
		})
	}); err != nil {
		log.Errorf("Unable to complete processGame tx: %v", err)
		return err
	}
	log.Infof("Processed %v!", gamePath)
	return nil
}
