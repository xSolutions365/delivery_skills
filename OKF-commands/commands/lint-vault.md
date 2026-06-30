---
description: Health-check the whole vault — broken links, orphans, stale or missing frontmatter, index drift, and knowledge gaps
---

Run a health check over the vault and report findings grouped by category. **Do not auto-fix destructively** - propose fixes and confirm before sweeping changes.

Read `CLAUDE.md` (vault schema) first, then check:

1. **Broken links** - every `[[wiki link]]` resolves to an existing note. Obsidian matches by basename; `index.md` links are path-qualified, so resolve those by path. Report file + line + the broken link.
2. **Frontmatter** - every note has a frontmatter block with at least a `type`. Flag missing/invalid blocks and any `type` outside the taxonomy in `CLAUDE.md`.
3. **Orphans** - notes with no inbound `[[links]]` from any other note or index.
4. **Index drift** - every content folder has an `index.md`; every note is listed in its folder's index; index links resolve.
5. **Stale / weak metadata** - `timestamp`s far older than the file's last git change; empty or obviously auto-generated `description`s; notes missing a `## Related` section.
6. **Knowledge gaps** - concepts referenced across notes that lack their own page; obvious missing cross-references; contradictions where a newer source supersedes an older claim.
7. Suggest new questions to investigate and sources worth clipping.

Finish by appending a `log.md` entry (newest-first): `## [YYYY-MM-DD] lint | <one-line summary of findings>`.

This is the superset of `/validate-links` (which only does step 1).
