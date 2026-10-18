import { readFile } from "node:fs/promises";

type Colors = {
	color: string[];
	background: string;
	foreground: string;
};

export function toKittyConf(value: unknown): string {
	const colors = value as Partial<Colors> | null;

	if (
		!colors || !Array.isArray(colors.color) ||
		colors.color.length !== 16 ||
		!colors.color.every((color: unknown) => typeof color === "string") ||
		typeof colors.background !== "string" ||
		typeof colors.foreground !== "string"
	) {
		throw new Error(
			"Expected background, foreground and an array of 16 colors",
		);
	}

	const comments = [
		"black",
		"red",
		"green",
		"yellow",
		"blue",
		"magenta",
		"cyan",
		"white",
	];

	let conf = "# Color Scheme\n\n";

	conf += `background ${colors.background}\n`;
	conf += `foreground ${colors.foreground}\n\n`;

	for (let i = 0; i < comments.length; i++) {
		conf += `color${i} ${colors.color[i]}\n`;
		conf += `color${i + 8} ${colors.color[i + 8]}\n`;
		conf += `#: ${comments[i]}\n\n`;
	}

	return conf;
}

if (import.meta.main) {
	try {
		const path = Deno.args[0];

		if (!path) {
			throw new Error("The JSON file path argument is required");
		}

		const colors: unknown = JSON.parse(await readFile(path, "utf8"));

		console.log(toKittyConf(colors));
	} catch (error) {
		console.error(error instanceof Error ? error.message : String(error));
		Deno.exitCode = 1;
	}
}
