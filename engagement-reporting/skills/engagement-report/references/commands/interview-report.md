# `interview-report`

An alternative front door into the same pipeline `revise-report` already feeds
— for when you don't have written notes to hand it. Instead of reading
`notes/unprocessed/`, this command generates the equivalent notes by asking
you directly, in a structured interview. It writes a note file and hands off
to `revise-report` — it never merges content into the report itself, so
there's no duplicated merge logic to maintain.

## Input

A period folder — same input as `revise-report`. If no report file exists
yet, follow `revise-report`'s own "no report file yet" branch first: ask
whether to start a blank draft from scratch, or use the previous period's
report as a starting point (delegating to `draft-report`'s carry-forward
logic, deriving `period_start`/`period_end` from the folder's own name and
skipping its folder-creation step, exactly as `revise-report` already does),
then interview against the resulting scaffold.

## Interview format

Interview in rounds, following the same format as the `grilling` skill:

```
❓ **Q1** - **<question title>**: <question body>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body>

➡️ <your recommended answer>
```

Ask the whole frontier — everything answerable right now — in one round,
wait for answers, then ask any follow-ups the answers raised in the next
round. Stop when nothing is left uncovered: every section addressed, nothing
silently assumed.

### Round 1 — one question per report section

For each question, the recommended answer comes from the report file's
current content if there's something to carry forward (a carried-over item
tagged `[carried over — review]` from `draft-report`, or an existing
suggested value from a prior `revise-report` run) — never invent a
recommendation from nothing. Where there's genuinely no prior data, say so
plainly ("no prior data — what's the status?") rather than guessing a
default.

1. **Overall** — show all seven RAG dimensions (Overall, Plan, RAIDs, Tech,
   Team, Commercial, InfoSec & Compliance) with their current status and
   detail (carried-over or blank). For each, ask: still accurate, or what's
   changed? Recommend the carried-over status if present, using
   `RAG-definitions.md`'s rubric to explain why it would or wouldn't still
   hold.
2. **Key points** — show the carried-over "Decisions for next period" (now
   this period's expected deliverables, if `draft-report` carried them
   over). Ask: what was actually delivered this period, and what's next?
3. **Actions** — show the carried-over actions list, each tagged
   `[carried over — review: did this happen?]`. Ask, per action: done,
   still open, or dropped? Also ask if there are any brand-new actions.
4. **Key RAIDs** — show the carried-over RAID rows. Ask: still accurate,
   any updates, any newly closed? Also ask if there's anything new to
   raise.
5. **Casting** — show the carried-over team roster. Ask: any changes —
   joiners, leavers, role changes?
6. **Timeline** — show the carried-over milestones. Ask: any new milestones
   or dates to add this period?

Do not ask about `Plan visual` — a screenshot can't come from an interview
answer, same rule as `revise-report`.

### Round 2+ — follow-ups only

Ask follow-up questions only where a round 1 answer needs more detail to be
usable — a new RAID needs its type/category/next steps; a new action needs
an owner; a new casting change needs role/grade/dates; a new timeline
milestone needs an exact date. Skip straight to writing the note if round 1
left nothing open.

## Steps

1. Run the interview per the format above until nothing is left uncovered.
2. Write the answers as a single new note file into `notes/unprocessed/`,
   named `{today's date}-interview.md`. Structure it with `#`-level headings
   matching the report's own section names — `Overall`, `Key points`,
   `Actions`, `Key RAIDs`, `Casting`, `Timeline`, in that order — each
   holding the interview's answers for that section as plain prose or
   bullets. Omit any heading the interview left with nothing to report
   under it — don't write an empty section. Never write a `Plan visual`
   heading; that's `revise-report`'s existing rule too, and this command
   never touches it either.
3. Ask the user: run `revise-report` on this note now, or leave it queued
   in `notes/unprocessed/` for later? If they say run it now, follow
   `revise-report`'s own steps immediately against the note just written.
   If they say later, stop here — the note is already in the right place
   for whenever `revise-report` next runs.

## Error handling

- The user was never actually asked about a section, or explicitly skips
  it with no answer at all → omit that section from the note entirely,
  don't write a heading with no content.
- The user confirms a carried-over section is still accurate ("Casting —
  no changes," "RAIDs both still open, nothing new") → **this counts as
  an answer, not as nothing to add.** Write it under that section's
  heading (e.g. "No changes to Casting since last period."). A bare
  confirmation is exactly what lets `revise-report` resolve and clear the
  `[carried over — review]` tags on that section — omitting it would
  leave those tags dangling for a human to sort out later, defeating the
  point of having asked. Only genuinely-unasked/unanswered sections get
  omitted.
- The user gives a contradictory or incomplete answer (e.g. "yes it's
  done" with no detail on when/how) → ask a clarifying follow-up rather
  than guessing what to write.

## Worked example

Interviewing against a report file whose `Overall` table has `Tech: Amber`
(carried over, reasoning: "gateway timeout root cause found, fix not yet
deployed"):

```
❓ **Q1** - **Overall**: Here's last period's status per dimension — anything
changed?

| Dimension | Last period | Detail |
| --------- | ----------- | ------ |
| Tech      | Amber       | gateway timeout root cause found, fix not yet deployed |
| RAIDs     | Amber       | [carried over — review] |
| ...       | ...         | ... |

➡️ Tech is probably Green now if the fix shipped — worth confirming.

---

❓ **Q2** - **Actions**: ...
```

If the user answers "Tech — yes, fix deployed and confirmed working, no
issues," the resulting note
(`notes/unprocessed/2026-08-19-interview.md`) includes:

```markdown
# Overall

Tech: fix deployed and confirmed working under load, no known issues
remain.
```

Running `revise-report` against this note updates the `Tech` row's
suggested status to `Green`, following its own existing merge logic exactly
as it would for any hand-written note.
