package firestore

import (
	"context"

	"cloud.google.com/go/firestore"
	"github.com/zond/corpulentpangolin/backend/config"
	"google.golang.org/api/option"

	firebase "firebase.google.com/go"
)

func FixJSONKeysForFirestore(m map[string]interface{}) {
	for k, v := range m {
		if k == "" {
			m["."] = v
			delete(m, "")
		}
		if s, ok := v.(map[string]interface{}); ok {
			FixJSONKeysForFirestore(s)
		}
	}
}

func Firestore(ctx context.Context) (*firestore.Client, error) {
	conf, err := config.Get()
	if err != nil {
		return nil, err
	}
	ts, err := conf.OAuth2TokenSource(ctx)
	if err != nil {
		return nil, err
	}
	projectID, err := conf.ProjectID()
	if err != nil {
		return nil, err
	}
	app, err := firebase.NewApp(ctx, &firebase.Config{ProjectID: projectID}, option.WithTokenSource(ts))
	if err != nil {
		return nil, err
	}
	return app.Firestore(ctx)
}
