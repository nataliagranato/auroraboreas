package animation

import (
	"fmt"
	"time"
)

func PrintStarrySky() {
	stars := []string{
		"✦", "✧", "✩", "✪", "✫", "✬", "✭", "✮", "✯",
	}

	for i := 0; i < 10; i++ {
		for j := 0; j < 20; j++ {
			fmt.Print(stars[j%len(stars)] + " ")
		}
		fmt.Println()
		time.Sleep(500 * time.Millisecond)
	}
}