package io.github.magonxesp.dotfiles

val dotfilesRootDirectory: String = System.getenv("DOTFILES_ROOT_DIRECTORY")
	?: error("The environment variable DOTFILES_ROOT_DIRECTORY does not exists")
val dotfilesDirectory: String = System.getenv("DOTFILES_DIRECTORY")
		?: error("The environment variable DOTFILES_DIRECTORY does not exists")
