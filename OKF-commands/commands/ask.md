---
description: Answer a question against the vault with citations, and file good answers back into the vault as new pages
argument-hint: "[question]"
---

Answer the question in $ARGUMENTS using the vault as the source of truth (the **Query** operation from `CLAUDE.md`).

1. Read the relevant `index.md`(s) first to locate pages, then read the linked notes.
2. Answer concisely, **with citations** to the notes you used (as `[[wiki links]]`).
3. If the answer synthesises something worth keeping - a comparison, an analysis, a newly discovered connection - offer to **file it back** as a new `concept` / `pattern` / `reference` note: with full frontmatter, a `## Related` section, and an update to the folder's `index.md`. This way explorations compound in the wiki instead of disappearing into chat.
4. When you file an answer, append a `log.md` entry (newest-first): `## [YYYY-MM-DD] query | <question> -> filed <note>`.
5. If the wiki doesn't contain the information, say so plainly and suggest where to look next.
