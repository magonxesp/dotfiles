package io.github.magonxesp.dotfiles.services

import io.github.magonxesp.dotfiles.dotfilesDirectory
import io.github.magonxesp.dotfiles.model.Symlinks
import io.github.magonxesp.dotfiles.utils.toPath
import net.mamoe.yamlkt.Yaml
import org.apache.commons.io.FileUtils
import java.nio.file.Files
import kotlin.io.path.Path
import kotlin.io.path.extension
import kotlin.io.path.name

class SymbolicLinksUpdater {
	private val configsDir = "$dotfilesDirectory/symlinks"
	
	fun scanConfigs(): List<Pair<String, Symlinks>> = Files.walk(Path(configsDir))
		.filter { it.extension == "yml" || it.extension == "yaml" }
		.map { it.name to Yaml.Default.decodeFromString(Symlinks.serializer(), it.toFile().readText()) }
		.toList()

	fun update(symlinks: Symlinks) {
		val config = symlinks.symlinks

		for (symlink in config.links) {
			if (!Regex("^.+:.+$").matches(symlink)) {
				println("Skipping bad formatted symbolic link \"$symlink\"")
				continue
			}

			val parts = symlink.split(":")
			val destination = parts[0].toPath()
			val origin = parts[1].toPath()

			if (Files.notExists(origin)) {
				println("The file $origin cannot be linked because doesn't exists!")
				continue
			}
			
			if (Files.exists(destination) && !config.override) {
				continue
			}

			when {
				Files.exists(destination) && config.override -> Files.delete(destination)
				Files.isDirectory(destination) && config.override -> FileUtils.deleteDirectory(destination.toFile())
			}
			
			if (!Files.exists(destination.parent)) {
				Files.createDirectories(destination.parent)
			}

			Files.createSymbolicLink(destination, origin)
		}
	}

	/**
	 * Scan all symbolic links config files and update all symbolic links
  	 */
	fun updateAll() {
		val configs = scanConfigs()
		
		if (configs.isEmpty()) {
			return
		}

		for (config in configs) {
			update(config.second)
		}
	}
}
