package instrumentation

import (
	"context"
	"log"

	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/sdk/resource"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	"go.opentelemetry.io/otel/trace"
)

type Instrumentation struct {
	tp     *sdktrace.TracerProvider
	tracer trace.Tracer
}

type Option func(*Instrumentation)

func NewInstrumentation(ctx context.Context, opts ...Option) (*Instrumentation, error) {
	inst := &Instrumentation{}

	for _, opt := range opts {
		opt(inst)
	}

	res, err := resource.New(ctx, resource.WithAttributes())
	if err != nil {
		return nil, err
	}

	tp := sdktrace.NewTracerProvider(sdktrace.WithResource(res))
	otel.SetTracerProvider(tp)

	inst.tp = tp
	inst.tracer = tp.Tracer("go-poem-project")

	return inst, nil
}

func (i *Instrumentation) Load(ctx context.Context) error {
	// Lógica para carregar a instrumentação
	return nil
}

func (i *Instrumentation) Run(ctx context.Context) error {
	// Lógica para executar a instrumentação
	return nil
}

func (i *Instrumentation) Shutdown(ctx context.Context) error {
	return i.tp.Shutdown(ctx)
}

func LogError(message string, err error) {
	log.Printf("ERROR: %s: %v", message, err)
}
