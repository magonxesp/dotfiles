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
import { cleanSymlinks } from "./clean-symlinks.ts";

Deno.test("cleans only configured broken symlinks, following their actual targets", async () => {
	const root = await mkdtemp(join(tmpdir(), "clean-symlinks-"));

	try {
		await mkdir(join(root, "symlinks", "nested"), { recursive: true });
		await mkdir(join(root, "directory"));
		await writeFile(join(root, "file"), "keep");
		await symlink("file", join(root, "valid"));
		await symlink("directory", join(root, "valid-directory"));
		await symlink("missing", join(root, "broken with spaces"));
		await symlink("missing", join(root, "unconfigured"));

		await writeFile(
			join(root, "symlinks", "nested", "links.yaml"),
			stringify({
				symlinks: {
					override: false,
					links: [
						`${root}/broken with spaces:${root}/file`,
						...["valid", "valid-directory", "file", "directory", "absent"].map(
							(name) => `${root}/${name}:${root}/missing`,
						),
						"malformed",
					],
				},
			}),
		);

		await cleanSymlinks(root);
		await cleanSymlinks(root);

		await assert.rejects(lstat(join(root, "broken with spaces")), {
			code: "ENOENT",
		});
		assert.equal(await readlink(join(root, "unconfigured")), "missing");
		assert.equal(await readlink(join(root, "valid")), "file");
		assert.equal(await readlink(join(root, "valid-directory")), "directory");
		assert.equal(await readFile(join(root, "file"), "utf8"), "keep");
		assert.ok((await lstat(join(root, "directory"))).isDirectory());

		await symlink("missing", join(root, "broken with spaces"));
		await writeFile(join(root, "symlinks", "invalid.yml"), "symlinks: null");

		await assert.rejects(
			cleanSymlinks(root),
			/Invalid symbolic links configuration/,
		);
		assert.ok((await lstat(join(root, "broken with spaces"))).isSymbolicLink());
	} finally {
		await rm(root, { recursive: true, force: true });
	}
});
