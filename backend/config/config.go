package config

import (
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"time"

	"golang.org/x/oauth2"
	"golang.org/x/oauth2/google"
)

func Get() (*FirebaseConfig, error) {
	b, err := ioutil.ReadFile(filepath.Join(os.Getenv("HOME"), ".config", "configstore", "firebase-tools.json"))
	if err != nil {
		return nil, err
	}
	res := &FirebaseConfig{}
	if err := json.Unmarshal(b, res); err != nil {
		return nil, err
	}
	return res, nil
}

type FirebaseConfig struct {
	User struct {
		Email string `json:"email"`
	} `json:"user"`
	Token struct {
		ExpiresAt    int64  `json:"expires_at"`
		RefreshToken string `json:"refresh_token"`
		AccessToken  string `json:"access_token"`
		TokenType    string `json:"token_type"`
	} `json:"tokens"`
	ActiveProjects map[string]string `json:"activeProjects"`
}

func (f *FirebaseConfig) OAuth2TokenSource(ctx context.Context) (oauth2.TokenSource, error) {
	token := &oauth2.Token{
		AccessToken:  f.Token.AccessToken,
		TokenType:    f.Token.TokenType,
		RefreshToken: f.Token.RefreshToken,
		Expiry:       time.Unix(f.Token.ExpiresAt/1000, 0),
	}
	oauth2Config := &oauth2.Config{
		ClientID:     "563584335869-fgrhgmd47bqnekij5i8b5pr03ho849e6.apps.googleusercontent.com",
		ClientSecret: "j9iVZfS8kkCEFUPaAeJV0sAi",
		Endpoint:     google.Endpoint,
		RedirectURL:  "urn:ietf:wg:oauth:2.0:oob",
		Scopes:       []string{"https://www.googleapis.com/auth/cloud-platform"},
	}
	return oauth2Config.TokenSource(ctx, token), nil
}

func (f *FirebaseConfig) ProjectID() (string, error) {
	wd, err := os.Getwd()
	if err != nil {
		return "", err
	}
	projectID, found := f.ActiveProjects[wd]
	if !found {
		return "", fmt.Errorf("%q not an active project directory", wd)
	}
	return projectID, nil
}
