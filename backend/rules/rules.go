package rules

import (
	"io/ioutil"
	"log"
	"os"
	"os/exec"

	"github.com/zond/corpulentpangolin/backend/data"
)

var (
	rules = []Collection{
		{
			Name: "Variant",
			Collections: []Collection{
				{
					Name: "Unit",
				},
				{
					Name: "Flag",
				},
				{
					Name: "Map",
				},
			},
		},
		{
			Type: data.User{},
		},
		{
			Type: data.Game{},
			Functions: []string{
				`function missingUserDocAndIsOK(doc) {
  return !exists(/databases/$(database)/documents/User/$(request.auth.uid))
         &&
         (doc.get("MinReliability", 0) == 0)
         &&
         (doc.get("MinQuickness", 0) == 0)
         &&
         (doc.get("MinRating", 0) == 0);
}`,
				`function existingUserAllowedInGame(doc) {
  let user = get(/databases/$(database)/documents/User/$(request.auth.uid)).data;
  return (doc.Players.toSet().intersection(user.get("BannedUsers", []).toSet()).size() == 0)
         &&
         (doc.Players.toSet().intersection(user.get("BannedByUsers", []).toSet()).size() == 0)
         &&
         (user.get("Reliability", 0) >= doc.get("MinReliability", 0))
         &&
         (user.get("Quickness", 0) >= doc.get("MinQuickness", 0))
         &&
         (user.get("Rating", 0) >= doc.get("MinRating", 0));
}`,
				`function invitedOrDoesntNeedInvitation(doc) {
  return !doc.get("InvitationRequired", false) || (request.auth.uid in doc.get("InvitedPlayers", []));
}`,
				`function userAllowedInGame(doc) {
  return invitedOrDoesntNeedInvitation(doc)
         &&
         (
           missingUserDocAndIsOK(doc)
           ||
           existingUserAllowedInGame(doc)
         );
}`,
			},
			Collections: []Collection{
				{
					Type: data.Phase{},
				},
				{
					Type: data.Preference{},
				},
			},
		},
	}
)

func DeployFirestoreRules() error {
	log.Printf("Generating firestore.rules...")
	if err := ioutil.WriteFile("firestore.rules", []byte(Generate(rules)), 0664); err != nil {
		return err
	}
	log.Printf("Deploying firestore.rules...")
	cmd := exec.Command("firebase", "deploy", "--only", "firestore:rules")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		return err
	}
	return nil
}

func main() {
	if err := DeployFirestoreRules(); err != nil {
		log.Panic(err)
	}
}
