---
name: iso-compliance-check
description: Audit a delivery knowledge base against CreateFuture ISO requirements. Use when the user says "check ISO compliance", "ISO audit", "check against ISO", "compliance check", "does the KB meet ISO requirements", or "run the ISO check". Produces a structured report with RAG status per requirement and remediation steps for any gaps.
---

# ISO Compliance Check

Audit the current knowledge base against the seven CreateFuture ISO delivery requirements and produce a structured compliance report.

## The seven ISO requirements

Each project must have all of the following. These are the reference definitions drawn from the CreateFuture Delivery Framework templates.

---

### 1. Project Initiation Document (PID)

A document covering all of:
- **Document management** — contributors, approvers, revision history
- **Introduction** — engagement title, delivery manager, start and end dates
- **Project overview** — product description, project brief, objectives, scope (in-scope and explicitly out-of-scope), deliverables, delivery approach, governance approach
- **Stakeholder analysis** — key stakeholders, needs assessment, communication plan, RACI
- **Risks and issues** — RAID log reference, escalation management process
- **Project schedule** — plan on a page / roadmap, major dependencies, casting / resource plan
- **Project budget** — benefit targets, cost estimates, funding sources
- **Project approval** — named project sponsor, approval criteria

*KB mapping:* `01-project-overview/high-level-brief.md`, `01-project-overview/README.md`, `01-project-overview/success-criteria.md` — together these must cover the PID sections above.

---

### 2. Stakeholder Map

A document covering:
- **Stakeholder identification** — all key stakeholders identified and mapped to a Power/Interest grid (high/medium/low)
- **Stakeholder register table** with columns: Name, Role/Department, Level of Interest, Level of Influence, Key Expectations/Concerns, Contact Info
- **Communications plan table** with columns: Stakeholder, Communication Objective, Message/Info to Share, Frequency, Method/Channel, Relationship Owner

*KB mapping:* `05-stakeholders-comms/stakeholder-map.md`, `05-stakeholders-comms/comms-plan.md`

---

### 3. Dependency & Integration Map

A document covering:
- **Overview & purpose** — clear statement of what dependencies are being tracked and why
- **Dependency categories** — Technical, Resource, Third-Party, and Client-side dependencies identified separately
- **Dependency register table** — each dependency with: ID, description, category, owner, target date, status
- **Integration points** — diagram or description of how systems/teams integrate (can reference a Miro board or equivalent)
- **Key risks & mitigations** — risks arising from the dependencies, with mitigations
- **Review cadence** — how often the dependency map is reviewed and by whom

*KB mapping:* `03-raid-log/raid-tracker.md` (Dependencies section), `06-technical-artefacts/integrations.md` — these together must cover the above, or a dedicated dependency map must exist.

---

### 4. Discovery Playbook / Report

A document covering:
- **Executive summary** — one-page overview of the discovery engagement
- **Client context & objectives** — what the client does, what they're trying to achieve
- **Problem statement / opportunity** — the specific problem this engagement addresses
- **Discovery activities** — what was done (interviews, workshops, artefact analysis, etc.) and with whom
- **Key findings & insights** — the headline findings from discovery
- **Current state assessment** — where the client is today
- **Future state vision / target outcomes** — what good looks like post-delivery
- **Recommendations & prioritisation** — what CreateFuture recommends, in priority order
- **Next steps & transition to delivery** — how discovery converts to delivery
- **Appendices** — workshop outputs, interview notes, supporting materials

*KB mapping:* `01-project-overview/discovery-findings.md`

> Note: This document is only required once Phase 1 (Discovery) is complete. If discovery has not yet concluded, mark as N/A with a target date.

---

### 5. RAID Log

A single consolidated log tracking all four categories:
- **Risks** — with ID, description, probability (1–3), impact (1–3), risk score, mitigation, owner, status, last updated, next update date
- **Assumptions** — with ID, description, owner, status, last reviewed date
- **Issues** — with ID, description, priority (High/Medium/Low), owner, status, raised date, last updated
- **Dependencies** — with ID, description, category, owner, target date, status

All open items must have a named owner. High-impact risks (score 6+) must have a mitigation. Issues that have been open >14 days without owner or update are a gap.

*KB mapping:* `03-raid-log/raid-tracker.md`

---

### 6. Change Control Process

Evidence that a formal change control process is in place, covering:
- **CR form** — a template for raising a Change Request with: title, description, user acceptance criteria, justification, effort estimate, cost/time impact statement, priority, approvers, decision, decision date
- **CR log** — a running log of all change requests with their status and decisions
- **Process definition** — a description of the end-to-end change control process: who identifies a change, who assesses impact, who approves, timelines (no more than 1 week end-to-end is the standard), and what triggers re-baselining vs re-prioritisation
- **Change control note (CCN) template** — a formal document for agreed changes including CCN number, period of validity, reason for change, impact description, price adjustment, and dual signatures (customer and supplier)

> The key principle: change control is only effective if there is a clear baseline (time/cost/quality/scope) to manage it against. Check that the budget tracker and roadmap provide that baseline.

*KB mapping:* `02-budget-commercial/change-log.md` — must contain the defined process and a CR log. CCN template may be stored externally (Google Drive) but must be referenced.

---

### 7. Governance Plan

A document covering all of:
- **Governance principles** — 3–5 stated principles (e.g. transparency, accountability, continuous improvement)
- **Roles & responsibilities (RACI)** — matrix covering: programme direction, phase sign-off, sprint scope, risk escalation, commercial changes, technical decisions, status reporting
- **Governance structure** — hierarchy of forums from exec steering down to sprint ceremonies
- **Forum catalogue** — table with: forum name, attendees, frequency, purpose, owner — must include at minimum a steering committee, weekly delivery sync, and sprint ceremonies
- **Escalation pathway** — defined steps from issue raised → delivery manager → client lead → exec sponsor, with timescales at each step
- **Reporting cadence & formats** — who gets what report, how often, in what format; must include weekly status report and phase completion report
- **Tooling** — what tools are used for what purpose (PM tool, comms, documentation, dashboards)

*KB mapping:* `07-governance/governance-plan.md`

---

## Workflow

### Step 1: Read every relevant KB file

Read all of the following files before forming any assessment. Do not shortcut this.

**Project overview:**
- `01-project-overview/README.md`
- `01-project-overview/high-level-brief.md`
- `01-project-overview/success-criteria.md`
- `01-project-overview/discovery-findings.md`

**Budget & commercial:**
- `02-budget-commercial/budget-tracker.md`
- `02-budget-commercial/change-log.md`
- `02-budget-commercial/benefits-register.md`

**RAID log:**
- `03-raid-log/raid-tracker.md`

**Delivery planning:**
- `04-delivery-planning/roadmap.md`
- `04-delivery-planning/decisions.md`

**Stakeholders & comms:**
- `05-stakeholders-comms/stakeholder-map.md`
- `05-stakeholders-comms/comms-plan.md`
- `05-stakeholders-comms/resource-plan.md`

**Technical artefacts:**
- `06-technical-artefacts/integrations.md`

**Governance:**
- `07-governance/governance-plan.md`

Also check: are there any additional files in the KB not in the above list? If so, read those too — a project may have created supplementary documents that partially or fully address a requirement.

### Step 2: Assess each requirement

For each of the seven requirements, assess:

1. **Does the content exist?** (Not just the file — does it contain substance beyond template placeholders?)
2. **Is it complete?** (Does it cover all mandatory sub-sections listed above?)
3. **Is it current?** (Has it been updated since the project started, or is it stale? Check `last updated` fields.)
4. **Does it have named owners?** (Ownerless items are a gap.)

Assign a RAG status to each requirement:

- 🟢 **Green** — Present, substantially complete, current, all owners named
- 🟡 **Amber** — Exists but incomplete: some mandatory sections missing, stale, or owners absent
- 🔴 **Red** — Absent, empty, or so incomplete as to be non-functional
- ⚪ **N/A** — Not yet required at this stage of the project (e.g. Discovery Report before Phase 1 ends) — only use N/A with an explicit justification and a target date

### Step 3: Cross-reference checks

Run these cross-file checks after assessing individual requirements:

- **PID baseline vs RAID**: The PID defines scope, budget, and timeline. Are any open risks or issues in the RAID log related to changes to that baseline that haven't been reflected in the PID or change log?
- **Stakeholder map vs governance plan**: Does the governance plan's RACI reference people who are actually in the stakeholder map? Are any forum owners listed in the governance plan but absent from the stakeholder map?
- **Dependency map vs RAID**: Every dependency in the dependency section of the RAID should have a corresponding risk if it's at risk of delay. Are there dependencies without associated risks?
- **Change log vs budget tracker**: Have any agreed changes (CRs) been logged in the change log but not reflected in the budget tracker?
- **Roadmap vs discovery findings**: If discovery is complete, do the recommendations in the discovery report align with the phases in the roadmap?

### Step 4: Output format

Produce the report in the following structure:

```markdown
# ISO Compliance Report · [Project Name]
**Reviewed:** YYYY-MM-DD
**Reviewed by:** Claude (iso-compliance-check skill)
**KB location:** [path to KB root]

---

## Overall status

| Requirement | Status | Summary |
|---|---|---|
| 1. Project Initiation Document | 🟢 / 🟡 / 🔴 / ⚪ | One-line summary |
| 2. Stakeholder Map | 🟢 / 🟡 / 🔴 / ⚪ | One-line summary |
| 3. Dependency & Integration Map | 🟢 / 🟡 / 🔴 / ⚪ | One-line summary |
| 4. Discovery Playbook / Report | 🟢 / 🟡 / 🔴 / ⚪ | One-line summary |
| 5. RAID Log | 🟢 / 🟡 / 🔴 / ⚪ | One-line summary |
| 6. Change Control Process | 🟢 / 🟡 / 🔴 / ⚪ | One-line summary |
| 7. Governance Plan | 🟢 / 🟡 / 🔴 / ⚪ | One-line summary |

---

## Priority actions

[Numbered list of the top actions to close the most critical gaps. Order by: Reds first, then Ambers by severity. Max 5 items. Be specific — name the file, the missing section, and the suggested fix.]

---

## Detailed findings

### 1. Project Initiation Document — [RAG]

**What was assessed:** [list of files read]

**Findings:**
- ✅ [What's present and good]
- ⚠️ [What's incomplete or stale]
- ❌ [What's missing]

**Gaps to close:**
[Specific, actionable steps. Link to the ISO requirement sections above. Include suggested content where it would help — e.g. "Add a project sponsor field to high-level-brief.md with the name of the client exec who has signed off on the engagement."]

---

[Repeat for requirements 2–7]

---

## Cross-reference findings

[Findings from Step 3's cross-file checks. Only include if a genuine issue was found — don't pad with "no issues found" entries.]

---

## What this report cannot assess

Be explicit about what Claude can't see from the KB alone:

- Whether a CCN template has been agreed with the client (may be in Google Drive or a separate system)
- Whether stakeholder relationships accurately reflect the current state on the ground
- Whether the budget tracker figures match the actual commercial agreement
- Whether the governance forums are actually happening, not just documented

If any of these limitations are relevant to this project, flag them here.
```

### Step 5: Offer next steps

After presenting the report, offer:

1. "Want me to draft the missing sections for any of the 🔴 Red requirements?"
2. "Want me to update the KB files to close the 🟡 Amber gaps? I'll show you the diff before writing anything."

Apply the standard rule: show the diff, wait for confirmation, then write.

---

## Tone

This report is for a delivery lead who needs to know their compliance position quickly and act on it.

- **Specific, not vague.** "Section 2.4 (Project Scope) in `high-level-brief.md` is a template placeholder" — not "the PID is incomplete."
- **Proportionate.** Don't flag a hygiene issue as a Red. Match severity to actual risk.
- **Honest about N/A.** If discovery genuinely hasn't happened yet, say so and record the expected date — don't downgrade to Amber just to avoid a Red.
- **Not a box-ticking exercise.** The goal is a project that is actually well-governed, not one that has technically filled in every section with placeholder text. If a field is present but obviously a copy-paste placeholder, it counts as missing.
