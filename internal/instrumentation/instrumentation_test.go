package instrumentation

import (
	"context"
	"testing"
)

func TestNewInstrumentation(t *testing.T) {
	ctx := context.Background()
	inst, err := NewInstrumentation(ctx)
	if err != nil {
		t.Errorf("Erro ao criar instrumentação: %v", err)
	}
	if inst == nil {
		t.Error("Instrumentação não deve ser nil")
	}
}
