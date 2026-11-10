---
name: seed-references
description: Create the registry and reference files that capture and onboard assume already exist. Use when someone says "seed the references", "set up the registers", "capture keeps failing to find a file", or after configure-engagement on a fresh vault. Creates schema/frontmatter.md, the glossary, the stakeholder map, and every register and findings file with the correct headers and empty-but-valid content — nothing capture would misfile against, and nothing invented in place of real data.
---

# seed-references

`capture` reads several files on every single run and assumes they exist:
`schema/frontmatter.md`, the glossary, the stakeholder map, all four findings
pillars, and every register under `04-delivery/`, `06-value-and-lessons/`,
`07-governance/`. A bare scaffold does not have these yet. Your job is to
create them **empty of content but correct in structure** — right headers,
right frontmatter, right path — so the first real `capture` run has
somewhere valid to append to.

Run this after `configure-engagement` (you need the path mapping and register
owners from `project-config.md`) and can run before or after `define-roles` —
it does not depend on role bodies.

**You are building scaffolding, not data.** Never write a plausible-looking
example row into a register "so people can see the format" — the templates
under `templates/` already show the shape, and an example row in a live
register gets mistaken for a real one the moment nobody remembers who added
it.

## Step 1 — Read the path mapping

`project-config.md`'s path mapping table is the source of truth for where
each logical file lives. Use it, not the default paths below, if it has been
customised. The defaults match the standard structure:

| File | Default path |
|---|---|
| Frontmatter schema | `schema/frontmatter.md` |
| Glossary | `01-engagement/glossary.md` |
| Stakeholder map | `05-stakeholders/stakeholder-map.md` |
| Findings — people / process / product / platform | `02-discovery/findings/{people,process,product,platform}.md` |
| Quick wins | `02-discovery/quick-wins.md` |
| Loop-back questions | `02-discovery/loop-back-questions.md` |
| Interview coverage | `02-discovery/interview-coverage.md` |
| Inflight dedup | `02-discovery/inflight-dedup.md` |
| Roadmap candidates | `03-deliverables/roadmap/roadmap-candidates.md` |
| RAID tracker | `04-delivery/raid-tracker.md` |
| Actions log | `04-delivery/actions-log.md` |
| Decisions | `04-delivery/decisions.md` |
| Phase tracker | `04-delivery/phase-tracker.md` |
| Review queue | `04-delivery/review-queue.md` |
| Lessons learned | `06-value-and-lessons/lessons-learned.md` |
| Value register | `06-value-and-lessons/value-register.md` |
| AI-native checklist | `07-governance/ai-native-checklist.md` |
| AI-native evidence log | `07-governance/ai-native-evidence-log.md` |
| Changelog | `07-governance/changelog.md` |

Check each path first. **Only create what is missing.** A file that already
exists with real rows in it is a sign this vault is further along than a
fresh seed — skip it and note that in the report rather than overwriting.

## Step 2 — `schema/frontmatter.md`

The one file every other file's frontmatter is checked against. Write it to
cover:

- The required keys and their meaning: `type`, `owner`, `area`,
  `classification` (`internal` / `private` / `client`), `status`, `date`,
  `updated`, `tags`
- The findings row format: `| date | author | lens | basis | finding |
  evidence source | severity |`, with `lens` (`Ext`/`Int`/`Biz`, may be
  more than one) and `basis` (`observed`/`documented`/`inferred`) defined
  inline, matching how `capture` uses them
- The verification line format: `verification: [name] checked [N] of [M]
  rows on [YYYY-MM-DD] - result: [pass | issues noted below]` — left unfilled
  by whoever writes the table it belongs to, filled in only by the human who
  checks it

## Step 3 — Glossary — `01-engagement/glossary.md`

Two tables, both empty except headers, both append-only in normal use:

**Transcript aliases** — resolutions of garbled proper nouns, reusable across
captures:

```
| heard as | read as | confidence | resolved by | date |
```

**Deliberately unresolved** — garbles looked at and left open on purpose,
binding until someone resolves them properly:

```
| heard as | context | raised by | date |
```

## Step 4 — Stakeholder map — `05-stakeholders/stakeholder-map.md`

```
| name | role / title | organisation | notes |
```

Seed it from the roster in `project-config.md` if the DM wants the internal
team in there too; otherwise leave it to fill from real interviews and client
documents as they come in.

## Step 5 — Findings pillars — `02-discovery/findings/{people,process,product,platform}.md`

Same header in all four:

```
| date | author | lens | basis | finding | evidence source | severity |
```

Frontmatter `owner: team-append`, matching the register owners table in
`project-config.md`.

## Step 6 — The remaining registers

Each gets its header row and correct frontmatter (`owner` per the register
owners table in `project-config.md`), nothing below the header:

- **Quick wins** — `| date | author | pillar | quick win | effort | impact
  | basis | evidence source | status |`
- **Roadmap candidates** — `| date | author | candidate | why it is
  roadmap not scope | pillar | evidence source | status |`
- **Loop-back questions** — `| date raised | question | who can answer |
  raised from | status |`
- **Interview coverage** — columns matching however this engagement groups
  interviews (ask the DM if unclear): group, person, booked, held,
  synthesised, outstanding
- **Inflight dedup** — a running list of in-progress work streams, to avoid
  two people capturing the same source twice: `| date | who | what they're
  working on | expected done |`
- **RAID tracker** — `| id (R/A/I/D-0xx) | date raised | type | description
  | owner | status |`. Note the never-renumber ID rule in the file's own
  header comment so it survives being read on its own
- **Actions log** — `| id (A0xx) | date | action | owner | due | status |`
- **Decisions** — `| id (DEC0xx) | date | decision | rationale | owner |`
- **Phase tracker** — one row per phase from `project-config.md`: `| phase
  | dates | status |`
- **Review queue** — `| date raised | by | what needs looking at (with
  path) | who it's for | by when | status |`
- **Lessons learned** — `| date | who | lesson | what we'd do differently |`
- **Value register** — needs a `## The baseline` section above the table (a
  place for the one-time "what would this have taken without AI-native
  working" comparison, owned by the person who does the work — leave it
  `[TBC]`), then `| date | author | QBL dimension | story | evidence source |`
- **AI-native evidence log** — `| date | source | UC | operations |
  verified |`, matching `capture`'s step 9 exactly — counts only, never
  prose, `UC` never blank
- **Changelog** — `| date | who | what changed |`

## Step 7 — `07-governance/ai-native-checklist.md`

This one is a register of consent decisions, not a table — write it with:

- A status line in the exact format `capture` greps for: `## <use case>
  Current state: <GRANTED — ... | NOT YET GRANTED | ...>`, one per use case
  (`UC-A` interview transcripts, `UC-B` client platform data, `UC-C`
  client-supplied documents)
- Set every use case's status from what `configure-engagement` recorded in
  the launch contract. **If that was left open, write `NOT YET GRANTED`
  plainly — do not default to granted because it is the more useful state
  for testing capture.** A wrong-but-convenient status here is exactly the
  kind of gap that reaches a compliance-sensitive client
- A restrictions section below the status lines, empty, with a comment
  explaining what belongs there (named exceptions to an otherwise-granted
  use case)

## Step 8 — Report back

Prose and Markdown bullets, one per file, clickable links, never a code
block. Say what you created, and — just as importantly — what you found
already there and left alone:

> - [schema/frontmatter.md](schema/frontmatter.md) — created.
> - [01-engagement/glossary.md](01-engagement/glossary.md) — created, both
>   tables empty.
> - [02-discovery/findings/people.md](02-discovery/findings/people.md) (and
>   process / product / platform) — created, header only.
> - [07-governance/ai-native-checklist.md](07-governance/ai-native-checklist.md)
>   — created; all three use cases set to `NOT YET GRANTED` per the launch
>   contract. `capture` will file-only and flag `consent-pending` until this
>   changes.
> - [04-delivery/raid-tracker.md](04-delivery/raid-tracker.md) — **already
>   existed with 3 rows** — left untouched.

## Rules that do not bend

- **Never write an example or placeholder row into a register.** Header
  only. A templated-looking row is indistinguishable from a real one to the
  next person who reads the file.
- **Never overwrite a file that already has real content.** Check first;
  report it as found, not touched.
- **Never guess a consent status towards "granted".** Missing information
  writes as `NOT YET GRANTED`, full stop.
- **Never invent path locations.** Use `project-config.md`'s mapping; if a
  logical file has no entry there, that is a gap to flag, not one to
  improvise around.
- **Never report in a code block.**
