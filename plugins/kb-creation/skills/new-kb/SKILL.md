---
name: new-kb
description: Scaffold a brand-new engagement vault from this skill's own bundled reference copy. Use when someone says "new kb", "start a new project vault", "spin up a new engagement", or "copy this as a template for a new client". Works in an entirely empty folder — everything it needs (SETUP, roles, schema, templates, the folder skeleton, config) ships inside this skill's reference/ directory, not read from whatever surrounds it. Assumes the skill toolkit itself (capture, onboard, configure-engagement and the rest) is already available to the user, and doesn't try to install it. Leaves every engagement-specific detail as a placeholder, and — with explicit permission — creates the new GitHub repo and makes the first commit.
---

# new-kb

Everything this skill copies lives right here, in
`.claude/skills/new-kb/reference/` — a complete, already-genericised copy of
the vault structure: `SETUP/`, `roles/`, `templates/`, `schema/`,
`.obsidian/`, the hooks, `.claude/settings.json`, and the empty folder
skeleton. That is what makes this skill self-contained for *scaffolding*:
**it never reads from the folder it is running in.** Copy just this one
skill folder into a brand-new, otherwise empty project, point Claude Code at
it, and running `new-kb` produces a complete, working scaffold — no
surrounding template repo required.

**This skill does not install the other skills.** `capture`, `onboard`,
`configure-engagement`, `define-roles`, `seed-references`, `harden-vault`,
`launch-checklist` and `close-out-engagement` are assumed to already be
available wherever the user runs Claude Code — installed once, at whatever
level (personal, org) makes them available across projects, the same way
this skill itself is. `new-kb` scaffolds the *content* a vault needs; it
doesn't manage the toolkit.

Run this first, before anything else in the chain
(`configure-engagement` → `define-roles` + `seed-references` →
`harden-vault` → `launch-checklist`). Those all assume a folder that looks
like the reference copy but holds no engagement facts yet; this skill is
what produces that folder.

## Step 1 — Work out the target

Two situations, handled differently:

**A — Bootstrapping in place.** You've been invoked in a folder that has
nothing in it but this skill (typically just `.claude/skills/new-kb/`,
copied there on its own, with the rest of the toolkit available separately).
There's nothing to protect and nothing to ask about a separate destination —
**the target is this folder itself.**

**B — Spinning off a sibling.** You've been invoked inside an existing,
already-populated vault (this is exactly what running `new-kb` from inside
this very template looks like once it has real engagement content in it) and
the ask is to produce a *new*, separate engagement vault. Ask for a target
path — a new, empty folder, typically a sibling directory
(`~/Documents/GitHub/deliveryKB-<name>` or similar).

Either way, also ask:

- The new engagement's short name (used for the folder/repo name if not
  already fixed by case A)
- Whether a GitHub repo should be created now, and if so its full name
  (`<org>/<repo-name>`, matching whatever visibility — usually private —
  the organisation normally uses)

If the target folder (case B) already exists and is not empty, stop and say
so. Never copy into an occupied folder and never overwrite.

## Step 2 — Copy the reference bundle, whole

Copy the entire contents of this skill's own `reference/` directory into the
target — every file, every folder, including the dotfiles (`.claude/`,
`.obsidian/`, `.gitignore`, `.github/`). Nothing to exclude and nothing to
strip: **the reference bundle already ships fully genericised.** Every
identifying field is a bracketed placeholder (`[Engagement name]`,
`[DM name]`, `[org]/[repo-name]`, and so on) for `configure-engagement` to
fill in next.

In case A (bootstrapping in place), this means copying `reference/*` up a
level into the target's own root, alongside the `new-kb` skill folder that
was already there.

In case B (spinning off a sibling), copy `reference/*` into the fresh empty
target folder.

**Do not copy a `.claude/skills/` directory into the target beyond what's
already there.** The reference bundle doesn't contain one — the toolkit is
the user's own, installed separately, and this skill has no business
managing it. If the target is missing skills the chain needs next
(`configure-engagement` and so on), say so plainly rather than trying to
supply them.

### The one known gap, carried forward on purpose

`SETUP/user-guide.html` — the team-facing guide — travels as a **copy of
this template's own guide**, not a genuinely generic starter. Beyond the
title and the visible engagement name (which `configure-engagement` rewrites
for you), its body still illustrates the mechanics with this template's own
worked examples. That's fine for the Git/Obsidian setup mechanics, which
don't change between engagements — but a proper per-engagement pass over its
role-specific tour and examples is a manual follow-up, not something this
chain automates. Say so plainly in your report; don't quietly present it as
finished.

`schema/frontmatter.md` is deliberately **not** in the reference bundle —
it's `seed-references`' job to create it, not this skill's, so it isn't
duplicated in two places that could drift apart.

## Step 3 — Git, only with explicit permission

`git init` on the target is a reversible, local action — fine to do without
asking, and worth doing regardless of case A or B so the vault has a history
from its very first commit.

**Everything past that needs a clear yes first**, one at a time:

- Creating the GitHub repo (state the exact name and its visibility, matching
  the organisation's norm)
- Setting the remote and pushing the first commit

Do not chain these into Step 2 automatically. Propose them, in these words
or close to them, and wait:

> Ready to create `<org>/<repo-name>` as a private repo and push the initial
> scaffold — go ahead?

If the answer is no, or "not yet," leave the folder as a local, uncommitted
copy and say that plainly — nothing is lost by waiting.

## Step 4 — Report back, and name the next step

Prose and Markdown bullets, clickable links where the path makes sense to
link, never a code block:

> - Vault scaffolded at `~/Documents/GitHub/deliveryKB-Acme/` from this
>   skill's bundled reference copy — `SETUP/`, roles, templates, schema,
>   folder skeleton, `.obsidian/`, hooks, `.github/workflows/guard.yml`,
>   `.claude/settings.json`.
> - Folder indexes: none yet. The end-of-session sync builds an OKF
>   `index.md` in each folder once it holds notes
>   (`SETUP/tools/okf_index.py`), so nothing needs doing.
> - Every identifying field is still a bracketed placeholder — nothing
>   guessed, nothing carried over from another engagement.
> - Known gap, carried forward: `SETUP/user-guide.html` still illustrates
>   itself with this template's own worked examples beyond the title and
>   engagement name; a full per-engagement rewrite of its body is a manual
>   follow-up.
> - GitHub repo: **not created** — waiting on a yes.
>
> **Next:** confirm the rest of the toolkit (`configure-engagement` and the
> skills after it) is available in this environment, then run
> `configure-engagement` against the new folder to fill in the roster,
> dates, and launch contract.

## Keeping the reference bundle itself in sync

**This is a maintenance rule for whoever edits the scaffolding, not part of
a normal `new-kb` run.** If a hook script is fixed, `project-config.md`'s
structure changes, or a new file becomes part of the standard vault shape,
update `.claude/skills/new-kb/reference/` to match. A stale reference bundle
means `new-kb` keeps stamping out yesterday's scaffolding without anyone
noticing, which defeats the entire point of bundling it. This applies to the
vault content only — the bundle never gains a `.claude/skills/` directory of
its own; the toolkit's own versioning is out of scope here.

## Rules that do not bend

- **Never read from the surrounding folder to decide what to copy.** The
  `reference/` directory bundled with this skill is the only source. If it's
  ever tempting to reach outside it "just this once," that's a sign the
  reference bundle itself is missing something — fix the bundle, not the
  run.
- **Never copy any real engagement content.** The reference bundle should
  never contain any — if it ever does, that's a bug in the bundle, not
  something for a `new-kb` run to work around by filtering at copy time.
- **Never bundle or install the other skills.** They're assumed already
  available; this skill's job is the vault content, not the toolkit.
- **Never overwrite an existing, non-empty target folder.**
- **Never create a GitHub repo, set a remote, or push without an explicit
  yes for that specific action.** `git init` locally is the only git action
  that doesn't need to ask first.
- **Never invent a value for a placeholder.** The bundle ships with
  brackets; leave them for `configure-engagement`.
- **Never let the reference bundle drift from the actual scaffolding**
  without updating it — see the maintenance rule above.
- **Never report in a code block.**
