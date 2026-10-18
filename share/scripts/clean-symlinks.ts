import { lstat, stat, unlink } from "node:fs/promises";
import { isNotFound, loadConfigs, parseLink } from "./symlinks.ts";

export async function cleanSymlinks(directory?: string): Promise<void> {
	const configs = await loadConfigs(directory);

	for (const { file, config } of configs) {
		console.log(`Cleaning broken symbolic links configured in ${file}`);

		for (const link of config.links) {
			const paths = parseLink(link);

			if (!paths) {
				continue;
			}

			const { destination } = paths;

			try {
				const entry = await lstat(destination);

				if (!entry.isSymbolicLink()) {
					continue;
				}
			} catch (error) {
				if (isNotFound(error)) {
					continue;
				}

				throw error;
			}

			// Follow the actual link, which may differ from the configured origin.
			try {
				await stat(destination);
			} catch (error) {
				if (!isNotFound(error)) {
					throw error;
				}

				await unlink(destination);
				console.log(`Removed broken symbolic link: ${destination}`);
			}
		}
	}
}

if (import.meta.main) {
	try {
		await cleanSymlinks();
	} catch (error) {
		console.error(error instanceof Error ? error.message : String(error));
		Deno.exitCode = 1;
	}
}
