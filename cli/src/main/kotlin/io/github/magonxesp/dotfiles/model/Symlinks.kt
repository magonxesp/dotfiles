package io.github.magonxesp.dotfiles.model

import kotlinx.serialization.Serializable

@Serializable
class Symlinks(
	val symlinks: Config
) {
	@Serializable
	class Config(
		val override: Boolean,
		val links: List<String>
	)
}
