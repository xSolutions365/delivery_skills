# Engagement Report Workflow

The full end-to-end workflow this skill is part of. Commands from this skill
automate steps 2, 3, and 5; step 8's destination is standardised by this skill's
account-repo structure, but the actual git commit/push stays manual.

1. **Capture** — throughout the period, the team keeps raw notes (freeform, no
   required structure). Manual, today and going forward — this is where the
   thinking happens. (Meeting transcripts, e.g. via Granola, are a planned
   future input for `revise-report` — not yet supported.) If nobody has
   written notes down, run `interview-report` instead — it asks you directly,
   in a structured round-based interview, and writes the answers into
   `notes/unprocessed/` in the same shape a hand-written note would take, so
   step 3 works exactly the same either way.
2. **Scaffold** — run `draft-report`, naming the engagement and this period's
   dates. Creates the period folder and starts the report file. If a previous
   period's report is found inside the same engagement folder, its content is
   copied forward — every section except Plan visual, which is always left
   blank for the human to refresh during Refine, since a stale screenshot
   silently carried into a new period is worse than an empty section — each
   carried-over item clearly marked and needing a human check (is this still
   accurate? did it happen?). If no previous report exists, creates a blank
   report from the template.
3. **Synthesize** — run `revise-report` against the notes captured so far,
   typically once before the checkin to get a solid draft in front of
   stakeholders. Merges the notes into the existing draft — proposing a RAG
   status per dimension with its reasoning, and populating Key points/Actions/
   RAIDs/Casting/Timeline from whatever the notes mention — always flagged as a
   draft judgement for the human to confirm or override.
4. **Refine** — the team reviews the draft: confirms/overrides the suggested RAG
   statuses, checks off or corrects the carried-over actions, corrects or adds
   detail, and drops in any screenshots (plan visual, etc.). Manual.
5. **Present** — run `present-report` against the refined folder. Produces one
   self-contained, paginated HTML report, styled to the standard CreateFuture
   template.
6. **Review & amend** — walk through the presentation live with key
   stakeholders in the checkin. Any changes agreed in the room are captured as
   notes (typed live or added straight after) and folded into the report by
   re-running `revise-report` on the same folder — the same synthesis step as
   #3, just triggered again with the meeting's notes as input. The presentation
   is never hand-edited — it's a generated artefact. Re-run `present-report` if
   the changes matter enough to reissue the report.
7. **Distribute** — a copy of the report is emailed to key stakeholders. Manual
   for now — candidate for future automation.
8. **Contribute** — the report, images, and presentation already live inside the
   account's reports repo, so this step is just committing (and pushing, once a
   remote exists) that folder. The commit/push action itself stays manual — this
   skill never commits or pushes on anyone's behalf.

**Which command runs after the meeting?** `revise-report` — the same command
used pre-meeting to fold in accumulated notes, run again with the meeting's
agreed changes as input. There's deliberately no separate "amend" command.

See `SKILL.md` for the full command reference, and
`examples/sample-team/northwind/2026-08-05_2026-08-12/` for a worked example.
