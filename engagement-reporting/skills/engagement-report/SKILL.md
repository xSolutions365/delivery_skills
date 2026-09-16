---
name: engagement-report
description: Scaffold, draft, revise, and present weekly/fortnightly engagement checkin reports for consulting teams, and manage the account-level repo that holds them across engagements. Use when a team wants to start a new reporting period, fold meeting/raw notes into a draft, get interviewed directly when they don't have written notes, turn a draft into a presentation, or set up/extend the account repo that stores engagement reports.
---

# Engagement Report

Turns a lightweight markdown report, authored collaboratively by a delivery team,
into a standardised CreateFuture-branded presentation for client stakeholder
checkins — and manages the folder structure and account-level repo that report
lives in.

See `WORKFLOW.md` for the full end-to-end workflow this skill is part of, and
`RAG-definitions.md` for the RAG rubric every report's `Overall` section uses.

## Commands

| Command | Use when | Reference |
|---|---|---|
| `draft-report` | Starting a new reporting period | `references/commands/draft-report.md` |
| `revise-report` | Folding raw or meeting notes into the current draft (before or after the checkin) | `references/commands/revise-report.md` |
| `interview-report` | You don't have written notes — get interviewed directly instead | `references/commands/interview-report.md` |
| `present-report` | Turning a refined draft into the presentation | `references/commands/present-report.md` |
| `init-reports-repo` | Setting up a brand-new account's reports repo | `references/commands/init-reports-repo.md` |
| `add-engagement` | Adding a new engagement to an existing account repo | `references/commands/add-engagement.md` |

## Dispatch

1. Identify which command the user's request maps to, using the table above.
   If it's ambiguous (e.g. "update the report" could mean `revise-report` or
   `present-report`), ask which they mean rather than guessing.
2. Read the matching file under `references/commands/` in full before doing
   anything — each one contains that command's complete input contract, steps,
   error handling, and a worked example.
3. Follow that file's steps exactly, using your own Read/Write/Bash tools to
   perform the file operations it describes. There is no separate script to
   run — the reference file's steps **are** the implementation.
4. If a step in the reference file says to ask the user something, ask — don't
   guess or fabricate an answer to keep moving.

## Presentation template

`references/template.html` is the paginated HTML/CSS/JS renderer `present-report`
populates. See that command's reference file for exactly how its
`const REPORT = {...}` data block gets built from a report file's contents.

## Example

`examples/sample-team/northwind/2026-08-05_2026-08-12/` is a complete, fictional
worked example (engagement, client, and all names invented for this repo) —
useful for trying any command against real-shaped data before using this skill
on an actual engagement.
