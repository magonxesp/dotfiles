package io.github.magonxesp.dotfiles.commands

import com.github.ajalt.clikt.core.CliktCommand
import io.github.magonxesp.dotfiles.services.SymbolicLinksUpdater

class UpdateSymbolicLinksCommand : CliktCommand(
	name = "update-symlinks",
	help = "Update symbolic links"
) {
	private val updater = SymbolicLinksUpdater()

	override fun run() {
		val configs = updater.scanConfigs()
		
		if (configs.isEmpty()) {
			echo("Symbolic links configurations not found!")
			return
		}

		for (config in configs) {
			echo("Applying symbolic links configuration from ${config.first}")
			updater.update(config.second)
		}

		echo("Symbolic links updated!")
	}
}
