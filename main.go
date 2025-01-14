package main

import (
	"context"
	"log"

	"go-poem-project/internal/animation"
	"go-poem-project/internal/instrumentation"
	"go-poem-project/internal/poem"
)

func main() {
	ctx := context.Background()

	instOptions := []instrumentation.Option{}

	inst, err := instrumentation.NewInstrumentation(ctx, instOptions...)
	if err != nil {
		log.Fatalf("failed to create instrumentation: %v", err)
	}

	err = inst.Load(ctx)
	if err != nil {
		log.Fatalf("failed to load instrumentation: %v", err)
	}

	log.Println("instrumentation loaded successfully, starting...")

	if err = inst.Run(ctx); err != nil {
		log.Fatalf("instrumentation crashed: %v", err)
	}

	defer inst.Shutdown(ctx)

	// Gerar e imprimir um poema
	poemText := poem.ForHer()
	log.Println("Generated poem:")
	log.Println(poemText)

	// Imprimir animação de céu estrelado
	animation.PrintStarrySky()
}
