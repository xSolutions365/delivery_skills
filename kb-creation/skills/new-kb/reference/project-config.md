---
type: manifest
owner: "[DM name]"
area: governance
classification: internal
status: active
date: "[YYYY-MM-DD]"
updated: "[YYYY-MM-DD]"
tags: [config, manifest]
---

# Project config

The settings every skill reads first. **Every value below is a placeholder.**
Run `configure-engagement` before inviting anyone in — nothing downstream of
it should be trusted until this file says something real.

## Engagement

| Field                      | Value                                                        |
| --------------------------- | ------------------------------------------------------------- |
| Engagement                 | [Engagement name]                                            |
| Client                     | [Client name]                                                |
| Vault type                 | [shared team vault (multiplayer, per-person private spaces) \| single-player] |
| Repo                       | `[org]/[repo-name]` (private)                                |
| Local path                 | `[local clone path]`                                         |
| Phases                     | [Phase 1] · [Phase 2] · [Phase 3] · ...                      |
| Dates                      | [Start date] – [End date]                                    |
| Support / recovery channel | [Slack channel]                                              |

## Roster

| Role     | Person   | Vault access |
| -------- | -------- | ------------ |
| [Role]   | [Name]   | [owner \| an onboarded date \| admin \| curated-by-DM] |

`vault_access` values: `owner` · an onboarded date · or `curated-by-DM` for
anyone who would rather not use the vault directly. **`curated-by-DM` is a
valid end state, not a defect** — the DM curates their outputs in and nobody
chases them.

## Register owners

| Register                  | Owner           | Notes                         |
| -------------------------- | --------------- | ------------------------------ |
| RAID                       | [DM name]       |                                |
| Actions                    | [DM name]       |                                |
| Decisions                  | [DM name]       |                                |
| Findings (4 pillar files)  | **team-append** | Anyone appends; DM curates    |

## Launch contract

| Decision | Value |
|---|---|
| `client_material_allowed` | `[true \| false]` — approved by [who], [when] |
| AI-processing consent | **Separate gate from the line above.** Storing approved client material is the DM's call; *analysing* it is the client's — see `07-governance/ai-native-checklist.md`. Never conflate the two. Current status: `[GRANTED \| NOT YET GRANTED]` |
| Allowed formats | [All formats \| specific restrictions] |
| File-size limit | 50 MB per file |
| Enabled modules | `capture`, `onboard` — do not enable anything the team has not actually installed |
| QBL focus | [Quicker / Better / Leaner — which, and whether confirmed with the client or still proposed] |
| Content ownership | `[TBC]` |

## Path mapping

Logical name → path. **Read this to resolve where anything lives; it is the
source of truth.** This table matches the standard folder structure — only
change it if this vault's folder shape itself has been customised.

| Logical name | Path |
|---|---|
| `raid_tracker` | `04-delivery/raid-tracker.md` |
| `actions_log` | `04-delivery/actions-log.md` |
| `decisions` | `04-delivery/decisions.md` |
| `phase_tracker` | `04-delivery/phase-tracker.md` |
| `review_queue` | `04-delivery/review-queue.md` |
| `stakeholder_map` | `05-stakeholders/stakeholder-map.md` |
| `changelog` | `07-governance/changelog.md` |
| `source_documents` | `00-source-documents/` |
| `lessons_learned` | `06-value-and-lessons/lessons-learned.md` |
| `value_register` | `06-value-and-lessons/value-register.md` |
| `findings_people` | `02-discovery/findings/people.md` |
| `findings_process` | `02-discovery/findings/process.md` |
| `findings_product` | `02-discovery/findings/product.md` |
| `findings_platform` | `02-discovery/findings/platform.md` |
| `quick_wins` | `02-discovery/quick-wins.md` |
| `loop_back_questions` | `02-discovery/loop-back-questions.md` |
| `interview_coverage` | `02-discovery/interview-coverage.md` |
| `inflight_dedup` | `02-discovery/inflight-dedup.md` |
| `ai_native_checklist` | `07-governance/ai-native-checklist.md` |
| `ai_native_evidence_log` | `07-governance/ai-native-evidence-log.md` |

## Folder ownership

Conflict avoidance is separate files plus nominated owners — not branches.

| Area | Owner |
|---|---|
| `04-delivery/`, `07-governance/` | [DM name] |
| `02-discovery/findings/` | team-append, DM curates |
| `02-discovery/quick-wins.md` | team-append, DM curates |
| `04-delivery/raid-tracker.md`, `decisions.md` | [DM name] only — others use the review queue |
| `04-delivery/actions-log.md` | [DM name], [deputy name] as deputy |
| `04-delivery/review-queue.md`, `06-value-and-lessons/` | anyone may append |
