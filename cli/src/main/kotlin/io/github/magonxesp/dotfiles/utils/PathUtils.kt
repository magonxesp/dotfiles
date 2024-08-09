package io.github.magonxesp.dotfiles.utils

import kotlin.io.path.Path

fun String.toPath() = when {
	startsWith("~") -> Path(replace(Regex("^~"), System.getProperty("user.home")))
	else -> Path(this)
}
