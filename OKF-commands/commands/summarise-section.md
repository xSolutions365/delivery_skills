---
description: Summarise all notes in a folder and (re)generate that folder's index.md Map of Content
argument-hint: "[folder]"
---

Summarise the notes in the folder specified by $ARGUMENTS, and refresh that folder's `index.md`.

Steps:
1. List all markdown files in the given folder under the vault root (exclude the folder's own `index.md`).
2. Read each note's frontmatter and body.
3. **(Re)generate `index.md`** in that folder with:
   - frontmatter - `type: moc`, `title: "<Folder> - Index"`, a one-line `description`, `tags` from the folder path, today's `timestamp`.
   - a `# <Folder> - Index` heading and a `> [!note] Map of Content` callout.
   - a `## Subsections` list linking child folders' indexes, path-qualified: `- [[<path>/index|<Child>]]`.
   - notes grouped by `type` in this order - concept, pattern, reference, runbook, adr, source, project, log, competency - each as `- [[<path>|Title]] - <one-line description>` (pull the description from frontmatter where present).
4. Also print a short human-readable summary: total note count and any notable cross-links within the section.
5. Keep descriptions to one line; don't pad.
