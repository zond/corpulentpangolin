package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"sort"

	"github.com/zond/corpulentpangolin/backend/config"
	"github.com/zond/corpulentpangolin/backend/data"
	"github.com/zond/corpulentpangolin/backend/firestore"
	"github.com/zond/corpulentpangolin/backend/rules"
	"github.com/zond/corpulentpangolin/backend/variants"

	cloudFire "cloud.google.com/go/firestore"
)

var (
	cmds = map[string]func(){
		"project-id": func() {
			conf, err := config.Get()
			if err != nil {
				log.Panicf("Unable to load config: %v", err)
			}
			projectID, err := conf.ProjectID()
			if err != nil {
				log.Panicf("Unable to get project ID: %v", err)
			}
			fmt.Println(projectID)
		},
		"update-variants": func() {
			if err := variants.StoreVariantInfo(context.Background()); err != nil {
				log.Panic(err)
			}
		},
		"update-rules": func() {
			if err := rules.DeployFirestoreRules(); err != nil {
				log.Panic(err)
			}
		},
		// This almost duplicates cloudfunctions/game/game.go:processGame, but some
		// bits are different. E.g. this doesn't schedule new game processing.
		"process-all-games": func() {
			ctx := context.Background()
			store, err := firestore.Firestore(ctx)
			if err != nil {
				log.Panic(err)
			}
			games, err := store.Collection("Game").Documents(ctx).GetAll()
			if err != nil {
				log.Panic(err)
			}
			for _, snap := range games {
				if err := store.RunTransaction(ctx, func(ctx context.Context, tx *cloudFire.Transaction) error {
					return data.ProcessGame(&data.DocumentContext{
						TX:  tx,
						Ref: store.Doc(data.NameToPath(snap.Ref.Path)),
					})
				}); err != nil {
					log.Panic(err)
				}
				log.Printf("Processed %v!", snap.Ref.Path)
			}
		},
	}
	cmdNames = sort.StringSlice{}
)

func init() {
	for name := range cmds {
		cmdNames = append(cmdNames, name)
	}
	sort.Sort(cmdNames)
}

func main() {
	cmd := flag.String("cmd", "project-id", fmt.Sprintf("Command to perform. Alternatives are: %+v.", cmdNames))
	flag.Parse()
	cmds[*cmd]()
}
