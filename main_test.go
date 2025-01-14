package main

import (
	"context"
	"testing"

	"go-poem-project/internal/animation"
	"go-poem-project/internal/instrumentation"
	"go-poem-project/internal/poem"
)

func TestMainFunction(t *testing.T) {
	ctx := context.Background()

	// Mock instrumentation
	instOptions := []instrumentation.Option{}
	inst, err := instrumentation.NewInstrumentation(ctx, instOptions...)
	if err != nil {
		t.Fatalf("failed to create instrumentation: %v", err)
	}

	err = inst.Load(ctx)
	if err != nil {
		t.Fatalf("failed to load instrumentation: %v", err)
	}

	if err = inst.Run(ctx); err != nil {
		t.Fatalf("instrumentation crashed: %v", err)
	}

	defer inst.Shutdown(ctx)

	// Test poem generation
	poemText := poem.ForHer()
	if poemText == "" {
		t.Error("expected poem text, got empty string")
	}

	// Test animation
	// Note: Since animation.PrintStarrySky() prints to stdout, you might want to capture stdout in tests
	animation.PrintStarrySky()
}
