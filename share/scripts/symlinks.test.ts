import { strict as assert } from "node:assert";
import {
	lstat,
	mkdir,
	mkdtemp,
	readFile,
	readlink,
	rm,
	symlink,
	writeFile,
} from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { stringify } from "yaml";
import { updateSymlinks } from "./symlinks.ts";

Deno.test("creates links, replaces directories and broken links, and is repeatable", async () => {
	const root = await mkdtemp(join(tmpdir(), "dotfiles-"));

	try {
		await mkdir(join(root, "symlinks", "nested"), { recursive: true });

		const source = join(root, "source with spaces");
		await writeFile(source, "content");

		const destination = join(root, "new parent", "link");
		const directory = join(root, "directory");
		const broken = join(root, "broken");

		await mkdir(directory);
		await writeFile(join(directory, "old"), "old");
		await symlink(join(root, "missing"), broken);

		await writeFile(
			join(root, "symlinks", "nested", "links.yaml"),
			stringify({
				symlinks: {
					override: true,
					links: [destination, directory, broken].map((path) =>
						`${path}:${source}`
					),
				},
			}),
		);

		await updateSymlinks(root);
		await updateSymlinks(root);

		for (const path of [destination, directory, broken]) {
			assert.equal(await readlink(path), source);
			assert.equal(await readFile(path, "utf8"), "content");
		}
	} finally {
		await rm(root, { recursive: true, force: true });
	}
});

Deno.test("preserves existing destinations and skips missing or malformed sources", async () => {
	const root = await mkdtemp(join(tmpdir(), "dotfiles-"));

	try {
		await mkdir(join(root, "symlinks"));

		const source = join(root, "source");
		const destination = join(root, "destination");
		const broken = join(root, "broken");

		await writeFile(source, "source");
		await writeFile(destination, "keep");
		await symlink(join(root, "missing"), broken);

		await writeFile(
			join(root, "symlinks", "links.yml"),
			stringify({
				symlinks: {
					override: false,
					links: [
						`${destination}:${source}`,
						`${broken}:${source}`,
						`${root}/skipped:${root}/missing`,
						"malformed",
					],
				},
			}),
		);

		await updateSymlinks(root);

		assert.equal(await readFile(destination, "utf8"), "keep");
		assert.equal(await readlink(broken), join(root, "missing"));
		await assert.rejects(lstat(join(root, "skipped")), { code: "ENOENT" });

		await writeFile(
			join(root, "symlinks", "invalid.yml"),
			"symlinks: { override: yes, links: [] }",
		);

		await assert.rejects(
			updateSymlinks(root),
			/Invalid symbolic links configuration/,
		);
	} finally {
		await rm(root, { recursive: true, force: true });
	}
});
