package utils

import (
	"fmt"
	"os"
	"strings"
)

// GetEnv retrieves an environment variable or returns an error if not set
func GetEnv(key string) (string, error) {
	value := os.Getenv(key)
	if value == "" {
		return "", fmt.Errorf("environment variable %s does not exist", key)
	}
	return value, nil
}

// ExpandPath expands ~ to home directory in a path
func ExpandPath(path string) string {
	if strings.HasPrefix(path, "~") {
		homeDir, err := os.UserHomeDir()
		if err != nil {
			return path
		}
		return strings.Replace(path, "~", homeDir, 1)
	}
	return path
}
