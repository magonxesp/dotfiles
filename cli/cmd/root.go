package cmd

import (
	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "dotfiles",
	Short: "The CLI program for managing dotfiles",
	Long: `Dotfiles is a command-line tool for managing your dotfiles configuration.
It allows you to sync symbolic links and update your dotfiles easily.`,
	Run: func(cmd *cobra.Command, args []string) {
		cmd.Help()
	},
}

func Execute() error {
	return rootCmd.Execute()
}

func init() {
	rootCmd.AddCommand(updateSymlinksCmd)
	rootCmd.AddCommand(updateCmd)
}
