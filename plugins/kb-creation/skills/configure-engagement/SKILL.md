---
name: configure-engagement
description: Turn a freshly scaffolded, generic knowledge base into one specific engagement. Use when someone says "configure this engagement", "set up project-config", "this is a new client vault, configure it", or opens a copied template that still names the previous client/engagement. Interviews the delivery manager for the engagement facts, rewrites project-config.md end to end, propagates the identifying details (engagement name, client, DM, Slack channel) into the front-door files, and reports exactly what still needs another pass.
---

# configure-engagement

`project-config.md` is "the settings every skill reads first" — every other
skill (`onboard`, `capture`, and whatever runs after this one) trusts what is
in it. **Your only job is to make that file true for this engagement**, and to
leave the front door (`START-HERE.md` and the `SETUP/` files people actually
read) saying the same name, not the last engagement's.

Run this once, right after the folder structure exists and before anyone is
invited in. Whoever is running it is acting as the delivery manager, whether or
not that is their formal title.

## Step 0 — Work out what you are looking at

Read the current `project-config.md`, `START-HERE.md`, and `roles/*.md`
headers before asking anything. You need this for two reasons:

1. **To know what the old identifying values are**, so you can find and
   replace them later in step 4. Note down: the old engagement name, old
   client name, old DM name, old repo, old Slack channel ID.
2. **To sanity-check that this is actually a template, not a live vault.**
   Look inside `00-source-documents/`, `02-discovery/`, `03-deliverables/`.
   If any of them hold real dated content (interview syntheses, findings
   rows, a filled stakeholder map) rather than empty folders or `.gitkeep`
   files, **stop and say so before continuing**: `configure-engagement`
   rewrites the manifest and front door, but it will never touch or delete
   discovery content, and running it against a populated vault most likely
   means someone copied the wrong folder. Let the person confirm before you
   go further.

If `project-config.md` does not exist at all, this is a fresh scaffold with no
prior engagement to read values from — skip the "old values" list in step 4
and go straight to asking.

## Step 1 — Ask for the engagement facts

Ask in one message, plain language, not a form. Group it like this so it reads
as a conversation, not an intake questionnaire:

**Engagement**
- Engagement name, and the client's name
- Start and end dates
- What phases the engagement runs through — offer the existing model
  (Mobilise → Assess → Synthesise → Roadmap → Enable) as a default they can
  keep, rename, or replace outright with their own methodology's phases
- The repo it lives in (`org/repo-name`), and whether it already exists or
  still needs creating — if it still needs creating, say plainly that
  creating it is a separate step (`init-kb`, or done by hand), not something
  this skill does
- The support/recovery channel (Slack channel name or ID) people post to
  when something looks wrong

**Roster**
- Everyone who needs vault access, their role, and whether each is `owner`,
  a write-access team member, `admin`, or `curated-by-DM` (their outputs get
  curated in by the DM rather than them using the vault directly — a valid
  end state, not a fallback)

**Launch contract** — these are governance decisions, not defaults, so ask for
each explicitly rather than inheriting the template's answer:
- Is client material allowed in the vault at all? If yes, who approved it and
  when — record the name and date, not just "yes"
- Is AI-processing consent (analysing that material, as distinct from storing
  it) already decided, or still open? If still open, say plainly that
  `07-governance/ai-native-checklist.md` will need seeding and a real decision
  before `capture` can synthesise anything — that file is out of this skill's
  scope; note it as a follow-up rather than guessing a status into existence
- Any format or file-size restrictions beyond the 50 MB guard default
- Which modules are enabled at launch — almost certainly just `capture` and
  `onboard` until the team has used the vault for a while; do not enable
  anything the team has not actually installed
- The QBL focus (Quicker / Better / Leaner), if the engagement has one, and
  whether it is confirmed with the client or still proposed
- Content ownership, if decided; `[TBC]` if not — never invent an answer here

**Register owners**
- Who owns RAID, actions, decisions
- Confirm findings stays team-append-DM-curates, unless they want it run
  differently

Use `AskUserQuestion` only for the genuinely binary calls — vault type
(shared team vault vs. single-player), and whether each roster member's
access is direct or curated. Everything else is free text; asking sixteen
multiple-choice questions for a conversation like this is worse than typing.

**Never guess a value to keep the conversation moving.** A launch contract
field left as `[TBC]` and flagged is honest; a plausible-sounding guess that
becomes load-bearing config is the failure mode this whole vault design exists
to avoid elsewhere — do not reintroduce it here.

## Step 2 — Confirm the path mapping still fits

Read the path mapping table in the current `project-config.md`. If the
engagement is using the standard folder structure (`00-source-documents/`
through `07-governance/`, unchanged), leave the table as is — it is already
correct for this shape. Only change it if the DM has told you the structure
itself is different (a single-player vault, a folder renamed or dropped).
Never rewrite path mappings speculatively; this table is "the source of truth"
for every other skill's file resolution, and a wrong entry breaks all of them
silently.

## Step 3 — Write `project-config.md`

Rewrite the whole file: Engagement table, Roster table, Register owners,
Launch contract, Path mapping (per step 2), Folder ownership. Derive folder
ownership from the roster answers using the existing pattern as a guide (DM
owns `04-delivery/` and `07-governance/`; discovery subfolders owned by
whoever is doing that fieldwork; findings and quick-wins stay team-append,
DM-curates) rather than copying the previous engagement's specific names.

Keep the frontmatter (`type: manifest`, `owner`, `area: governance`,
`classification: internal`, `status: active`) and set `date`/`updated` to
today. Set `owner` to the DM you were just given.

## Step 4 — Propagate the identifying details

The front-door files are read by people, in prose, before they ever touch a
skill — they need to say the new engagement's name, not the old one. Using
the old values you noted in step 0, find and replace them in exactly these
files, and no others:

- `START-HERE.md` — the opening line naming the vault/engagement, the `owner`
  frontmatter field, any Slack channel reference
- `SETUP/setup-sheet.md`, `SETUP/recovery-guide.md` — repo name, `owner`
  frontmatter, Slack channel reference
- `SETUP/user-guide.html` — the `<title>`, and any visible engagement/client
  name in the page body
- `roles/*.md` — the `owner` frontmatter field only. **Do not touch the body
  text** (what the role cares about, their homes, findings ownership) — that
  is `define-roles`' job, not this skill's, because it needs the engagement's
  actual focus areas, not a find-and-replace

**Do a literal, scoped replace — old value to new value, in these files
only.** Do not rewrite surrounding prose, tone, or structure; that is what
makes this a safe mechanical pass rather than a rewrite you'd need to
proofread line by line.

If `CLAUDE.md` or `AGENTS.md` do not exist, say so in your report as a gap —
`check-rules.sh` and the preflight checklist both expect them, and creating
them properly is template-completeness work, not something to improvise here.

## Step 5 — Report back

Same convention as `capture` and `onboard`: prose and Markdown bullets, never
a code block, every file a clickable link, one bullet each, saying what
changed.

> **Written:**
>
> - [project-config.md](project-config.md) — rewritten: engagement, roster of
>   N, launch contract, register owners. Path mapping left unchanged — no
>   change to file, so verified/unchanged.
> - [START-HERE.md](START-HERE.md) — engagement name and owner updated in the
>   opening line and frontmatter.
> - [SETUP/setup-sheet.md](SETUP/setup-sheet.md), [SETUP/recovery-guide.md](SETUP/recovery-guide.md) — repo name and owner updated.
> - [SETUP/user-guide.html](SETUP/user-guide.html) — title and visible engagement name updated.
> - [roles/delivery-manager.md](roles/delivery-manager.md) etc. — owner frontmatter only; body still names the previous engagement's focus areas and needs `define-roles`.
>
> **Open:**
> - AI-processing consent recorded as still open — `07-governance/ai-native-checklist.md` needs seeding and a real decision before `capture` can synthesise client material.
> - Content ownership left `[TBC]` — not decided yet.
> - `CLAUDE.md`/`AGENTS.md` do not exist in this copy.
>
> **Next:** run `define-roles` to fill in the role profiles properly, then
> `seed-references` for the registry files `capture` expects to find.

## Rules that do not bend

- **Never touch `users/` or `00-inbox-local/`.** Not in scope, ever.
- **Never invent a value to fill a field.** `[TBC]`, flagged plainly, beats a
  guess that reads as decided.
- **Never rewrite a role's body text.** Frontmatter `owner` only — the rest is
  `define-roles`.
- **Never rewrite the path mapping unless the folder structure itself
  changed.** It is a lookup table other skills depend on; changing it
  speculatively breaks them silently.
- **Never create or rename a GitHub repo, or push, without saying so first
  and getting a clear yes.** Recording a repo name in config is not the same
  as creating one.
- **Never proceed past step 0's sanity check on a populated vault without
  the person confirming.** A vault holding real discovery content is not a
  template to configure over.
- **Never report in a code block.** Clickable links, one bullet per file.
