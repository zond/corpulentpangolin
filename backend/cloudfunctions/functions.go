package cloudfunctions

import (
	"log"

	"cloud.google.com/go/compute/metadata"
)

var (
	ProjectID string
	Zone      string
)

func init() {
	var err error
	if ProjectID, err = metadata.ProjectID(); err != nil {
		log.Panicf("Unable to fetch project ID: %v", err)
	}
	if Zone, err = metadata.Zone(); err != nil {
		log.Panicf("Unable to fetch project zone: %v", err)
	}

	loggingInit()

	firestoreInit()

	schedulerInit()
}
