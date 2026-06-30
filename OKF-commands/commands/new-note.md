---
description: Create a new developer note in the vault following OKF conventions (frontmatter, links, index, log)
argument-hint: "[folder] [title]"
---

Create a new note in the vault based on $ARGUMENTS. The first argument is the folder (e.g. "01 - Programming/CSharp"), the second is the note title.

Read `CLAUDE.md` (vault schema) first. Then:

1. Place the file in the correct folder under the vault root. Use title-case for the filename (e.g. `Pattern Matching.md`).
2. Add a YAML frontmatter block at the very top:

```yaml
   ---
   type: <concept|pattern|reference|runbook|adr|project|log|...>   # REQUIRED - see taxonomy in CLAUDE.md
   title: "<the note title>"
   description: "<one sentence>"
   tags: [<domain>, <subdomain>]   # lowercase, hyphenated, derived from the folder path
   timestamp: <today, ISO 8601>
   ---
```
3. Start the body with `# Title` as the first line.
4. Use fenced code blocks with language identifiers where appropriate (```csharp, ```typescript, ```yaml).
5. Keep the note concise and practical - a personal reference, not documentation.
6. Add a `## Related` section at the bottom with `[[wiki links]]` to **at least one** existing note (no orphans).
7. Match the style of existing notes in the same folder (check for emoji prefixes in titles and follow suit).
8. Update that folder's `index.md`: add the note under its `type` group as `- [[path|Title]] - description` (or run `/summarise-section` on the folder to regenerate it).
9. Append to root `log.md` (newest-first): `## [YYYY-MM-DD] ingest | Created "<title>" in <folder>`.
