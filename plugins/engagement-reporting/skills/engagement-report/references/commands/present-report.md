# `present-report`

Turns a period folder's report file into a self-contained, paginated HTML
presentation, styled to the standard CreateFuture template.

## Input

One period folder, given as a path. Look only at its top level — never recurse
into `notes/` (its contents may themselves be `.md` files, and are not report
content):

- Exactly one `.md` file at the top level — the report. If zero or more than one
  are found, ask the user which file is the report rather than guessing.
- Zero or more image files at the top level — screenshots referenced by the report.

Confirm the period folder is nested one level inside an engagement folder (i.e.
its parent directory is not the account repo root or something unexpected). If
it isn't, ask the user for the correct location rather than guessing an
engagement name.

## Steps

1. Read the report file's frontmatter (`engagement`, `period_start`, `period_end`,
   `team_leadership`, optional `client_logo`) and body sections.
2. Parse each `#`-level section into the shape `template.html`'s `REPORT` object
   expects:
   - `Overall` → `overall: [{ dimension, status, detail }, ...]`, one entry per
     table row, in the order the rows appear. `status` must be exactly `Red`,
     `Amber`, or `Green` — if a row's status word doesn't match one of these
     three (case-insensitive is fine, normalize to title case), ask the user
     rather than guessing which colour was intended.
   - `Key points` → `key_points: { delivered: [...], next: [...] }` from the
     "Value delivered this period" / "Decisions for next period" lists. If the
     section is absent, set `key_points: null`.
   - `Actions` → `actions: [{ owner, items: [...] }, ...]`, one entry per `##`
     sub-heading (the owner's name) under `# Actions`.
   - `Key RAIDs` → `raids: [{ type, category, raised, detail, next_steps }, ...]`,
     one entry per table row.
   - `Casting` → `casting: [{ who, role, grade, start, end, notes }, ...]`, one
     entry per table row.
   - `Timeline` → `timeline: [{ date, label }, ...]` parsed from the dated list.
   - Any section entirely absent from the markdown → its `REPORT` field is `null`
     (`key_points`, `plan_visual`) or `[]` (`raids`, `casting`, `timeline`,
     `actions`). Never fabricate a section that isn't there.
3. Resolve the plan visual image:
   - **Explicit** — if the markdown contains an image ref (`![](filename.png)`)
     anywhere, use that file.
   - **Inferred** — otherwise, look for an image file at the top level whose name
     contains `plan`, `burndown`, or `roadmap` (case-insensitive).
   - If more than one image matches (explicit or inferred), ask the user which
     file to use rather than guessing. If a `Plan visual` heading exists but zero
     images can be resolved, treat it the same as any other absent optional
     section — `plan_visual: null`, no question asked.
   - `Timeline` is never resolved from an image — it always comes from the parsed
     milestone list (step 2 above), never a screenshot.
4. Read the resolved plan visual image file (if any) and base64-encode it into a
   `data:image/<type>;base64,...` URI for `REPORT.plan_visual`. Do the same for
   `client_logo` if the frontmatter specifies one. This keeps the output file
   fully self-contained — no external file references.
5. Before writing the output file, scan all parsed section content (every
   string that ended up in `overall[].detail`, `key_points`, `actions[].items`,
   `raids[].detail`/`next_steps`, `casting[].notes`, and any other free-text
   field) for the literal substrings `[carried over` or `[suggested —`. These
   are the tags `draft-report` and `revise-report` stamp into content
   specifically so a human catches and resolves them during Refine — if any
   are still present, the report hasn't been fully refined yet. If any are
   found, tell the user which section(s) still contain unresolved review tags
   and ask them to confirm they want to generate the presentation anyway
   (don't block silently, don't refuse outright — just surface it and let the
   human decide).
6. Copy `references/template.html` and replace its `const REPORT = { ... };`
   block (between the `/* ── DATA ── */` and `/* ── END DATA ── */` markers)
   with the populated object from steps 2–4.
7. Determine the output filename per the naming rule: the period folder's own
   name (e.g. `2026-08-05_2026-08-12`) prefixed with its parent engagement
   folder's name (e.g. `northwind`), giving
   `northwind-2026-08-05_2026-08-12-presentation.html`. Write the file into the
   same period folder, alongside the report file.

## Error handling

- Missing `Overall` data, or a row with no recognizable Red/Amber/Green status →
  ask the user, never default to a colour.
- Optional section absent → omit that slide entirely (verified structurally by
  `buildSlides()`'s `.filter(Boolean)` in `template.html` — do not add a
  placeholder page).
- Ambiguous image resolution (multiple candidates) → ask the user which to use.
- Zero or multiple `.md` files at the period folder's top level → ask which one
  is the report.
- Period folder not nested inside an engagement folder → ask for the correct
  location.
- Unresolved `[carried over` or `[suggested —` review tags found in any parsed
  section → tell the user which section(s), and ask them to confirm before
  generating the presentation anyway.

## Worked example

See `examples/sample-team/northwind/2026-08-05_2026-08-12/` for a complete
fictional report file this command can be run against, producing
`northwind-2026-08-05_2026-08-12-presentation.html`.
