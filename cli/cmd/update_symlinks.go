package cmd

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"

	"github.com/magonxesp/dotfiles/pkg/utils"
	"github.com/spf13/cobra"
	"gopkg.in/yaml.v3"
)

var updateSymlinksCmd = &cobra.Command{
	Use:   "update-symlinks",
	Short: "Update symbolic links",
	Long:  "Scan and apply all symbolic links configurations from YAML files",
	RunE:  runUpdateSymlinks,
}

// Symlinks represents the configuration for symbolic links
type Symlinks struct {
	Symlinks Config `yaml:"symlinks"`
}

type Config struct {
	Override bool     `yaml:"override"`
	Links    []string `yaml:"links"`
}

type SymbolicLinksUpdater struct {
	configsDir string
}

func NewSymbolicLinksUpdater() *SymbolicLinksUpdater {
	dotfilesDir, err := utils.GetEnv("DOTFILES_DIRECTORY")
	if err != nil {
		panic(err)
	}

	return &SymbolicLinksUpdater{
		configsDir: filepath.Join(dotfilesDir, "symlinks"),
	}
}

func (u *SymbolicLinksUpdater) ScanConfigs() (map[string]*Symlinks, error) {
	configs := make(map[string]*Symlinks)

	entries, err := os.ReadDir(u.configsDir)
	if err != nil {
		if os.IsNotExist(err) {
			return configs, nil
		}
		return nil, err
	}

	for _, entry := range entries {
		if entry.IsDir() {
			continue
		}

		name := entry.Name()
		if !isYAMLFile(name) {
			continue
		}

		filePath := filepath.Join(u.configsDir, name)
		content, err := os.ReadFile(filePath)
		if err != nil {
			return nil, err
		}

		var symlinks Symlinks
		if err := yaml.Unmarshal(content, &symlinks); err != nil {
			return nil, err
		}

		configs[name] = &symlinks
	}

	return configs, nil
}

// Update applies symbolic links configuration
func (u *SymbolicLinksUpdater) Update(symlinks *Symlinks) error {
	config := symlinks.Symlinks

	for _, link := range config.Links {
		if !isValidSymlinkFormat(link) {
			fmt.Printf("Skipping bad formatted symbolic link \"%s\"\n", link)
			continue
		}

		parts := strings.Split(link, ":")
		destination := utils.ExpandPath(parts[0])
		origin := utils.ExpandPath(parts[1])

		// Check if origin exists
		if _, err := os.Stat(origin); os.IsNotExist(err) {
			fmt.Printf("The file %s cannot be linked because it doesn't exist!\n", origin)
			continue
		}

		// Check if destination exists and handle override
		if _, err := os.Stat(destination); err == nil {
			if !config.Override {
				continue
			}
			if err := removeDestination(destination); err != nil {
				return err
			}
		}

		// Create parent directories if needed
		parentDir := filepath.Dir(destination)
		if err := os.MkdirAll(parentDir, 0755); err != nil {
			return err
		}

		// Create symbolic link
		if err := os.Symlink(origin, destination); err != nil {
			return err
		}
	}

	return nil
}

// UpdateAll scans and updates all symbolic links configurations
func (u *SymbolicLinksUpdater) UpdateAll() error {
	configs, err := u.ScanConfigs()
	if err != nil {
		return err
	}

	if len(configs) == 0 {
		return nil
	}

	for _, symlinks := range configs {
		if err := u.Update(symlinks); err != nil {
			return err
		}
	}

	return nil
}

func isYAMLFile(filename string) bool {
	ext := filepath.Ext(filename)
	return ext == ".yml" || ext == ".yaml"
}

func isValidSymlinkFormat(link string) bool {
	pattern := regexp.MustCompile(`^.+:.+$`)
	return pattern.MatchString(link)
}

func removeDestination(path string) error {
	info, err := os.Stat(path)
	if err != nil {
		if os.IsNotExist(err) {
			return nil
		}
		return err
	}

	if info.IsDir() {
		return os.RemoveAll(path)
	}

	return os.Remove(path)
}

func runUpdateSymlinks(cmd *cobra.Command, args []string) error {
	updater := NewSymbolicLinksUpdater()

	configs, err := updater.ScanConfigs()
	if err != nil {
		return err
	}

	if len(configs) == 0 {
		fmt.Println("Symbolic links configurations not found!")
		return nil
	}

	for configName, symlinks := range configs {
		fmt.Printf("Applying symbolic links configuration from %s\n", configName)
		if err := updater.Update(symlinks); err != nil {
			return err
		}
	}

	fmt.Println("Symbolic links updated!")
	return nil
}
