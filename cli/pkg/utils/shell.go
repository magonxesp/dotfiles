package utils

import (
	"fmt"
	"os"
	"os/exec"
)

// Exec executes a command with the given arguments
func Exec(name string, args ...string) error {
	cmd := exec.Command(name, args...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin

	if err := cmd.Run(); err != nil {
		return fmt.Errorf("command failed: %w", err)
	}

	return nil
}
