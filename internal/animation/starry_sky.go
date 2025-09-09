package animation

import (
	"fmt"
	"time"
)

func PrintStarrySky() {
	stars := []string{
		"✦", "✧", "✩", "✪", "✫", "✬", "✭", "✮", "✯",
	}

	const (
		rows          = 10
		cols          = 20
		sleepDuration = 500 * time.Millisecond
	)

	for range rows {
		for j := range cols {
			fmt.Print(stars[j%len(stars)] + " ")
		}
		fmt.Println()
		time.Sleep(sleepDuration)
	}
}
