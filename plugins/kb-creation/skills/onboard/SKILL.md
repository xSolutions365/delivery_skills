---
name: onboard
description: First run for a new person on the project's vault. Use when someone says "onboard me", "onboard", "set me up", "I'm new here", or opens the vault for the first time. Asks their name and role, creates their private space, verifies the safety check, writes their personal settings file, runs the sync test, and ends with a briefing on what is actually happening on their part of the engagement.
---

# onboard

Runs once per person, right after they have installed things. Two or three
minutes. **It must end with them knowing something useful, not with a checklist.**

Register: plain, warm, no jargon. Every step tells them what they will see.

## Read this first, every time

`project-config.md` — the current roster (who's who and their access), the
engagement name, and who the DM is. Read it fresh for every onboarding run;
never reuse a roster or a DM name from a previous run of this skill.

## Step 1 — Who are you?

Ask their name and role. **Read the Roster table in `project-config.md`
first** and offer exactly what's in it, rather than making them type it or
relying on who was on the roster last time you looked:

> Which of these are you?
> [Name 1] ([Role 1]) · [Name 2] ([Role 2]) · ... — one per current roster row

No tech-comfort interview. No questionnaire. Just the one question.

Derive a lowercase first-name slug for their folder from whatever name they
give you (e.g. `jamie`, `charlotte`). **Never assume the roster from a
previous onboarding run** — if someone's name isn't in `project-config.md`
yet, that's worth a quick flag before creating their space, since it means
the roster is out of date.

## Step 2 — Make their private space

Create `users/<slug>/` and confirm `00-inbox-local/` exists locally.

Tell them what that means, in these words or close to them:

> `users/<slug>/` is yours. It never syncs and nobody else can see it — it is not
> in the shared record at all. Be as messy as you like in there; that is what it
> is for. Anything you want to share, you share deliberately.

Worth adding once: it is not backed up either, so it should never hold the only
copy of something that matters.

## Step 3 — Check the safety net is in place

```bash
test -x .git/hooks/pre-commit
```

If missing, run `bash SETUP/hooks/install-guard.sh` and say you have done it.

Explain it in one sentence, framed as help rather than policing:

> There is a check that runs before anything gets shared. If something looks like
> it should not be shared — no audience set, something marked private, a file over
> 50 MB, a phrase on the sensitive list — it stops and tells you which file and
> what to change. If you see it, it is working, not broken.

## Step 4 — Write their settings file

Write `CLAUDE.local.md` at the vault root — gitignored, theirs alone:

```markdown
# Who you are serving

You are working with <Name>, the <Role> on [Engagement name, from
`project-config.md`].
Load `roles/<role-file>.md` for what they care about.
Their private space is `users/<slug>/` — never move its contents to
shared folders without running capture and getting a yes.
```

Mention they can edit it, and that it is not shared.

## Step 5 — The sync test

Create `SETUP/sync-tests/<slug>.md` — a couple of lines, their name and the date,
with proper frontmatter (`classification: internal`) so the safety check passes.

Then:

> Run **Sync now** from Obsidian's command palette (Cmd+P). In a minute or two
> that file will be visible on GitHub in your browser. That round trip is the
> proof your syncing works in both directions — it is the only test worth doing.

Per-person file on purpose: nobody edits a shared guestbook and creates a
conflict on their first five minutes.

## Step 6 — Teach exactly two things

Not the folder tree. Not frontmatter. Not Git. **Two things:**

**One — how to put anything in:**

> Say **"capture this"** and point at it. A transcript, your interview notes, a
> crawl export, a photo of a whiteboard. It files it, works out what we learned,
> and logs the findings under your name. It asks you one question — who it is for.

**Two — how to get anything out:**

> Just ask, in plain English. *"What have we heard about content ownership?"*
> It reads across everyone's fieldwork and cites its sources. No command needed,
> and it gets better every time anyone captures anything.

Then point at `START-HERE.md` and `SETUP/user-guide.html`, and say the guide is
the thing to check when something looks odd rather than something to read now.

## Step 7 — The payoff (the part that matters)

**Do not end on a checklist.** Read their role profile at `roles/<role>.md`, then
read the actual current state of the vault — `02-discovery/interview-coverage.md`,
`02-discovery/loop-back-questions.md`, `04-delivery/actions-log.md`,
`04-delivery/raid-tracker.md`, their own home folders, the findings pillars they
own — and give them a short, concrete briefing on **what is happening on their
part of this engagement right now.**

Real and specific, from what is actually in the vault, drawn from their own
role file and the current register state — **never from memory of who was
on the roster or what they cared about last time.** Roughly, per function
(adapt to whoever is actually named against that role in `project-config.md`
right now):

- **Business Analyst:** their interview groups and what is booked, process/governance ground to cover, what any governance deliverable will need from their fieldwork, their open loop-back questions
- **UX:** the gap-analysis frame, what content assessment covers, which findings pillars they are filling
- **Tech Lead:** the audit strands, the agreed depth, any access dependencies, the seed list or scope boundary agreed
- **Strategist:** the alignment/success-definition work, workshop tensions, what synthesis will need
- **Design Principal:** programme context they already hold, where their direction is most needed
- **Delivery Manager:** mobilisation state, ownership gaps, overdue actions, RAID movement

If the person's role has no line above, or their role file describes
something these don't cover, build the briefing from their role file
directly rather than forcing it into this list.

Close with the offer, not an instruction, naming the actual DM from
`project-config.md`'s roster:

> That is you set up. If anything looks odd, post a screenshot in the Slack
> channel — never debug it alone. And if you want fifteen minutes with [DM
> name] to walk through any of it, just ask.

## Do not

- Do not mention any workflow other than `capture` — nothing else exists yet, and naming absent features makes the vault feel unfinished.
- Do not teach Git, frontmatter or the folder tree.
- Do not generate an extra personal one-pager. `START-HERE.md` is the leave-behind.
- Do not end on a checklist. The briefing in step 7 is the whole point of the skill.
