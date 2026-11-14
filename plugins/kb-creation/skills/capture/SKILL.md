---
name: capture
description: The one verb for putting anything into the engagement vault. Use whenever someone says "capture this", "capture these notes", "file this", "add this to the vault", "log a lesson", "log value evidence", or hands over a transcript, meeting notes, a crawl or analytics export, a client document, a photo of a whiteboard, or a draft. Files the raw thing, synthesises it into 4P + lens findings under the consent gate, appends attributed findings rows with resolving evidence citations, shortlists quick win candidates, sweeps for RAID, decisions, actions, lessons and QBL value evidence, records an AI-native evidence row when it synthesised, logs new loop-back questions, and updates interview coverage — in one pass, with one consent question.
---

# capture

The only workflow the team needs to know. Someone points at something; you file
it, understand it, and record what it tells us — in one pass.

**Your job is to make this feel like magic and take ten seconds of their
attention.** They should never think about folders, frontmatter, or Git.

## Read these first, every time

1. `project-config.md` — the path mapping (where everything lives), the roster, the register owners and folder ownership tables (who may write RAID, decisions, actions, and who owns the roadmap file), `client_material_allowed`
2. `schema/frontmatter.md` — required keys, the findings row format, the verification line
3. `07-governance/ai-native-checklist.md` — **the consent gate.** Read its status line before any synthesis (see step 4 — one grep, not the whole file).
4. `CLAUDE.local.md` if present — who you are working with

## Step 1 — Work out what you have been given

Accept anything: a path anywhere on the machine, a file in `00-inbox-local/`,
pasted text, a transcript, a crawl or analytics export, a client document, an
image of a whiteboard, a draft deliverable.

Classify it yourself. Do not ask the person what type it is — you can tell, and
asking is the friction this skill exists to remove.

| What it looks like | Type | Raw goes to | Synthesis goes to |
|---|---|---|---|
| Interview or call transcript / notes | `interview-note` | `00-source-documents/call-notes/` | `02-discovery/interviews/` |
| Audit output, crawl, analytics export | `audit-note` | `00-source-documents/client-docs/` | `02-discovery/audit/` |
| Workshop output, whiteboard photo | `source-summary` | `00-source-documents/workshops/` | `02-discovery/workshops/` |
| Process or flow description | `source-summary` | `00-source-documents/client-docs/` | `02-discovery/process-maps/` |
| Client-supplied document | `source-summary` | `00-source-documents/client-docs/` | **route by what it describes — see below** |
| Discussion guide, interview question set | `discussion-guide` | `00-source-documents/discussion-guides/` | — none. It is an instrument, not evidence |
| Draft deliverable section | `deliverable` | — | `03-deliverables/` |
| Internal team meeting, stand-up, retro | `source-summary` | `00-source-documents/call-notes/` | the registers — see step 8 |
| A lesson, or a value proof point, on its own | — | — | `06-value-and-lessons/` — see step 8 |

**Delivery signal is not a document type.** An interview transcript can carry a
risk, a decision and an action while still being an interview. Those last two
rows are for material that is *only* delivery or value content. Everything else
still gets swept for it in step 8, whatever its type.

**A discussion guide is an instrument, not a finding.** It records what we
*intended* to ask, so it belongs with the source records and produces no
synthesis, no findings rows and no quick wins of its own. It earns its place by
being citable afterwards: the interview synthesis compares the guide against
what was actually covered, and the gap goes in the coverage tracker. **Do not
file one under `02-discovery/interviews/`** — that folder is for synthesis notes,
and two guides had to be moved out of it on 2026-07-28 for exactly this reason.

### Client documents: route by what the document *describes*

A client document is not a category of its own — it is evidence about something.
**Decide which, in this order, and say where you are putting it:**

| If the document describes… | Synthesis goes to |
|---|---|
| How work flows, who approves what, governance, roles, an operating model | `02-discovery/process-maps/` |
| The technical estate — architecture, analytics config, SEO, platform behaviour | `02-discovery/audit/` |
| The experience — content, IA, design, audience | `02-discovery/` root, unless a gap-analysis file already covers it |
| A workshop or session output | `02-discovery/workshops/` |
| Something spanning all of it (a strategy or programme document) | `02-discovery/` root |

**Never leave this to "as relevant".** That phrase used to be in this table and
it produced exactly what you would expect: the first real client document landed
loose at the `02-discovery/` root while all three subfolders stayed empty. A
subfolder nobody routes to is a subfolder nobody trusts.

If it genuinely spans several, pick the **dominant** one, put it there, and say
in your report which others it touches. One home per note; findings do the
cross-referencing.

If you are still unsure, say where you think it goes in one short sentence and
let them correct you. A stated guess is fine; a shrug is not.

## Step 2 — Ask the one consent question

**Exactly one question per capture, and you must ask it with the
`AskUserQuestion` tool.** Not as prose in your reply, not as a yes/no you infer
from context. A click, not a sentence typed back at you.

Two options. Nothing else:

```
AskUserQuestion({
  questions: [{
    header: "Audience",
    question: "Where should [short title] go?",
    multiSelect: false,
    options: [
      { label: "Project team",
        description: "Shared folders — [the actual paths you will write to]. The six of us can see it." },
      { label: "Just me",
        description: "users/<name>/ — your private space, never synced, nobody else sees it." }
    ]
  }]
})
```

- **Project team** → `classification: internal`, continue.
- **Just me** → write under `users/<name>/`, tell them where, **stop here.** Nothing else runs. No findings, no quick wins, no registers.

**Fill the descriptions with the real paths for this capture**, not the
placeholders. The whole point of a clickable choice is that they can see what
they are agreeing to without asking a follow-up question.

**Say "shared", never "public".** The repo is private, the client cannot see it, and on
a compliance-sensitive engagement a prompt that reads "public" will make someone
hesitate over something perfectly safe, or worse, misunderstand what they just
agreed to.

**Do not offer a client-review option.** `client` is a real classification and
the guard still accepts it, but it is not offered at capture, the same way
`portfolio` is not. Flagging something as a client candidate is a separate,
deliberate act taken later against a file that already exists. If someone says
the material is client-ready, file it `internal` and tell them in one line that
promoting it is a separate step.

### Multi-file captures

If the capture will touch several files, list them once in the question text and
let one answer cover the set. Partial approval is still valid: the tool's
**Other** option takes free text, so "do the findings but keep the transcript
private" comes back that way and you should honour it exactly.

**Never write to a shared folder without an explicit yes.** Not once. If the
tool call is interrupted or dismissed without an answer, that is not a yes.

## Step 3 — File the raw thing

Write it to the right `00-source-documents/` subfolder with full frontmatter per
`schema/frontmatter.md`: `owner` is the capturing person, `date` and `updated`
today, `type` and `area` per the table above. **Raw records get no `title` or
`description`**: they are filed as received and are listed by filename in the
folder's index.

For anything large or binary — recordings, decks, big exports — **do not put the
file in the vault.** Write a `source-summary` note holding the summary plus the
authoritative link, and say you have done that. The 50 MB guard will block it
anyway; better to explain before it fails.

## Step 4 — THE CONSENT GATE (stop and check)

**Check the status line, not the whole file.** Once all three use
cases are granted, reading the whole register on every capture buys
nothing. Grep for the current state instead:

```bash
grep -m1 "^## .* Current state:" 07-governance/ai-native-checklist.md
```

- **Says `GRANTED — all three use cases`** → proceed to step 5. State the basis.
- **Says anything else, or the grep returns nothing** → open the full file and
  work the register rows below. Never assume granted from memory.

**Read the full register, always, when:** the material touches a system, a
document or a named individual that a restriction row might single out; or the
person capturing says the position has moved. Restriction rows live below the
status line and a grep will not see them, which is the one way this shortcut can
be wrong. When in doubt, spend the 1.5k tokens.

Find the row matching what you are holding:

| Use case | Covers |
|---|---|
| **UC-A** | Interview transcripts — synthesis, tagging, theming |
| **UC-B** | Client platform data — GTM/GA4 config, analytics exports, CMS-derived data |
| **UC-C** | Client-supplied documents |
| *(ungated)* | **Publicly served pages.** Crawling and analysing public URLs is public data and needs no consent. |

**If the matching row does not record consent granted:**

1. Keep the filed raw record from step 3.
2. Add `consent-pending` to its `tags`.
3. Say so plainly, in one line: *"Filed. I haven't analysed it — the client's consent for [transcripts / platform data / shared documents] isn't recorded yet, so no synthesis has been done."*
4. **Stop. Do not synthesise, theme, tag beyond filing metadata, or extract.**

Nothing is lost by waiting — once consent lands, the analysis can run over
everything already filed. Say that too, so it does not feel like a dead end.

**Always state which basis you used** — granted consent, or public data. One
short clause is enough.

## Step 5 — Synthesise (only past the gate)

Write a synthesis note in the matching `02-discovery/` subfolder. Structure it by
**4P and lens**, using the same keys as the pre-discovery inventory so seeded and
new findings sort together:

- **Pillars:** People · Process · Product · Platform
- **Lenses:** `Ext` external/customer-facing · `Int` internal/operational · `Biz` commercial

Keep **what they said** separate from **what you think it means.** Their framing
first, your read second. On a listening-first engagement that distinction is the
work, and the templates enforce it.

**Give every note you write a `title` and a one-line `description`** in its
frontmatter (the templates carry both). The description says what the note is and
its topic, in neutral terms, and nothing else: no findings, no opinions or
characterisations of anyone, no private or off-record context. The folder index
copies it word for word, so write it to be read aloud in a room. Do not mention
indexes to the person; they are regenerated automatically.

### Never fill a gap with a plausible guess

**This is the failure mode that has actually happened, and it is invisible on
read-back** — a fabricated detail reads exactly like a captured one.

Auto-transcripts are garbled, people trail off, and titles go unstated. When the
source does not tell you something, the answer is `[TBC]` or a flagged
inference, **never** a confident-sounding fill:

| Temptation | What to do instead |
|---|---|
| Naming someone's job title because you need one for context | Cross-check `05-stakeholders/stakeholder-map.md`. If it is not there and they did not say it, write what they *did* say about their role |
| Describing what a person did, when the source only names them | Name them and say the source does not state their role. Raise a loop-back question |
| Resolving a garbled word into a real product, system or person | Mark it inline: *"garbled as 'X' in the transcript; read as Y — [who judged it], [date]"*. The resolution may well be right; it still has to be visible as a judgement |
| Asserting something is *not* already recorded ("this isn't in the RAID tracker") | Open the file and check before writing the claim. If you did not check, do not make the claim |
| Smoothing a quote by dropping fillers, then presenting it in quotation marks | Quote exactly, or use an ellipsis. A tidied quote is a paraphrase and should not wear quotation marks |

**Cross-check every proper noun before it enters a synthesis or a findings row.**
Names, titles and team attributions from speech-to-text are unreliable, and a
wrong name propagates into every downstream citation. Two references, and they
cover different things:

| Kind of proper noun | Check against |
|---|---|
| **People** — names, titles, team attributions | `05-stakeholders/stakeholder-map.md` |
| **Products, agencies, systems, programmes, places** | `01-engagement/glossary.md` — the **transcript aliases** table |

**Read the glossary's two operational tables before you synthesise.** The aliases
table already holds resolutions somebody made in an earlier session — e.g. a
garbled "perfection" resolved to the actual product name, or a mis-heard
codename resolved to the system it refers to. Applying one is not guessing; it
is reusing an evidenced read, and it still gets marked inline as a resolution.

**The `deliberately unresolved` table is binding.** If a garble appears there,
leave it `[TBC]` and log a loop-back. Do not re-resolve a term that has already
been judged unresolvable.

**Then write the resolution back.** A garble you resolved this run is a garble
somebody resolves again next run unless it lands somewhere reusable:

- **Resolved a new garble?** Append a row to the glossary's **transcript aliases**
  table — heard as, read as, confidence, your name, the date.
- **Looked at one and could not resolve it?** Append it to **deliberately
  unresolved**, with the context it appeared in. That is as useful as a resolution.
- **Resolved something already sitting in `deliberately unresolved`?** Move the row
  up into the aliases table rather than leaving both.

This is the only file `capture` maintains that is a *reference* rather than a
record, and it is the reason nobody should be typing a proper-noun preamble at the
top of a transcript.

**Preserve the interviewee's own ordering when they rank something.** If they
name their biggest problem first and you lead with their second, you have
changed their answer. Keep their sequence, and keep hard numbers they gave you.

If you compiled a table, add the verification line as the first line under the
title, **left unfilled** for the owning human:

```
verification: [name] checked [N] of [M] rows on [YYYY-MM-DD] - result: [pass | issues noted below]
```

Never fill it in yourself. That line is the human's signature.

## Step 6 — Append the findings

For each finding, append **one row at the bottom** of the matching pillar file
under `02-discovery/findings/`:

```
| date | author | lens | basis | finding | evidence source | severity |
```

- `author` — the capturing person, always. Credit is the point.
- `evidence source` — a path that **resolves**. Cite the **most specific** thing you can: a section anchor in the source record beats the synthesis note, which beats the file as a whole. **No orphan findings**, and no eight findings all pointing at the same file — that is untraceable in practice even though it passes the letter of the rule.
- `severity` — `high` / `medium` / `low`

### `lens` — choose it, do not default it

`Ext` external or customer-facing · `Int` internal or operational · `Biz` commercial

**A finding may carry more than one** — write `Ext, Int`. Many genuinely do.

**Stop and think for each row.** The commonest failure is tagging everything
`Int` because the material is about internal process. Ask what the *consequence*
touches, not what the document is about:

| Looks internal, but… | Lens |
|---|---|
| A publishing default that leaves pages unindexed | `Ext` — customers cannot find them |
| Editors not tagging content consistently | `Ext, Int` — site search degrades for customers *and* editors work harder |
| A regulatory review process applied inconsistently | `Int, Biz` — operational, and a compliance exposure |
| Agencies unaware of a design-system restriction | `Int` — genuinely internal |

If every finding in a capture came out `Int`, you have almost certainly not
looked hard enough. Re-read them.

### `basis` — how do we know this?

**This is the column that keeps the playback defensible.** Three values:

| Value | Means | Example |
|---|---|---|
| `observed` | Someone told us, or we saw it directly | "Three interviewees said content approval takes weeks" |
| `documented` | A client document states it as fact | "The SOP mandates Site Editor certification" |
| `inferred` | **Our reasoning**, not something we were told or read | "Certification is probably applied inconsistently, given low SOP engagement" |

**Be honest about `inferred`.** A hypothesis built from a document plus a
remark is legitimate and worth logging — it tells the team what to test. But if
it is logged as though observed, it reaches the playback as an assertion nobody
verified, and the first time the client asks "how do you know?" it falls over.

**Every `inferred` finding should also produce a loop-back question** that would
confirm or kill it. If you cannot write that question, the inference is too
vague to be useful.

Phrase `inferred` findings so the reasoning is visible: *"X is likely, because
the SOP requires Y and the SOP owner reports low engagement"* — not just
*"X is likely"*.

**Append only. Never edit or renumber an existing row**, even to fix a
duplicate — leave both and let the DM merge at curation. Editing another person's
row is the one thing that turns this file into a merge conflict.

**No blank lines inside the table.** A blank line ends a Markdown table — the
rows below it lose the header and render as raw pipe-delimited text. Append
your new row directly under the last existing row, with no blank between them,
even when it means a different author's row now sits immediately above yours.
Author grouping is not worth a broken table.

Put each finding in the pillar it belongs to. One finding can legitimately land
in two pillars; write it in both, with the same evidence path.

### One question to ask yourself on every client document

**Is this current, and is it what people actually use?** A governance document,
process map or standard is only a baseline if it is live. If you cannot tell its
vintage or whether a later version supersedes it, that is a loop-back question,
and often a more valuable one than anything in the document itself.

## Step 7 — Quick wins

We are on the hook for a quick wins shortlist. It is built here, one capture at
a time, rather than assembled from memory at the end.

**Run this after the findings, never before.** A quick win is derived from a
finding: you cannot spot one until you have written the problem down. And it is
synthesis, so it sits **behind the same consent gate** as step 5. No consent
row, no quick wins.

### The gate — all three, or it is not one

1. **Deliverable before the 2.0 programme mobilises.** Not "eventually cheap".
2. **No dependency on the 2.0 platform decision.** If it needs the new platform it is roadmap input.
3. **Ownable by someone who exists today.** No new role, team or budget line.

Anything failing the test still matters. **Do not log it here — log it as a
roadmap candidate instead**, one row at the bottom of
`03-deliverables/roadmap/roadmap-candidates.md`:

```
| date | author | candidate | why it is roadmap not scope | pillar | evidence source | status |
```

Status is `candidate`; check `project-config.md`'s folder ownership table for
who owns the roadmap deliverable — they move rows to `accepted`, `deferred`
or `rejected`. The **"why it is roadmap not scope"** cell is the one that
earns its place — name which of the three gates it failed, or say that it is
a client expectation sitting outside the agreed scope.

**Two routes reach this file**, and the second is easy to miss:

1. A quick-win candidate that failed the gate
2. **A client expectation voiced in an interview that is outside our scope.** When someone says they hope this engagement produces something the agreed scope does not cover, that is a roadmap candidate *and* usually a scope risk — log the candidate here and draft the RAID row per step 8.

**Why this exists:** this instruction used to end at "say so in your report and
move on", with nowhere to put it. Items were mentioned once in a report and then
lost, because a report is not a register. If the roadmap file does not exist
yet, create it with `owner:` set to whoever `project-config.md`'s folder
ownership table names for the roadmap deliverable, and tell them in your
report that you did.

### What a quick win sounds like

- *"we could just…"*, *"we keep meaning to…"*, *"nobody's ever…"*
- a wrong default or setting, where the fix is a configuration change rather than a project
- a gap between a documented standard and actual practice, where the fix is enforcement rather than building
- duplicated effort that one decision would collapse
- **something already working in one market or team and not adopted in another** — the best class we have: low-risk, already evidenced, and the easiest to walk past on a multi-market programme. Look for it deliberately.

### Then append the row

One row at the bottom of `02-discovery/quick-wins.md`:

```
| date | author | pillar | quick win | effort | impact | basis | evidence source | status |
```

- **quick win** — phrase it as the *action*, with the problem visible in it.
- **effort** `S`/`M`/`L`, **impact** `high`/`medium`/`low`, **status** `candidate` for anything you are adding.
- **basis** — the honest bit, and the reason this column exists. You almost never know the client's internal constraints, so an effort call you reasoned your way to is `inferred`, not `observed`. **Every `inferred` row needs a matching loop-back question in step 9** that would settle it.
- **evidence source** — the findings row this came from. **No orphan quick wins.**
- **impact is not the finding's `severity`.** Severity is how bad the problem is; impact is how far this fix moves it.

### The failure mode to avoid

**Most captures produce no quick wins, and that is the normal outcome.** Say
"nothing here cleared the quick wins gate" and mean it. Manufacturing one per
capture to look useful is the same failure as tagging every finding `Int`, and
it is worse in its effect: a shortlist padded with things that are not quick and
do not win is one the client stops reading.

**One wording trap.** `agency rationalisation` is in
`SETUP/hooks/blocked-terms.txt`, and agency consolidation is a natural quick
win. Write the row about the specific duplicated activity and what collapsing it
would save. Do not reach for the blocked phrase and do not work around the guard.

## Step 8 — Delivery and value signal

Sweep **every** capture for these, whatever its type. A single interview can
carry a risk, an action, a decision and a lesson, and all four are lost if
nobody looks.

**How the consent gate applies here.** It turns on *whose* material the signal
comes out of, and the answer is not the same for the whole step:

- **Our own material is ungated.** An internal team meeting, our stand-up, our retro, our own working observation. A lesson about how CreateFuture is running this engagement is ours to write, and always was.
- **Client material is gated, because pulling a risk out of a transcript is extraction.** Step 4's rule says "or extract" and it means it. If the consent row is not recorded, file the raw record and stop, exactly as you would for findings.

The distinction is the *source*, not the destination. "The SME is away for three
weeks" lifted from an unconsented interview is gated even though it lands in our
RAID tracker. The same fact said to you in a CF stand-up is not.

**RAID is about *our* delivery, not the client's problems.** A risk belongs in
`raid-tracker.md` only when it threatens CreateFuture delivering this
engagement — stakeholder availability blocking our interviews, access
constraining our audit. **The client's own organisational risks are findings**, and
reach the client through the playback. A client capability gap is a
high-severity findings row, not an `R0xx`. Getting this wrong makes the
delivery register unreadable and blurs whose problem is whose.

| You spotted | Goes to | Who may write it |
|---|---|---|
| A risk, assumption, issue or dependency **to our delivery** | `04-delivery/raid-tracker.md` | **the RAID owner named in `project-config.md`'s register owners table, only** |
| A decision made, including scope changes | `04-delivery/decisions.md` | **the decisions owner named in `project-config.md`, only** |
| Something someone committed to do | `04-delivery/actions-log.md` | the actions owner named in `project-config.md`, or their deputy per the folder ownership table |
| A lesson about how *we* are working | `06-value-and-lessons/lessons-learned.md` | anyone |
| A QBL proof point — quicker, better, leaner | `06-value-and-lessons/value-register.md` | anyone |

**Always check `project-config.md` for who this actually is** — never assume
a name from a previous capture or from memory. The register owners table and
the folder ownership table are the source of truth, and they can change
mid-engagement.

### If the capturing person may not write the register

**Do not write it anyway, and do not silently drop it.** Draft the row and put
it in `04-delivery/review-queue.md` addressed to the owner named in
`project-config.md`, with the path:

```
| date raised | by | what needs looking at (with path) | who it's for | by when | status |
```

Anyone may add to the review queue — that is what it is for. Put the proposed
row itself in the "what needs looking at" cell so the owner can paste it
straight in rather than reconstruct it from the source.

**Why the restriction:** the RAID and decisions registers use ID sequences
(`R0xx`, `A0xx`, `I0xx`, `D0xx`, `DEC0xx`) with a never-renumber rule. Two people
capturing at once would both take the next number, and unlike a duplicate
findings row, a duplicate ID cannot be merged away afterwards. One writer keeps
the sequence sound.

### If you are writing to RAID, decisions or actions

**Read the file for the next ID before adding.** Never reuse one, never
renumber an existing row. Append at the bottom.

### Lessons have one rule

Lessons are about **what happened, never about who fell short.** If a lesson
needs a colleague's name to make sense, it needs rewriting. This is the shared
layer: the test is whether that person would be comfortable reading it about
themselves, knowing you wrote it. If the useful lesson genuinely cannot survive
that rewrite, it is a DM conversation, not a vault row.

## Step 9 — AI-native evidence ledger

**Only when this capture actually synthesised something.** A filing-only run —
gate not cleared, or a raw record dropped in with no analysis — produces no line.
The ledger records AI-assisted *working*, not AI-assisted *filing*.

One line, at most, per capture, appended to
`07-governance/ai-native-evidence-log.md`:

```
| date | source | UC | operations | verified |
```

| Column | What goes in it |
|---|---|
| `date` | Today |
| `source` | What was processed, one clause, with duration or size if it has one — *"SME interview, s12, 52m Teams transcript"* |
| `UC` | The consent basis you confirmed in step 1: `UC-A`, `UC-B`, `UC-C`, `public`, or `internal`. **Never blank.** |
| `operations` | Counts in the file's shorthand — *"5F 1QW 3LB 2A"*. Numbers, not sentences. |
| `verified` | `no`, until a human signs the `verification:` line on the synthesis. Only `yes` if they already have. |

### Write counts, not prose

**This table is counted, not read.** One line means one line: no "load-bearing
judgement" paragraphs, no description of what you noticed, no mechanism. The
ledger answers *what was processed, under what permission, producing how much* —
nothing else.

This table used to hold a paragraph per run on an earlier engagement. It grew
unmanageably large within days, and the only thing anything downstream ever
cited was the row count. If you find yourself writing a second sentence, you
are writing the wrong file.

### If the run produced a story, it goes in the value register

**That is step 8, not here.** A genuine proof point — a contradiction caught
before it reached a deliverable, a defect corroborated from two independent
sources, a pattern only visible because four pillar files were read in one pass —
earns a row in `06-value-and-lessons/value-register.md`, where there is a column
for the story it enables and a dimension to file it under.

Most runs do not produce one, and **that is the normal case.** The register
typically holds far fewer rows than the ledger, and that ratio is about right.
Do not manufacture a value row to make a capture feel significant.

### Never estimate time saved

**There is no time-saved column any more, and you must not reintroduce one.** It
was left `[TBC]` in practice, every time, because "how long would this have
taken a person" is not answerable per run — least of all retrospectively, by
you.

The comparison is made once, against the recorded baseline in the value register's
`## The baseline` block, and the person who did the work owns it. Same for quality
gain: *"found things a human would have missed"* is marketing, not evidence.

### Who may write it

`07-governance/` belongs to whoever `project-config.md`'s folder ownership
table names for it (the DM, in the standard structure). **If that person is
capturing, append the line.** If anyone else is, draft it into
`04-delivery/review-queue.md` addressed to them, exactly as step 8 does for
RAID and decisions — put the proposed line itself in the "what needs looking
at" cell.

### Why this step exists

**Traceability, first.** The client is compliance-sensitive, and consent to AI-process
their material is granted per use case in `07-governance/ai-native-checklist.md`.
The ledger is what makes that consent auditable after the fact: every AI-processed
source, and the permission it ran under, on one line. A capture run is the only
moment that basis is known for certain — you just checked it in step 1. Recording
it costs four characters.

**Counts, second.** The value register cites this table's totals. A number
compiled from the ledger is checkable; a number remembered on the Thursday before
a playback is a guess.

This is not the QBL value register from step 8. That one records value delivered
**to the client**; this records what we processed and under whose permission. A single
capture always produces a ledger line and only sometimes produces a value row.

## Step 10 — Loop-back questions

Anything the material raised that still needs asking → append to
`02-discovery/loop-back-questions.md`:

```
| date raised | question | who can answer | raised from | status |
```

**This matters more than it looks.** Assess is two weeks for fifteen interviews
across a narrow UK/US window in mid-summer. The gap that hurts is the one nobody
notices until Synthesise, when the person who could have answered it is on
holiday. Logging it now is the difference.

## Step 11 — Interview coverage

If what you captured was an interview, update
`02-discovery/interview-coverage.md`: mark that group and person as held and
synthesised, and carry anything still outstanding into the last column.

## Step 12 — Report back: every file, one bullet each

Not a wall of text, but **not a totals summary either.** Show every file you
touched, one bullet each, with a **clickable link**, whether it was created or
appended to, and what changed.

### Never put this report in a code block

**A fenced code block is wrong here, every time.** Paths inside one are dead
text: nobody can click through to review what you wrote, which is the single
thing this report exists to enable. Column-aligned padding also wraps into
nonsense the moment the pane is narrow, so the tidy version you imagined is not
the version anyone reads.

Write it as **prose and Markdown bullets**, with each path as a link:

> **Written:**
>
> - [00-source-documents/call-notes/2026-07-29-stakeholder-interview.md](00-source-documents/call-notes/2026-07-29-stakeholder-interview.md) — new file. Raw interview note, filed under UC-A, consent granted 2026-07-26.
> - [02-discovery/interviews/2026-07-29-stakeholder-interview-synthesis.md](02-discovery/interviews/2026-07-29-stakeholder-interview-synthesis.md) — new file. 4P synthesis, their framing kept separate from our read. `verification:` line left unfilled for you.
> - [02-discovery/findings/product.md](02-discovery/findings/product.md) — 3 rows appended, all `observed`, covering search, IA and the publishing default.
> - [02-discovery/findings/process.md](02-discovery/findings/process.md) — 2 rows appended, one of them `inferred` (approval delay, with a loop-back question to settle it).
> - [02-discovery/quick-wins.md](02-discovery/quick-wins.md) — 1 row appended as `candidate`: set the publishing default to indexable.
> - [04-delivery/review-queue.md](04-delivery/review-queue.md) — 1 row for the RAID owner, a proposed risk drafted rather than written, since a colleague other than the register owner captured this one.
>
> **Quick wins:** one candidate, above.
> **Notable:** the SME availability point is worth a check with Jason before w/c 27th.

Link text is the path itself, relative to the vault root, so it stays scannable
and clickable at once. **The description earns its place** — say what changed
and anything about it worth knowing, not just `(+3 rows)`.

**Say when a register got nothing, if you looked and it was empty.** One clause
is enough: *"Quick wins: nothing here cleared the gate, this is a planning
document rather than operational evidence"*, *"no RAID signal in this one"*.
Silence reads as "not checked", and the whole point of steps 7 to 9 is that
someone can trust they were.

**Never collapse a per-file change into an aggregate count.** "Findings: 5
across pillars" hides which pillar files were touched and by how much; "Filed:
X" hides whether a file was created or an existing one appended to. The DM
curates this vault and needs to see, at a glance, exactly what changed so
they can review or roll back individually.

If a single capture wrote to eight files, show eight bullets.

After the file list, add any callouts that don't fit the per-file lines: the
AI-processing basis you used, notes left for the human (e.g. the unfilled
`verification:` line), or anything you deliberately did not do and why. If
nothing notable came out of the material itself, say that plainly rather than
padding.

## Before you report: the completion check

**A capture is not finished when the synthesis note is written.** The synthesis
is the most satisfying part and the easiest place to stop, and stopping there
has happened — a good note filed with none of the downstream rows, so the
findings register, the loop-back list and the coverage tracker all silently
missed an entire interview.

Run this list before you write the report. Every line gets an answer, and
"nothing here" is a valid answer you must **say out loud**, not assume:

- [ ] Raw record filed, frontmatter complete (step 3); every note you wrote has a `title` and a neutral one-line `description` (step 5)
- [ ] Consent basis stated explicitly — granted, or public data (step 4)
- [ ] Synthesis written, 4P + lens, their framing separate from our read, `verification:` line left blank (step 5)
- [ ] **Findings rows appended to every pillar they touch** — People, Process, Product, Platform. If only one pillar got rows from a substantial interview, re-read it (step 6)
- [ ] Proper nouns cross-checked — people against the stakeholder map, products and systems against the glossary's alias table; every guess marked as a guess (step 5)
- [ ] **Glossary updated**: new garble resolutions appended to the alias table, new unresolvable ones to `deliberately unresolved` (step 5)
- [ ] Quick wins considered against the three-part gate — including "nothing cleared it" (step 7)
- [ ] Delivery signal swept: RAID, decisions, actions, lessons, value (step 8)
- [ ] AI-native ledger line appended or drafted, if this run synthesised — counts only, `UC` never blank, no prose (step 9)
- [ ] Loop-back questions appended, **and one for every `inferred` row** (step 10)
- [ ] Interview coverage updated, if it was an interview (step 11)

If the capture is one part of a split session, say so in the synthesis and in
the coverage row, and name what the missing part still owes.

## Rules that do not bend

- **One consent question, asked with `AskUserQuestion`.** Two options, Project team or Just me. Never a checklist, never a second prompt for the same capture, never a question typed as prose when the tool is available.
- **Never offer a client-review option at capture.** File it `internal`; promoting to `client` is a separate, later act.
- **Never write to a shared folder without an explicit yes.** A dismissed or unanswered prompt is not a yes.
- **Never synthesise client material without its consent row.** Filing is always fine; analysing is not.
- **Never write a finding without a resolving `evidence source`.**
- **Never log a quick win that fails the three-part gate.** Roadmap input is not a quick win, and saying so is more useful than padding the shortlist.
- **Never write to `raid-tracker.md` or `decisions.md` unless the capturing person is the owner `project-config.md` names for that register.** Draft the row into the review queue instead. Same for `actions-log.md` unless it is that register's named owner or deputy.
- **Never reuse or renumber a register ID.** Read the file for the next one.
- **Never fill in a verification line.** Leave it for the human.
- **Never report back in a code block.** Markdown bullets with clickable links, always. A path nobody can click is a path nobody checks.
- **Never edit another person's findings row.**
- **Never use `git commit --no-verify`.** If the safety check blocks something, that is it working — read the message, report the plain-English reason, fix the file.
- **Never put budget, rates, margins, per-person allocation, personnel commentary or off-record context into the shared layer.** If the material contains it, file what is safe, say what you left out, and tell them why.

## If the safety check blocks you

It names the file, the reason and the fix. Report that to the person in plain
language, do what it says, and carry on. Do not work around it and do not retry
with `--no-verify`. If the reason genuinely does not apply, tell them to raise it
in the Slack channel — the rules are meant to be adjustable, unlike a leak.
