package cloudfunctions

import (
	"context"
	"fmt"
	"log"

	"cloud.google.com/go/logging"
)

// For this package to work, the service account using it must
// have 'Logs Writer' in https://console.cloud.google.com/iam-admin/iam.

var (
	loggingClient *logging.Client
	DefaultLogger Logger
)

func loggingInit() {
	var err error
	if loggingClient, err = logging.NewClient(context.Background(), ProjectID); err != nil {
		log.Panicf("Unable to initialize logger: %v", err)
	}
	DefaultLogger = NewLogger("default")
}

func NewLogger(name string) Logger {
	return &logger{
		logger: loggingClient.Logger(name),
	}
}

type Logger interface {
	Infof(string, ...interface{})
	Warningf(string, ...interface{})
	Errorf(string, ...interface{})
	Sync(context.Context) Logger
}

type logger struct {
	logger *logging.Logger
	sync   bool
	ctx    context.Context
}

func (l *logger) log(e logging.Entry) {
	if l.sync {
		l.logger.LogSync(l.ctx, e)
	} else {
		l.logger.Log(e)
	}
}

func (l *logger) Sync(ctx context.Context) Logger {
	return &logger{
		logger: l.logger,
		sync:   true,
		ctx:    ctx,
	}
}

func (l *logger) Infof(f string, params ...interface{}) {
	l.log(logging.Entry{
		Payload:  fmt.Sprintf(f, params...),
		Severity: logging.Info,
	})
}

func (l *logger) Errorf(f string, params ...interface{}) {
	l.log(logging.Entry{
		Payload:  fmt.Sprintf(f, params...),
		Severity: logging.Error,
	})
}

func (l *logger) Warningf(f string, params ...interface{}) {
	l.log(logging.Entry{
		Payload:  fmt.Sprintf(f, params...),
		Severity: logging.Warning,
	})
}
