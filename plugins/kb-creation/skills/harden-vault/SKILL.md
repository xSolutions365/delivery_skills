---
name: harden-vault
description: Install and tailor the vault's safety net for this engagement. Use when someone says "harden the vault", "set up the safety check", "install the guard", or after configure-engagement on a fresh clone. Installs the pre-commit guard, writes a client-appropriate blocked-terms list, verifies the gitignore covers the private paths, and writes or checks CLAUDE.md and AGENTS.md so agents and humans read the same rules.
---

# harden-vault

`check-rules.sh` is "the ONE implementation of the vault's four safety
rules" and it is called from two places on purpose: the local pre-commit
hook, and the server-side workflow that cannot be bypassed. Your job is to
make sure both are actually in place, and that the one client-specific input
— the blocked-terms list — reflects *this* engagement's sensitivities rather
than the last one's.

Run this after `configure-engagement` (you need to know the client and any
named sensitivities) and before anyone else is invited in. **Do not run this
against a vault that is already live with a team using it** — changing the
guard's rules out from under people mid-engagement needs their heads-up, not
a silent skill run.

## Step 1 — Install the guard

```bash
bash SETUP/hooks/install-guard.sh
```

Confirm it worked:

```bash
test -x .git/hooks/pre-commit && echo present
```

If `install-guard.sh` itself does not exist, say so and stop — that means the
scaffold this vault was copied from is missing a piece, not something to
improvise a replacement for.

## Step 2 — Check the gitignore covers the private paths

The two rules the whole privacy model rests on:

```bash
mkdir -p users/test && echo x > users/test/x.md
mkdir -p 00-inbox-local && echo y > 00-inbox-local/y.md
git status --porcelain
```

**Expected: neither file appears.** Then clean up:

```bash
rm -rf users/test 00-inbox-local/y.md
```

```bash
git check-ignore -v users/ 00-inbox-local/ CLAUDE.local.md
```

All three should report as ignored. If any of this fails, stop and say so —
do not proceed to inviting people while the private-space guarantee is
unverified.

## Step 3 — Tailor the blocked-terms list

Open `SETUP/hooks/blocked-terms.txt`. It almost certainly still holds the
previous engagement's terms (day rates, internal-only phrasing, names of
things that should not reach a shared file). Ask the DM for **this**
engagement's equivalents:

- Anything commercially sensitive to this client specifically (a named
  competitor comparison, an unannounced initiative, pricing)
- Anything the client organisation has explicitly asked stay off the record
- Rate, margin, and allocation language — this list travels across
  engagements by default (`day rate`, `margin`, `utilisation`), keep it
  unless told otherwise

Replace the previous engagement's client-specific terms with this one's.
Keep the generic commercial-sensitivity terms. **Do not just append** — a
blocked-terms list nobody prunes accumulates terms that no longer apply and
makes false blocks (and the "why is this blocked" confusion that follows)
more likely, not less.

Note that transcript excision review and other planned exemptions
(`rule4_exempt` in `check-rules.sh`) are a separate, human-reviewed process —
this skill edits the term list, not the exemption logic.

## Step 4 — `CLAUDE.md` and `AGENTS.md`

Both should exist, and `check-rules.sh` treats them as identical (`diff
CLAUDE.md AGENTS.md` is part of the preflight checklist). If either is
missing, write both with the same content: what must never go in a shared
`.md` file, a pointer to the guard and what it catches, and where the
private space (`users/<name>/`) lives. If both already exist, just confirm
they still match and say so.

## Step 5 — Run the control cases

Before reporting this done, verify the guard actually blocks and actually
allows, both:

- A clean, properly classified `.md` commits successfully
- An unclassified shared `.md` is blocked, with a plain-English reason
- A file containing one of the newly added blocked terms is blocked

**A guard that blocks everything is worse than none, and a guard that blocks
nothing looks identical to a working one until the first leak.** Test both
directions; do not assume from installation alone.

## Step 6 — Report back

Prose and bullets, one per check or file, never a code block:

> - Guard installed: `.git/hooks/pre-commit` present and executable.
> - Privacy check: `users/` and `00-inbox-local/` confirmed ignored,
>   nothing leaked in a test commit.
> - [SETUP/hooks/blocked-terms.txt](SETUP/hooks/blocked-terms.txt) —
>   added this client's named sensitivities; kept the generic
>   rate/margin list.
> - [CLAUDE.md](CLAUDE.md), [AGENTS.md](AGENTS.md) — created, identical.
> - Control cases: clean file committed, unclassified file blocked with
>   reason, blocked-term file blocked. All as expected.

## Rules that do not bend

- **Never disable or weaken a rule to make a test pass.** If a control case
  fails, that is a defect in the guard to report and fix, not a rule to
  soften.
- **Never run `git commit --no-verify`**, here or anywhere else, to get past
  a block during testing. Use a throwaway file and delete it after.
- **Never touch the exemption logic in `check-rules.sh`** (`rule4_exempt`)
  without the DM's explicit say-so — those exemptions were reasoned through
  case by case and are not this skill's to extend.
- **Never skip the control-case pass.** Installed is not the same as
  working.
- **Never run this against a vault already in daily use** without warning
  the team first — a changed blocked-terms list can surprise someone mid-commit.
- **Never report in a code block.**
