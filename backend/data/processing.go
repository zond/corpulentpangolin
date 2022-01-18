package data

import (
	"strings"
	"time"

	"cloud.google.com/go/firestore"
)

func NameToPath(name string) string {
	return strings.Join(strings.Split(name, "/")[5:], "/")
}

type DocumentContext struct {
	TX          *firestore.Transaction
	ReprocessAt func(time.Time) error
	Ref         *firestore.DocumentRef
}
