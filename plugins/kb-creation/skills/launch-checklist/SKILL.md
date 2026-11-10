---
name: launch-checklist
description: Walk the preflight checklist before inviting the team into a new vault. Use when someone says "run the launch checklist", "are we ready to launch", "preflight this vault", or asks whether the vault is ready for people. Runs every automatable check from SETUP/preflight-checklist.md, reports a plain pass-or-blockers verdict, and stops short of anything irreversible — repo invites, tags, and announcements stay the DM's own call.
---

# launch-checklist

`SETUP/preflight-checklist.md` is deliberately a checklist, not a skill that
runs itself unattended — it exists because a launch has to be walked once,
carefully, by a human who takes responsibility for the result. **Your job is
to do the mechanical parts of that walk quickly and honestly**, so the DM's
attention goes to judgement calls, not to retyping `grep` commands.

Run this last, after `configure-engagement`, `define-roles`, `seed-references`
and `harden-vault` have all run. If any of those haven't, say so and stop —
this checklist is a gate, not a substitute for the steps it is gating.

## Step 1 — Read the checklist itself

Open `SETUP/preflight-checklist.md` fresh, every time — do not work from
memory of a previous run or from this description. It is the source of
truth and it changes as the vault's own rules change.

## Step 2 — Run every check that is genuinely automatable

Work through it section by section: privacy/ignore rules, the guard through
all three commit paths, server-side enforcement (report what you can check
locally; note what needs a GitHub UI check for the DM to do themselves),
the "nothing sensitive already in here" greps, structure and instructions,
and the "it actually works" functional checks (capture on a real or
deliberately test transcript, a plain-English cross-cutting question,
`onboard` from a fresh state).

For each item, record one of three outcomes — do not silently skip one:

- **Pass** — ran it, got the expected result
- **Blocker** — ran it, did not get the expected result; name exactly what
  it returned
- **Needs a human** — genuinely not automatable (a manual read like "does
  `START-HERE.md` match what actually happens", or a GitHub Settings page
  this session cannot open) — say so and what the DM needs to go check

**Never mark an item passed without actually running it.** A checklist
walked from assumption is worse than one left undone, because it reads as
verified when it is not.

## Step 3 — Do not go further than checking

This skill verifies readiness. It does **not**:

- Push a tag (`git tag launch-v1 && git push --tags`) — that is a
  repository-level, hard-to-reverse action; propose it, and only run it on
  an explicit yes
- Invite anyone to the repo — GitHub invites are sent by the DM directly;
  this skill can list who still needs inviting from the roster, not send
  anything
- Announce the launch anywhere (Slack, email) — flag that it is the next
  step, do not send it
- Fix a blocker by working around the guard, deleting sensitive content it
  found, or editing another skill's output to force a pass. Report the
  blocker; let whoever owns that area fix it properly

## Step 4 — Report the verdict

Lead with the verdict, then the detail — the DM should not have to read to
the bottom to find out if they can launch:

> **Verdict: 2 blockers, not ready to launch.**
>
> **Blockers:**
> - Rule 2 (private classification outside an ignored path) did not block a
>   test file — the guard let it through. Needs investigating in
>   `check-rules.sh` before anything else.
> - `diff CLAUDE.md AGENTS.md` shows they've diverged — `AGENTS.md` is
>   missing the blocked-terms pointer that `CLAUDE.md` has.
>
> **Passed:** guard installed and executable · privacy ignore rules hold ·
> rules 1, 3, 4 all block correctly with a clean file still committing ·
> both skills present · no sensitive terms found in shared folders ·
> `capture` produced a correctly-filed synthesis, findings rows, and a
> loop-back question on a test transcript.
>
> **Needs a human:** GitHub secret scanning / push protection settings —
> can't check from here, please confirm in Settings → Code security.
> `START-HERE.md`'s three steps matching what actually happens — worth
> reading it yourself once before launch.
>
> **Not run, by design:** tagging `launch-v1`, sending invites, announcing —
> your call, once the blockers above are cleared.

## Rules that do not bend

- **Never report a pass you did not actually run.**
- **Never work around a blocker to make the checklist pass** — fix the
  underlying thing, or leave it a blocker and say so.
- **Never tag, push, invite, or announce.** Verification only. Propose the
  next action; do not take it.
- **Never skip an item silently.** Pass, blocker, or needs-a-human — every
  line gets one of the three, explicitly.
- **Never report in a code block** for the verdict summary itself — clarity
  here matters more than anywhere else in this skill set, since it is what
  the DM decides on.
