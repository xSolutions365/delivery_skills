# `revise-report`

Synthesises unstructured notes into the structured report. The single command
used both before the checkin (to fold in notes captured so far) and after it (to
fold in agreed amendments) — there is no separate "amend" command, because both
are the same job at different points in the period.

## Input

A period folder. Read every file in `notes/unprocessed/` (plain text or
markdown, no required structure). Also read the existing report file in the
folder, if one exists.

## Steps

1. **If no report file exists yet:** ask the user whether to start a blank draft
   from scratch, or use the previous period's report as a starting point first.
   If they choose the latter, follow `draft-report`'s carry-forward steps first,
   then continue below against the resulting scaffold. Note this is not a full
   `draft-report` run: derive `period_start`/`period_end` from the current
   period folder's own name (it already exists, unlike `draft-report`'s normal
   case of explicit dates as input) and skip `draft-report`'s folder-creation
   step entirely — only its content-copying/tagging logic applies, writing
   straight into the existing folder's report file.
2. Read every file currently in `notes/unprocessed/`.
3. For each section the notes actually speak to, merge the new information in —
   update or add to that section only. Leave every section the notes don't
   mention completely untouched (including any `[carried over — review]` tags
   already present from `draft-report` — don't remove or resolve those tags
   yourself; that's for the human during Refine, unless the notes explicitly
   confirm or contradict a specific carried-over item, in which case update that
   one item and remove its tag, citing the note that resolved it).
4. For the `Overall` section specifically: propose a status (`Red`/`Amber`/
   `Green`) **and a one-sentence reasoning** for each dimension the notes give
   you enough information to judge, using `RAG-definitions.md`'s Red/Amber/Green
   definitions as the rubric. Write the reasoning into the Details column
   alongside the status, prefixed `[suggested — confirm or override]`, e.g.:
   ```
   | Tech | Amber | [suggested — confirm or override] Notes mention a payment gateway timeout issue with a confirmed root cause but no deployed fix yet — matches Amber ("known technical issues... but a plan is in place"). |
   ```
   Never write a bare status with no reasoning, and never mark a suggested
   status as final — the human confirms every one during Refine, regardless of
   whether the notes are pre-meeting prep or a post-meeting record of what was
   actually agreed.
5. For sections the notes don't cover at all, leave them exactly as they were
   (untouched on merge) or blank (on a fresh create) — never invent content to
   fill a gap.
6. `Plan visual` is never populated by this command — a screenshot can't be
   produced from text notes. Leave it for the human to add during Refine.
7. Once the merge is written to the report file, move every note file that was
   actually read and folded in from `notes/unprocessed/` to `notes/processed/`.
   If a note file's content ended up not being used for any section (e.g. it was
   off-topic), still move it to `notes/processed/` — "processed" means "read and
   considered," not "every line used." An empty `notes/unprocessed/` after this
   step always means the draft reflects everything captured so far.

## Error handling

- `notes/unprocessed/` is empty and no report file exists → nothing to do; tell
  the user rather than creating an empty report file.
- A note file can't be read (e.g. binary/corrupt) → skip it, leave it in
  `notes/unprocessed/`, and tell the user rather than silently dropping it.
- `notes/unprocessed/` folder itself missing (not just empty) → create it before
  proceeding, don't error.

## Worked example

Given a note file in `notes/unprocessed/` reading:

```
Standup notes, 2026-08-15

- Checkout retry flow now fully rolled out to 100% of traffic, no issues
- Payment gateway timeout fix deployed and confirmed working under load
- Tom still out on leave, no backfill news yet
```

Run against a report file whose `Overall` table has `Tech: Amber` (reasoning:
"gateway timeout root cause found, fix not yet deployed") and `RAIDs: Amber`,
the merge should:
- Update the `Tech` row's suggested status to `Green`, with reasoning
  `[suggested — confirm or override] Notes confirm the payment gateway fix is
  now deployed and working under load — no known issues remain.`
- Leave the `RAIDs` row untouched, since the notes don't mention the second open
  RAID (Tom's backfill) being resolved.
- Move the note file to `notes/processed/`.
