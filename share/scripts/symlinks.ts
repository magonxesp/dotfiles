import {
	lstat,
	mkdir,
	readdir,
	readFile,
	rm,
	stat,
	symlink,
} from "node:fs/promises";
import { homedir } from "node:os";
import { dirname, extname, join, resolve } from "node:path";
import { env } from "node:process";
import { parse } from "yaml";

type Config = {
	override: boolean;
	links: string[];
};

function parseConfig(text: string, file: string): Config {
	const config = parse(text)?.symlinks;

	if (
		!config || typeof config.override !== "boolean" ||
		!Array.isArray(config.links) ||
		!config.links.every((link: unknown) => typeof link === "string")
	) {
		throw new Error(`Invalid symbolic links configuration: ${file}`);
	}

	return config;
}

async function scanConfigs(directory: string): Promise<string[]> {
	const files: string[] = [];

	for (const entry of await readdir(directory, { withFileTypes: true })) {
		const path = join(directory, entry.name);

		if (entry.isDirectory()) {
			files.push(...await scanConfigs(path));
		} else if (entry.isFile() && [".yml", ".yaml"].includes(extname(path))) {
			files.push(path);
		}
	}

	return files.sort();
}

function expandPath(path: string): string {
	return resolve(
		path === "~"
			? homedir()
			: path.startsWith("~/")
			? join(homedir(), path.slice(2))
			: path,
	);
}

export function isNotFound(error: unknown): boolean {
	return error instanceof Error && "code" in error && error.code === "ENOENT";
}

export async function loadConfigs(
	directory: string | undefined = env.DOTFILES_DIRECTORY,
) {
	if (!directory) {
		throw new Error("DOTFILES_DIRECTORY is not set");
	}

	const files = await scanConfigs(join(directory, "symlinks"));

	// Validate every configuration before changing any files.
	return await Promise.all(files.map(async (file) => ({
		file,
		config: parseConfig(await readFile(file, "utf8"), file),
	})));
}

export function parseLink(link: string) {
	const separator = link.indexOf(":");

	if (separator <= 0 || separator === link.length - 1) {
		console.warn(`Skipping bad formatted symbolic link "${link}"`);
		return null;
	}

	return {
		destination: expandPath(link.slice(0, separator)),
		origin: expandPath(link.slice(separator + 1)),
	};
}

export async function updateSymlinks(
	directory: string | undefined = env.DOTFILES_DIRECTORY,
): Promise<void> {
	const configs = await loadConfigs(directory);

	if (!configs.length) {
		console.log("Symbolic links configurations not found!");
		return;
	}

	for (const { file, config } of configs) {
		console.log(`Applying symbolic links configuration from ${file}`);

		for (const link of config.links) {
			const paths = parseLink(link);

			if (!paths) {
				continue;
			}

			const { destination, origin } = paths;

			if (destination === origin) {
				throw new Error(`Source and destination are the same: ${origin}`);
			}

			try {
				await stat(origin);
			} catch (error) {
				if (!isNotFound(error)) {
					throw error;
				}

				console.warn(
					`The file ${origin} cannot be linked because it does not exist!`,
				);
				continue;
			}

			let exists = false;

			try {
				await lstat(destination); // Also detects dangling symbolic links.
				exists = true;
			} catch (error) {
				if (!isNotFound(error)) {
					throw error;
				}
			}

			if (exists && !config.override) {
				continue;
			}

			// Do not remove a destination containing the source itself.
			if (exists && origin.startsWith(destination + "/")) {
				throw new Error(`Destination contains the source: ${destination}`);
			}

			if (exists) {
				await rm(destination, { recursive: true });
			}

			await mkdir(dirname(destination), { recursive: true });
			await symlink(origin, destination);
		}
	}

	console.log("Symbolic links updated!");
}

if (import.meta.main) {
	try {
		await updateSymlinks();
	} catch (error) {
		console.error(error instanceof Error ? error.message : String(error));
		Deno.exitCode = 1;
	}
}
