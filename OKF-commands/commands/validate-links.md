---
description: Check for broken wiki links across the vault
---

Scan all markdown files in the vault for broken Obsidian `[[wiki links]]`.

Steps:
1. Find all markdown files in the vault.
2. Extract all `[[Link]]` and `[[Link|Display Text]]` patterns from each file (ignore links inside code blocks).
3. For each link, check that a matching note exists. Obsidian matches plain links by **filename only** (not path); `index.md` links in Map-of-Content files are **path-qualified** (`[[08 - Architecture/Azure/index|Azure]]`), so resolve those by their full path.
4. Report any broken links grouped by file, showing the line number and the broken link text.
5. If no broken links are found, confirm the vault is clean.

For a fuller health check (orphans, frontmatter, stale metadata, index drift), use `/lint-vault`.
