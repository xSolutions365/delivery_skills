# Instructions for the assistant

This file and `AGENTS.md` must stay identical — the preflight checklist
checks `diff CLAUDE.md AGENTS.md` returns nothing. Edit both together.

This is a shared team vault for **[Engagement name]**. Read
`project-config.md` first — it is the manifest every skill reads before doing
anything else.

## What must never go in a shared file

- Budgets, rates, margins, PO values, per-person allocation
- Personnel commentary, performance, availability
- Off-record client context, political dynamics, candid views on named
  individuals

If material contains any of this, file what is safe, say plainly what was
left out, and why.

## The guard

A pre-commit check runs before anything is shared. It blocks: a shared `.md`
file with no `classification` set, a `classification: private` file outside
an ignored path, anything over 50 MB, and the phrases in
`SETUP/hooks/blocked-terms.txt`. When it blocks something, it names the file,
the reason, and the fix. **Never work around it and never commit with
`--no-verify`.** If the reason genuinely doesn't apply, that's a conversation
with the DM about adjusting the rule — not a reason to bypass it.

## Private space

`users/<name>/` and `00-inbox-local/` are gitignored — never synced, never
seen by anyone else, not backed up. Never move their contents into a shared
folder without running `capture` and getting an explicit yes.

## The skills

`capture` and `onboard` are what the team uses day to day — see
`SETUP/user-guide.html`. The rest
(`configure-engagement`, `define-roles`, `seed-references`, `harden-vault`,
`launch-checklist`, `close-out-engagement`) are mobilisation and close-out
tooling — see `SETUP/dm-guide.html`.
