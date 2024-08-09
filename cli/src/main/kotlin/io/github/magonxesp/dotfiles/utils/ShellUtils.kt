package io.github.magonxesp.dotfiles.utils

import java.io.File
import java.nio.file.Paths
import java.util.concurrent.TimeUnit

fun exec(command: String, workingDir: String? = null) {
	val currentWorkingDirectory = Paths.get("").toAbsolutePath().toString()

	ProcessBuilder(*command.split(" ").toTypedArray())
		.directory(File(workingDir ?: currentWorkingDirectory))
        .redirectOutput(ProcessBuilder.Redirect.INHERIT)
        .redirectError(ProcessBuilder.Redirect.INHERIT)
        .start()
        .waitFor(60, TimeUnit.MINUTES)
}
