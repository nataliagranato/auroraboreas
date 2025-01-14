package poem

import "testing"

func TestForHer(t *testing.T) {
	poem := ForHer()
	if poem == "" {
		t.Error("Poema não deve estar vazio")
	}
}
