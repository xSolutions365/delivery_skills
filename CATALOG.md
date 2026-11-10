# Delivery skill catalogue

[Home](README.md) · [Install](guides/adding-a-marketplace.md) ·
[Help](guides/troubleshooting.md)

Choose a task below. Each section names the **plugin to install**, what you need,
and a request to try. Use normal language, or type `/` to select a tool explicitly.

## Browse by task

- [Review risks and governance](#review-risks-and-governance)
- [Prepare an engagement report](#prepare-an-engagement-report)
- [Build and maintain an engagement knowledge base](#build-and-maintain-an-engagement-knowledge-base)
- [Set up a project from the delivery KB template](#set-up-a-project-from-the-delivery-kb-template)
- [Work with an Open Knowledge Format vault](#work-with-an-open-knowledge-format-vault)
- [Personalise your project agent](#personalise-your-project-agent)
- [Try a simple example](#try-a-simple-example)

## Where can I use these?

[Install once](guides/adding-a-marketplace.md) and the plugins are available in
Cowork and Claude Code. Share the relevant folder with Cowork, or open it as
the project in Code. Each workflow also needs the files,
local tools, and access listed below.

**Compatibility status:** these entries describe the source workflows.
End-to-end results for Cowork and Code have not yet been recorded here; these
are not verified compatibility claims. For workflows that manage Git, local
configuration, or hooks, start with Code.

## Review risks and governance

**Install:** `governance-tools` · [Source](plugins/governance-tools/)

| Tool | What you get | Example request |
| --- | --- | --- |
| [SOW risk analysis](plugins/governance-tools/skills/sow-risk-analyzer/SKILL.md) (`sow-risk-analyzer`) | A supplier-side summary, interactive risk radar, and prioritised recommendations with suggested redlines | “Use sow-risk-analyzer to review this SOW from our perspective as the supplier.” |
| [Delivery risk scanner](plugins/governance-tools/skills/delivery-risk-scanner/SKILL.md) (`delivery-risk-scanner`) | An HTML assessment of 21 delivery risk factors, with a risk matrix and prioritised risks | “Use delivery-risk-scanner to assess this engagement using these mobilisation notes.” |
| [ISO compliance check](plugins/governance-tools/skills/iso-compliance-check/SKILL.md) (`iso-compliance-check`) | A RAG assessment against seven CreateFuture delivery ISO requirements, with gaps and remediation steps | “Use iso-compliance-check to review this project's knowledge base.” |

**Bring:** the SOW and annexes for contract analysis; engagement context and your
scoring judgement for the scanner; access to the project KB for the ISO check.
The ISO tool checks evidence in the KB; it does not establish formal certification.

## Prepare an engagement report

**Install:** `engagement-reporting` · [Source](plugins/engagement-reporting/skills/engagement-report/SKILL.md)

**Tool:** `engagement-report`

Turn engagement updates into a weekly or fortnightly check-in report and a
CreateFuture-branded HTML presentation. The skill can interview you when there
are no written notes, revise a draft, or set up the account's reporting repo.

**Bring:** the reporting folder, engagement and reporting period, and any notes
or draft report. Repository setup also needs Git/GitHub access; use Code for that.

Try one of these requests:

- “Use engagement-report to draft this fortnight's check-in from these notes.”
- “Use engagement-report to interview me for this week's update.”
- “Use engagement-report to turn this draft into the check-in presentation.”

Practise with a copy of the [fictional example](plugins/engagement-reporting/skills/engagement-report/examples/).
The [workflow guide](plugins/engagement-reporting/skills/engagement-report/WORKFLOW.md)
explains the reporting stages.

## Build and maintain an engagement knowledge base

**Install:** `kb-creation` · [Source](plugins/kb-creation/)

This bundle covers an engagement KB's lifecycle. A **vault** is the folder of
project notes, registers, references, and setup files.

**Bring:** an empty destination for a new KB, then engagement facts and the team
roster. Later skills expect the files created during earlier setup stages. Use
Code for the setup chain, which includes local files, Git, and hooks.

### Start a new engagement

Run these in order. Role setup and reference setup both follow configuration;
complete them before hardening and the launch check.

| Step | Skill | What it does | Example request |
| --- | --- | --- | --- |
| 1 | [new-kb](plugins/kb-creation/skills/new-kb/SKILL.md) | Copies the bundled starter into an empty folder | “Use new-kb to create a KB in this empty folder.” |
| 2 | [configure-engagement](plugins/kb-creation/skills/configure-engagement/SKILL.md) | Fills in engagement settings and entry documents | “Use configure-engagement to configure this new engagement.” |
| 3 | [define-roles](plugins/kb-creation/skills/define-roles/SKILL.md) | Writes role profiles from the roster | “Use define-roles to prepare the team's role profiles.” |
| 4 | [seed-references](plugins/kb-creation/skills/seed-references/SKILL.md) | Creates the schema, glossary, registers, and references | “Use seed-references to initialise the registers.” |
| 5 | [harden-vault](plugins/kb-creation/skills/harden-vault/SKILL.md) | Sets up sharing checks, ignore rules, and agent instructions | “Use harden-vault to set up sharing checks.” |
| 6 | [launch-checklist](plugins/kb-creation/skills/launch-checklist/SKILL.md) | Checks readiness before inviting the team | “Use launch-checklist to check whether this KB is ready.” |

The starter's user guide still needs an engagement-specific review of its
examples. `new-kb` leaves the frontmatter schema for `seed-references` to create.
Scaffolding alone does not finish setup.

### Use the KB with your team

| Skill | What it does | Example request |
| --- | --- | --- |
| [onboard](plugins/kb-creation/skills/onboard/SKILL.md) | Sets up a member's local workspace and briefs them on their role | “Use onboard to set me up in this engagement's KB.” |
| [capture](plugins/kb-creation/skills/capture/SKILL.md) | Files material, synthesises findings, and updates registers under the vault's consent and ownership rules | “Use capture to add these meeting notes to this engagement's KB.” |
| [close-out-engagement](plugins/kb-creation/skills/close-out-engagement/SKILL.md) | Summarises value and lessons and marks the vault archived | “Use close-out-engagement to prepare this completed engagement for archiving.” |

**Bring:** the configured engagement vault. `onboard` uses local Git, hooks, and
Obsidian sync, so start it in Code. For capture, be ready to identify the audience
and approved use of the supplied material.

## Set up a project from the delivery KB template

**Install:** `delivery-tooling` · [Source](plugins/delivery-tooling/commands/new-project-kb.md)

**Command:** `/delivery-tooling:new-project-kb`

Copies `exampleProject` from the separate delivery KB template repository into a
client/project folder, then offers to create or update a private
`deliveryKB-<client>` repo in the xSolutions365 GitHub organization.

**Bring:** client and project names, a destination, Git with your name and email
configured, authenticated GitHub CLI (`gh`), and membership of the xSolutions365
GitHub organization. The [delivery KB template](https://github.com/xSolutions365/delivery-kb-template)
is private, and the new repo is created in that organization.
The command checks for `gh` before copying, even if you later choose not to
publish. Use Code for this workflow.

**Try:** “Use the delivery-tooling new-project-kb command to set up a project
from the delivery KB template.”

### Which knowledge-base tool should I use?

| Need | Choose |
| --- | --- |
| Create a vault and follow its configuration, onboarding, capture, and close-out process | `kb-creation`, starting with `new-kb` |
| Specifically use `exampleProject` from the separate delivery KB template repo | `delivery-tooling:new-project-kb` |
| Maintain a developer's notes in an existing Open Knowledge Format vault | `okf-commands` |

The scaffolding workflows use different templates. Check your engagement's
structure before mixing their follow-on tools.

## Work with an Open Knowledge Format vault

**Install:** `okf-commands` · [Source](plugins/okf-commands/commands/)

These commands were written for a developer's personal notes vault (notes with
code examples), not for an engagement knowledge base.

**Bring:** an existing Open Knowledge Format (OKF) vault with its schema and
instructions in `CLAUDE.md`. These tools use Obsidian-style links and indexes;
they do not create a new engagement vault.

| Command | What you get | Example invocation |
| --- | --- | --- |
| [new-note](plugins/okf-commands/commands/new-note.md) | A note with frontmatter and index/log updates | `/okf-commands:new-note "01 - Programming/CSharp" "Pattern Matching"` |
| [summarise-section](plugins/okf-commands/commands/summarise-section.md) | A refreshed folder index | `/okf-commands:summarise-section "01 - Programming/CSharp"` |
| [lint-vault](plugins/okf-commands/commands/lint-vault.md) | A health report on links, frontmatter, indexes, and gaps | `/okf-commands:lint-vault` |
| [ask](plugins/okf-commands/commands/ask.md) | An answer grounded in the vault, with citations | `/okf-commands:ask How do we handle pattern matching in C#?` |
| [validate-links](plugins/okf-commands/commands/validate-links.md) | A report of broken wiki links | `/okf-commands:validate-links` |

Replace the example folders with yours. This plugin was previously named
`OKF-commands`; see [the rename note](guides/troubleshooting.md#okf-commands-was-renamed)
if you installed it under that name.

## Personalise your project agent

**Install:** `agent-setup` · [Source](plugins/agent-setup/skills/customise-agent/SKILL.md)

**Tool:** `customise-agent`

An interactive walkthrough to update a project's `CLAUDE.md` with your role,
project context, and communication preferences.

**Bring:** a project open in Code. If it has no `CLAUDE.md`, or the file lacks
the sections this skill fills, the skill offers to add them from its
[bundled template](plugins/agent-setup/skills/customise-agent/assets/CLAUDE.template.md).
This changes a project file, not your Claude account preferences.

**Try:** “Use customise-agent to update this project's instructions for my role.”

## Try a simple example

**Install:** `example-skills` · [Source](plugins/example-skills/skills/tell-a-joke/SKILL.md)

**Tool:** `tell-a-joke`

**Bring:** nothing. This practice skill returns a short, clean joke and helps you
check that you can find and invoke an installed skill.

**Try:** “Use tell-a-joke to tell me a short joke.”

## Something missing or unclear?

[Report a problem or suggest a skill](https://github.com/xSolutions365/delivery_skills/issues).
For setup help, use [Troubleshooting](guides/troubleshooting.md) or **#ITSD** on
Slack. To change a tool or catalogue entry, see [Contributing](CONTRIBUTING.md).
