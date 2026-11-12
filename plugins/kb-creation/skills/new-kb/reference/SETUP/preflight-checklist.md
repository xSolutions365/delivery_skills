---
type: checklist
owner: "[DM name]"
area: governance
classification: internal
status: active
date: "[YYYY-MM-DD]"
updated: "[YYYY-MM-DD]"
tags: [preflight, release]
---

# Preflight checklist

**DM only.** Walk this before inviting anyone. Deliberately a checklist
rather than a skill — it runs once per launch. `launch-checklist` runs the
automatable parts of this for you and gives you a verdict; walk the rest
yourself before you tag a release.

Record the date walked, then file a completed copy in `07-governance/`.

**Walked:** `[date]` · **Result:** `[pass | blockers listed below]`

Run from the vault root.

## Privacy — the ignored paths really are invisible

- [ ] `mkdir -p users/test && echo x > users/test/x.md && echo y > 00-inbox-local/y.md && git status --porcelain` → **expected: no mention of either file.** Then `rm -rf users/test 00-inbox-local/y.md`
- [ ] `git check-ignore -v users/ 00-inbox-local/ CLAUDE.local.md` → all three reported as ignored

## The safety check — all four rules, through all three commit paths

The rules are in `SETUP/hooks/check-rules.sh`. **Test the paths people
actually use, not just the terminal** — a hook that only fires on a typed
`git commit` protects nobody here.

- [ ] Guard installed: `test -x .git/hooks/pre-commit`
- [ ] Scripts parse under macOS bash 3.2: `for s in check-rules.sh pre-commit install-guard.sh session-sync.sh sync-pull.sh; do /bin/bash -n SETUP/hooks/$s; done` → no output
- [ ] **Rule 1** — shared `.md` with no classification is blocked, and the message says *why*
- [ ] **Rule 2** — `classification: private` outside an ignored path is blocked
- [ ] **Rule 3** — a file over 50 MB is blocked
- [ ] **Rule 4** — a blocked term from `blocked-terms.txt` is blocked
- [ ] **Control: a clean file commits successfully.** A guard that blocks everything is worse than none — verify this, not just the blocks
- [ ] **Via Obsidian Git's automatic commit:** create an unclassified `.md` in a shared folder, let the plugin auto-commit (or run Sync now), confirm it does **not** land. → If it *does* land, the local hook is not firing on the plugin's path. Record it, and treat `guard.yml` as the primary control rather than the backstop. **Do not launch pretending both work.**
- [ ] **Via Claude Code:** ask it to commit a deliberately unclassified file → blocked, reason reported, no `--no-verify` retry
- [ ] **Via the Stop hook (the no-Obsidian path):** `bash SETUP/hooks/session-sync.sh` with (a) no changes → silent, (b) a clean change → commits and pushes, (c) a file containing a blocked term → guard blocks, HEAD unchanged, file preserved on disk, index left clean
- [ ] **Sync survives a concurrent fetch:** with Obsidian open, `git fetch -q && git fetch -q --append` (the branch is now listed twice, as when Obsidian and a hook fetch together), then `bash SETUP/hooks/sync-pull.sh; echo $?` → `0`. Plain `git pull --rebase` fails here with "Cannot rebase onto multiple branches", which is why the hooks never use it
- [ ] **Obsidian Git settings actually match what the guide promises:** `autoPullOnBoot: true`, `autoPullInterval: 5`, `autoPushInterval: 2`, `autoSaveInterval: 2` in `.obsidian/plugins/obsidian-git/data.json`. A plugin that auto-commits but never pushes looks like it is working and is not

## Server-side enforcement

- [ ] Push an unclassified `.md` on a throwaway branch → the **Safety check** workflow (`.github/workflows/guard.yml`) runs and fails with the same plain-English message. Delete the branch after
- [ ] GitHub → Settings → Code security: **secret scanning** on, **push protection** on
- [ ] Note whether Settings → Branches offers required status checks (if so, enabling it makes `guard.yml` a hard block rather than a flag)

## Nothing sensitive is already in here

- [ ] `grep -ril -f SETUP/hooks/blocked-terms.txt 0*/ 1*/ roles/ schema/ templates/ SETUP/ 2>/dev/null` → no hits (excluding `blocked-terms.txt` itself and files that legitimately quote the rules)
- [ ] `grep -rl "classification: private" 0*/ 1*/ 2>/dev/null` → no hits
- [ ] `grep -rl "@" 0*/ 1*/ 05*/ 2>/dev/null` → check any hits are transcript headers, not something that shouldn't be there
- [ ] Anything named in this engagement's own launch decisions as off-limits — check it explicitly, by name

## Structure and instructions

- [ ] `diff CLAUDE.md AGENTS.md` → no output
- [ ] Both `capture` and `onboard` skills present: `ls .claude/skills/capture/SKILL.md .claude/skills/onboard/SKILL.md`
- [ ] `project-config.md` has no bracketed placeholders (`[Engagement name]`, `[DM name]`, etc.) left anywhere in it
- [ ] No `views/`, no `dashboard.md`, no `inboxes/` — not part of this structure
- [ ] Every shared `.md` carries a valid classification
- [ ] Internal links in `START-HERE.md` resolve
- [ ] `START-HERE.md`'s three steps match what actually happens *(manual — read it and try them)*

## It actually works

- [ ] `capture` on a real or deliberately test transcript → source filed, synthesis written, findings rows landed in the right pillar with author and a **resolving** evidence path, loop-back questions logged, reply is ~3 lines. **This is the check the vault stands or falls on**
- [ ] `capture` with the matching consent row absent → files, tags `consent-pending`, says so plainly, **no synthesis and no findings rows**
- [ ] A plain-English cross-cutting question returns an answer citing more than one source
- [ ] `onboard` runs clean from a fresh clone and ends with a useful role briefing containing nothing private
- [ ] Claude Code with Obsidian **closed**: make a change, end the session, confirm it reached GitHub

## Fresh clone

- [ ] Clone to a scratch path. Contains no `users/` content, no `00-inbox-local/` content, no unapproved client material
- [ ] Follow only `START-HERE.md` → setup, guard, sync test and onboarding complete in under 20 minutes

## Then

- [ ] Fix every blocker and re-run its check
- [ ] `git tag launch-v1 && git push --tags`
- [ ] Pre-provision access for the roster in `project-config.md`. **Invites only — do not announce yet**
- [ ] File the completed copy in `07-governance/`
