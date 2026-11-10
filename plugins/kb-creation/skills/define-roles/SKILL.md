---
name: define-roles
description: Fill in the role profiles for a newly configured engagement. Use after configure-engagement has set the roster, or when someone says "define roles", "set up the role profiles", "the roles still say the last engagement". Rewrites each roster member's role-profile body (what they care about, their homes, what they own, done looks like) to match this engagement's actual roster and focus areas, adds files for roles the roster needs that don't exist yet, and flags role files for people no longer on the roster.
---

# define-roles

`roles/*.md` are read by `onboard` to close every session with a real,
specific briefing, and by everyone else as a reminder of what their strand
covers. A role file with the previous engagement's focus areas in it is worse
than a blank one — it reads as current and isn't.

Run this straight after `configure-engagement` has written the roster into
`project-config.md`. If that hasn't happened yet, say so and stop — the roster
is the input this skill needs, not something to ask for again from scratch.

**Roles are named by function, not by person** (`roles/delivery-manager.md`,
`roles/tech-lead.md`, and so on) — that is deliberate, so the file survives a
roster change. You are rewriting the *body* of each function's file to match
whoever holds it now and what this engagement actually needs from that
function; the filename stays put.

## Step 1 — Read what you have to work with

- `project-config.md` — the roster (who, what role, what access), the
  engagement's phases and dates, the launch contract's QBL focus
- Every existing file under `roles/` — both to see which functions already
  have a file, and as the style to match: heading, "what you care about",
  "your homes", "you own", "findings you tend to write to", "done looks
  like"
- `project-config.md`'s folder ownership table — this is where "your homes"
  and "you own" should agree with, not contradict

## Step 2 — Reconcile roster against existing role files

Three cases, handled differently:

| Case | What to do |
|---|---|
| Role exists in the roster and a matching file already exists | Rewrite its body (step 3) |
| Role exists in the roster, no file for it | Create it, same structure |
| A role file exists for a function **not** in this engagement's roster | Leave the file in place but say so plainly in your report — do not delete it. A future engagement on the same portfolio may reuse it, and deleting institutional phrasing nobody asked you to remove is not this skill's call |

## Step 3 — Ask what each function actually covers here

Do not invent the substance from the role title alone — "Tech Lead" means
something different on an audit-heavy engagement than on a build one. Ask the
person running this (the DM, most likely) in one pass, one short paragraph per
role, covering:

- What this function is actually accountable for on **this** engagement,
  given its phases and scope
- Which folders are genuinely their home (cross-check against the folder
  ownership table — don't contradict it)
- Which findings pillars (People / Process / Product / Platform) they are
  expected to write to most
- What "done" looks like for them specifically, by the end of the current
  phase

If the DM would rather you draft first and correct after, say so and produce
a draft per role from the engagement facts you already have — phases, QBL
focus, folder ownership — then hand it back for a light edit rather than
leaving fields blank. **Mark anything you inferred rather than were told**,
in the same spirit as `capture`'s `inferred` basis — a role profile is read
as settled guidance, and a confident-sounding guess in it is the same failure
mode as a confident-sounding guess in a findings row.

## Step 4 — Write each file

Keep the frontmatter shape used across the existing files: `type:
role-profile`, `owner` (the person currently holding the role, from the
roster), `area: engagement`, `classification: internal`, `status: active`,
`date`/`updated` set to today, `tags: [role]`.

Body sections, in this order, matching the existing style:

```
# <Function> — <Name>

**What you care about on <engagement name>:** ...

**Your homes:** ...

**You own:** ...

**Findings you tend to write to:** ...

**Done looks like:** ...
```

Keep it to the same length and register as the existing files — a short,
specific paragraph or two per section, not a job description. The value of
these files is that someone can read their own in under a minute.

## Step 5 — Report back

Prose and Markdown bullets, one per file, clickable links, never a code
block:

> - [roles/delivery-manager.md](roles/delivery-manager.md) — rewritten for
>   the current Delivery Manager on this engagement's phases and folder ownership.
> - [roles/tech-lead.md](roles/tech-lead.md) — created; no prior file for
>   this function.
> - [roles/design-principal.md](roles/design-principal.md) — left
>   untouched; no one on this engagement's roster holds this role. Not
>   deleted, in case a later engagement reuses it.
>
> **Inferred, not confirmed:** the UX role's findings-pillar split, drafted
> from the folder ownership table rather than stated directly — worth a
> quick check with whoever holds that role before `onboard` runs.

## Rules that do not bend

- **Never rename or delete a role file.** Leave functions not on the current
  roster in place, flagged in the report, untouched.
- **Never invent what a function covers from the title alone.** Ask, or draft
  from the engagement facts you actually have and mark it as inferred.
- **Never contradict the folder ownership table in `project-config.md`.** If
  a role's "homes" would conflict with it, that is a conversation to have
  with the DM, not a decision to make silently in either file.
- **Keep the existing frontmatter shape and section order.** `onboard` reads
  these files expecting this structure.
- **Never report in a code block.**
