---
name: close-out-engagement
description: Wind down a vault at the end of an engagement. Use when someone says "close out the engagement", "wrap up this vault", "archive this engagement", or the phase tracker shows the final phase complete. Extracts the value register and lessons learned into a portfolio-level summary, checks nothing private or client-restricted is about to be archived somewhere more visible, and marks the vault archived rather than deleting or repurposing it.
---

# close-out-engagement

An engagement vault's working life ends; the value and lessons in it should
not. This skill's job is to pull the two files that matter beyond this single
engagement — `06-value-and-lessons/value-register.md` and
`lessons-learned.md` — into a form the wider portfolio can actually use, and
to leave the vault itself intact and clearly marked as closed, not deleted or
quietly repurposed for the next client.

Run this once, at the end, with the DM. It touches governance-sensitive
content, so nothing here should surprise them.

## Step 1 — Confirm this is really the end

Check `04-delivery/phase-tracker.md` and ask the DM directly: is the
engagement actually finishing, or is this a phase boundary (Assess ending,
Roadmap starting)? **Only run this at genuine close-out.** A vault mid-phase
gets nothing from being archived, and the same folder set is very likely to
be reused for the next phase of the same engagement — do not force a
close-out to fit a milestone that isn't one.

## Step 2 — Extract the value register

Read `06-value-and-lessons/value-register.md` in full, including its `## The
baseline` section. Produce a portfolio-facing summary: the QBL story points
by dimension (Quicker / Better / Leaner), with their evidence sources kept
as links back into this vault rather than restated as prose claims — a
reader who wants to check a story should be able to click through to it.

**Do not editorialise the numbers.** If the register says a comparison was
never made (`[TBC]`), the summary says the same, not a rounded-up estimate.
This file may travel further than the vault itself — to a portfolio lead, a
case-study draft, a bid team — and an inflated claim here is much harder to
retract once it has been repeated elsewhere.

## Step 3 — Extract lessons learned

Read `06-value-and-lessons/lessons-learned.md`. Carry every lesson forward
as written — these already passed the "would the person named be comfortable
reading this" test at capture time, and this is not the place to relitigate
that. Group them by theme if there are enough to need it; do not rewrite
their substance.

## Step 4 — Check what is about to become more visible

A portfolio-level summary is read by more people than this vault's team.
Before writing it anywhere outside this vault:

- Re-run the same sensitive-term grep the preflight checklist uses, against
  just the two files you are extracting from, plus your draft summary
- Confirm nothing in the summary crosses from `internal` into something that
  needs `client` or wider clearance — a lesson framed candidly for the
  delivery team is not automatically fine for a bid deck
- If anything is borderline, leave it out of the summary and say so to the
  DM directly, rather than deciding it yourself

## Step 5 — Mark the vault archived

Do **not** delete anything, and do not repurpose the folder for a new
engagement — that is `configure-engagement`'s job, run against a fresh copy
of the template, never against a closed one.

- Set `status: archived` in `project-config.md`'s frontmatter, and add a
  closing line to the Engagement table noting the close-out date
- Append a final row to `07-governance/changelog.md` recording the close-out
- Leave everything else exactly as it stood — the archived vault is itself
  the record

## Step 6 — Report back

Prose and bullets, clickable links, never a code block:

> - Portfolio value summary drafted — 4 QBL stories, all evidence-linked
>   back into this vault. One story left out: framed too candidly about a
>   named individual for wider circulation — flagged to the DM rather than
>   softened by me.
> - Lessons carried forward as written, grouped under process / people /
>   tooling.
> - [project-config.md](project-config.md) — marked `archived`, close-out
>   date added.
> - [07-governance/changelog.md](07-governance/changelog.md) — close-out row
>   appended.
> - Nothing deleted. Nothing repurposed.

## Rules that do not bend

- **Never delete the vault or any register in it.** Archived, not removed.
- **Never round up or estimate a value claim that the register itself left
  `[TBC]`.**
- **Never rewrite a lesson's substance**, including to make it read better
  outside the team that wrote it — leave it out of the external summary
  instead, if it needs softening to travel.
- **Never decide alone that something borderline is fine to circulate more
  widely.** Flag it to the DM.
- **Never repurpose a closed vault for a new engagement.** New engagement,
  fresh copy of the template, `configure-engagement` from there.
- **Never report in a code block.**
