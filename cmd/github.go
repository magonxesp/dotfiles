package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
)

var githubCommand = &cobra.Command{
	Use:   "github",
	Short: "Github related helpers",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("Hola github")
	},
}

func init() {
	rootCmd.AddCommand(githubCommand)
}
