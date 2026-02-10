package cmd

import (
	"fmt"

	"github.com/magonxesp/dotfiles/pkg/utils"
	"github.com/spf13/cobra"
)

var updateCmd = &cobra.Command{
	Use:   "update",
	Short: "Update the dotfiles to the latest version",
	Long:  "Pull the latest dotfiles from the repository and update symbolic links",
	RunE:  runUpdate,
}

func runUpdate(cmd *cobra.Command, args []string) error {
	dotfilesRoot, err := utils.GetEnv("DOTFILES_ROOT_DIRECTORY")
	if err != nil {
		return err
	}

	// Reset and pull from origin
	if err := utils.Exec("git", "-C", dotfilesRoot, "reset", "--hard", "HEAD"); err != nil {
		return err
	}

	if err := utils.Exec("git", "-C", dotfilesRoot, "pull", "origin", "master"); err != nil {
		return err
	}

	fmt.Println("Updating symbolic links")
	updater := NewSymbolicLinksUpdater()

	if err := updater.UpdateAll(); err != nil {
		return err
	}

	fmt.Println("Dotfiles updated")
	return nil
}
