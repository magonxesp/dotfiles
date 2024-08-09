package io.github.magonxesp.dotfiles.commands

import com.github.ajalt.clikt.core.CliktCommand
import io.github.magonxesp.dotfiles.dotfilesRootDirectory
import io.github.magonxesp.dotfiles.services.SymbolicLinksUpdater
import io.github.magonxesp.dotfiles.utils.exec

class UpdateDotfilesCommand : CliktCommand(
	name = "update",
	help = "Update the dotfiles to the latest version"
) {
	private val symbolicLinksUpdater = SymbolicLinksUpdater()

	override fun run() {
		exec("git -C $dotfilesRootDirectory reset --hard HEAD")
		exec("git -C $dotfilesRootDirectory pull origin master")

		echo("Updating symbolic links")
		symbolicLinksUpdater.updateAll()

		echo("Dotfiles updated")
	}
}
