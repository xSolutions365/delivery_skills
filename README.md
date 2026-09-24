# CreateFuture Delivery Plugin Marketplace

A Claude Code plugin marketplace for CreateFuture delivery managers and engineers. Install it once and get access to delivery workflow skills across all your projects.

## Quick Install

### Prerequisites

1. **Claude Code** installed — [claude.ai/code](https://claude.ai/code)
2. **GitHub CLI** installed and authenticated (see [Authentication](#authenticating-with-github) below)
3. Access to the `xSolutions365/delivery_skills` repo — if you don't have access, reach out to **#ITSD** on Slack

> **New to marketplaces and plugins, or not technical?** See [`guides/adding-a-marketplace.md`](guides/adding-a-marketplace.md) for a plain-English walkthrough using the Claude Code desktop app.

### Add the Marketplace

Open Claude Code in any project and type:

```
/plugin marketplace add xSolutions365/delivery_skills
```

### Install Plugins

```
/plugin install delivery-tooling@createfuture-delivery-marketplace
/plugin install governance-tools@createfuture-delivery-marketplace
/plugin install agent-setup@createfuture-delivery-marketplace
/plugin install OKF-commands@createfuture-delivery-marketplace
/plugin install kb-creation@createfuture-delivery-marketplace
/plugin install engagement-reporting@createfuture-delivery-marketplace
/plugin install example-skills@createfuture-delivery-marketplace
```

Your commands and skills are now available in every Claude Code session. Type `/` to see them.

## Available Plugins

### delivery-tooling

Delivery workflow and project setup tools.

| Command | What It Does |
| ------- | ------------ |
| `/new-project-kb` | Set up a new client project knowledge base — copies the KB template, creates the local folder structure, and creates or updates a GitHub repo under `xSolutions365` |

### governance-tools

Governance and compliance tools.

| Skill | What It Does |
| ----- | ------------ |
| `iso-compliance-check` | Audit a delivery KB against the seven CreateFuture ISO requirements — produces a RAG status report per requirement, cross-reference checks, and prioritised remediation steps |
| `delivery-risk-scanner` | Build a self-contained "Agentic Delivery Risk Scanner" HTML page — scores an engagement against 21 standard delivery risk factors, plots them on an impact/probability matrix, and produces an exec summary, quadrant playbook, ranked register and risk glossary |
| `sow-risk-analyzer` | Analyse SOWs from the supplier's perspective — produces a summary card, an interactive 5×5 risk radar, and a prioritised risk and redline recommendations table |

### agent-setup

Agent personalisation.

| Skill | What It Does |
| ----- | ------------ |
| `customise-agent` | Interactive wizard to personalise your Claude Code agent for delivery work |

### OKF-commands

Open Knowledge Format vault management commands for running an Obsidian vault as an LLM-friendly knowledge base.

| Command | What It Does |
| ------- | ------------ |
| `/new-note [folder] [title]` | Create a new OKF-stamped note with frontmatter, `## Related` links, and updates `index.md` + `log.md` |
| `/summarise-section [folder]` | Regenerate a folder's `index.md` Map of Content, grouped by note type |
| `/lint-vault` | Full vault health check — broken links, orphans, missing frontmatter, index drift, and knowledge gaps |
| `/ask [question]` | Answer a question from the vault with citations; optionally file the answer back as a new note |
| `/validate-links` | Fast scan for broken `[[wiki links]]` only |

### kb-creation

Engagement knowledge-base vault lifecycle — scaffold, configure, onboard, capture into, harden, and close out a shared team vault.

| Skill | What It Does |
| ----- | ------------ |
| `new-kb` | Scaffold a brand-new engagement vault from this skill's own bundled reference copy |
| `configure-engagement` | Turn a freshly scaffolded, generic knowledge base into one specific engagement |
| `define-roles` | Fill in the role profiles for a newly configured engagement |
| `seed-references` | Create the registry and reference files that `capture` and `onboard` assume already exist |
| `harden-vault` | Install and tailor the vault's safety net (pre-commit guard, blocked-terms list, `CLAUDE.md`/`AGENTS.md`) for this engagement |
| `onboard` | First run for a new person on the project's vault |
| `capture` | The one verb for putting anything into the vault — files it, synthesises findings, logs risks/actions/decisions/lessons |
| `launch-checklist` | Walk the preflight checklist before inviting the team into a new vault |
| `close-out-engagement` | Wind down a vault at the end of an engagement |

### engagement-reporting

Client engagement checkin reporting.

| Skill | What It Does |
| ----- | ------------ |
| `engagement-report` | Scaffold, draft, revise, and present weekly/fortnightly client engagement checkin reports, and manage the account-level repo that holds them across engagements |

### example-skills

Example skills for learning how Claude Code skills work.

| Skill | What It Does |
| ----- | ------------ |
| `tell-a-joke` | Tells a short, light-hearted joke |

## Authenticating with GitHub

This is a private repo, so you need to authenticate with the GitHub CLI before Claude Code can access it.

### Step 1: Install GitHub CLI

```bash
brew install gh
```

### Step 2: Log in

```bash
gh auth login
```

Choose these options when prompted:

| Prompt | Choose |
| ------ | ------ |
| Where do you use GitHub? | **GitHub.com** |
| Preferred protocol? | **HTTPS** |
| Authenticate Git with GitHub credentials? | **Yes** |
| How to authenticate? | **Login with a web browser** |

### Step 3: Verify

```bash
gh auth status
```

You should see: `Logged in to github.com account YourName`

### Step 4: Enable auto-updates (optional)

Add this to your `~/.zshrc` so plugins update automatically at startup:

```bash
export GITHUB_TOKEN=$(gh auth token)
```

Then restart your terminal. If you skip this, you can update manually with `/plugin marketplace update`.

## Updating

```
/plugin marketplace update
```

## Contributing

New skills are always welcome! If you've built something useful with Claude Code, consider sharing it here so others can benefit.

### How to Add a Command or Skill

Plugins can contain **commands** (user-invoked with `/`) or **skills** (AI-invoked based on context). Commands are the preferred approach for most use cases.

1. **Fork and clone** the repo, then create a feature branch.
2. **Decide which plugin** your asset belongs to, or create a new plugin directory at `<plugin-name>/` if it doesn't fit an existing one.
3. **For a command**, create `<plugin-name>/commands/<your-command-name>.md` with YAML frontmatter:
   ```markdown
   ---
   description: One sentence shown in the command picker
   argument-hint: "[optional-arg]"   # shown as usage hint
   ---
   
   Your command instructions here...
   ```
4. **For a skill**, create `<plugin-name>/skills/<your-skill-name>/SKILL.md` with YAML frontmatter:
   ```markdown
   ---
   name: your-skill-name
   description: Trigger phrases that cause this skill to activate automatically
   ---
   
   Your skill instructions here...
   ```
5. **If creating a new plugin**, add a `<plugin-name>/.claude-plugin/plugin.json` manifest and register it in `.claude-plugin/marketplace.json`.
6. **Use the official `skill-creator` skill** (from the `claude-plugins-official` marketplace) if you want a guided walkthrough.
7. **Open a pull request** with a short description of what the command/skill does and when it's useful.

### Tips

- Commands are discovered automatically from the `commands/` folder — no need to declare them in `plugin.json`.
- Put detailed reference material in a `references/` subfolder alongside your skill.
- Test locally before submitting by installing the plugin from your branch in a Claude Code session.

## Credits

Created by Richard Davidson, CreateFuture.
