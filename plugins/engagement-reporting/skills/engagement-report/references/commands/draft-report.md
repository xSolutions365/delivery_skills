# `draft-report`

Mechanically scaffolds a new reporting period — no notes involved, no synthesis.
Run once at the start of each period.

## Input

- An engagement folder — existing (with zero or more prior period folders inside
  it) or brand new.
- This period's start and end dates (`YYYY-MM-DD` each).

## Steps

1. Compute the period folder name: `{period_start}_{period_end}`, e.g.
   `2026-08-19_2026-08-26`.
2. Look inside the engagement folder for existing period folders (named
   `YYYY-MM-DD_YYYY-MM-DD`), **excluding the period folder this command is
   about to create** (i.e. the folder named `{period_start}_{period_end}` from
   step 1) — only other, already-existing period folders count as "previous."
   If any exist, the **most recent** is the one whose `period_end` (the second
   date in its folder name) sorts latest — ISO date strings sort correctly
   with a plain lexical/string comparison, no date parsing required.
3. Create the new period folder:
   ```
   {engagement-folder}/{period_start}_{period_end}/
   ├── notes/
   │   ├── unprocessed/    (empty)
   │   └── processed/      (empty)
   ```
4. Create the new report file, named
   `{engagement-folder-name}-{period_start}_{period_end}-report.md`:
   - **If a previous period folder was found in step 2:** read its report file
     in full and copy its entire content into the new report file, with every
     carried-over item tagged `[carried over — review]`:
     - `Actions` — the previous report's "Decisions for next period" **and**
       its `Actions` section both become this report's starting point: copy the
       previous `Actions` section as-is (owners and items), tag every item
       `[carried over — review: did this happen?]`.
     - `Overall`, `Key RAIDs`, `Casting`, `Timeline` — copy as-is from the
       previous report, tag every row/item `[carried over — review: still
       accurate?]`.
     - `Key points` — copy as-is; the previous period's "Decisions for next
       period" list doubles as a starting prompt for what this period was meant
       to deliver, tagged `[carried over — review]`.
     - `Plan visual` — never carried forward. Leave this section blank in the
       new report, exactly as in the "no previous report found" branch below —
       a screenshot's content is period-specific, and carrying one forward
       (tagged or not) either dangles a reference to an image file that was
       never copied into the new period folder (step 3 only scaffolds
       `notes/`), or silently presents a stale screenshot as if it were
       current. The human adds a fresh one during Refine, same as any other
       period.
     - Update the frontmatter's `period_start`/`period_end` to the new period's
       dates (everything else in frontmatter — `engagement`, `team_leadership`,
       `client_logo` — carries forward unchanged, since those describe the
       engagement itself, not the period).
     - Do not interpret, summarise, or otherwise change the copied content —
       only copy and tag. Turning notes into new or updated content is
       `revise-report`'s job, run next.
   - **If no previous period folder was found** (brand new engagement, or this
     is the first period): write a blank report file — frontmatter with
     `engagement`/`team_leadership`/`client_logo` left as placeholders for the
     user to fill in (or supplied if given as part of this command's input),
     `period_start`/`period_end` set to this period's dates, and the following
     blank skeleton for each `#`-level section — matching exactly the
     sub-heading text and table columns `present-report`'s parser expects,
     nothing invented beyond that shape:
     - `Overall` — a markdown table with header row
       `| Dimension | RAG Status | Details |` and one blank row per dimension,
       in this exact order (matching `RAG-definitions.md`): Overall, Plan,
       RAIDs, Tech, Team, Commercial, InfoSec & Compliance. Leave the `RAG
       Status` and `Details` columns blank for each row, e.g.:
       ```markdown
       | Dimension | RAG Status | Details |
       | --------- | ---------- | ------- |
       | Overall | | |
       | Plan | | |
       | RAIDs | | |
       | Tech | | |
       | Team | | |
       | Commercial | | |
       | InfoSec & Compliance | | |
       ```
     - `Key points` — the two `##` sub-headings `Value delivered this period`
       and `Decisions for next period`, both with no list items yet.
     - `Plan visual` — left with just the `#` heading, no image reference (per
       the rule above — never populated by `draft-report`).
     - `Actions` — left with just the `#` heading, no owner sub-headings yet
       (those get added by `revise-report` or manually).
     - `Key RAIDs` — a markdown table with header row
       `| Type | Category | Raised | Detail | Next steps |` and no data rows.
     - `Casting` — a markdown table with header row
       `| Who | Role | Grade | Start date | End date | Notes |` and no data
       rows.
     - `Timeline` — left with just the `#` heading, no milestones yet.

## Error handling

- More than one folder in the engagement folder matches the same `period_end`
  date → ask the user which one is the actual previous period, rather than
  picking arbitrarily.
- Engagement folder path doesn't exist and wasn't explicitly requested as "brand
  new" → ask for confirmation before creating it.
- The target period folder (`{period_start}_{period_end}`) already exists →
  stop and ask before doing anything; never overwrite an existing report file.

## Worked examples

**Brand new engagement** (no previous period): run `draft-report` against a
fresh `examples/sample-team/northwind/` with dates `2026-08-05` to `2026-08-12`
→ produces the blank-scaffold report seen (in its now-filled-in final form) at
`examples/sample-team/northwind/2026-08-05_2026-08-12/`.

**Rolling to a new period**: run `draft-report` against
`examples/sample-team/northwind/` with dates `2026-08-19` to `2026-08-26` → finds
`2026-08-05_2026-08-12/` as the previous period, and produces a new
`2026-08-19_2026-08-26/northwind-2026-08-19_2026-08-26-report.md` whose `Actions`
section reads:

```markdown
# Actions

## Amy Chen
- [carried over — review: did this happen?] Present the checkout retry flow results to the Northwind product team
- [carried over — review: did this happen?] Draft the Q4 roadmap proposal for review

## Ben Osei
- [carried over — review: did this happen?] Finish the payment-gateway timeout write-up and share with the platform team
- [carried over — review: did this happen?] Investigate the second open RAID (see Key RAIDs)
```
