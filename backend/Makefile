PROJECT_ID = $(shell go run cmd/tool.go)

compile:
	go mod tidy
	go build ./...

.PHONY: rules
rules: compile
	go run cmd/tool.go --cmd update-rules 2>&1 | ts -s '[%M:%S] rules:'

.PHONY: variants
variants: compile
	go run cmd/tool.go --cmd update-variants 2>&1 | ts -s '[%M:%S] variants:'

functions: handle_game_created handle_game_updated handle_scheduler_function handle_scheduler_test

handle_game_created: compile
	gcloud --project $(PROJECT_ID) functions deploy HandleGameCreated --retry --runtime go116 --trigger-event providers/cloud.firestore/eventTypes/document.create --trigger-resource "projects/$(PROJECT_ID)/databases/(default)/documents/Game/{gameID}" 2>&1 | ts -s '[%M:%S] handle_game_created:'

handle_game_updated: compile
	gcloud --project $(PROJECT_ID) functions deploy HandleGameUpdated --retry --runtime go116 --trigger-event providers/cloud.firestore/eventTypes/document.update --trigger-resource "projects/$(PROJECT_ID)/databases/(default)/documents/Game/{gameID}" 2>&1 | ts -s '[%M:%S] handle_game_updated:'

handle_scheduler_function: compile
	gcloud --project $(PROJECT_ID) functions deploy HandleSchedulerFunction --runtime go116 --trigger-http 2>&1 | ts -s '[%M:%S] handle_scheduler_function:'

handle_scheduler_test: compile
	gcloud --project $(PROJECT_ID) functions deploy HandleSchedulerTest --runtime go116 --trigger-http --allow-unauthenticated 2>&1 | ts -s '[%M:%S] handle_scheduler_test:'

all: rules functions variants

process_debug_games:
	FIRESTORE_EMULATOR_HOST=localhost:8080 go run cmd/tool.go -cmd process-all-games

debug_variants:
	FIRESTORE_EMULATOR_HOST=localhost:8080 go run cmd/tool.go --cmd update-variants 2>&1 | ts -s '[%M:%S] variants:'
