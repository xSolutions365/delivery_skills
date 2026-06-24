# CreateFuture Delivery Plugin Marketplace

A Claude Code plugin marketplace for CreateFuture delivery managers and engineers. Install it once and get access to delivery workflow skills across all your projects.

## Quick Install

### Prerequisites

1. **Claude Code** installed — [claude.ai/code](https://claude.ai/code)
2. **GitHub CLI** installed and authenticated (see [Authentication](#authenticating-with-github) below)
3. Access to the `xSolutions365/delivery_skills` repo — if you don't have access, reach out to **#ITSD** on Slack

### Add the Marketplace

Open Claude Code in any project and type:

```
/plugin marketplace add xSolutions365/delivery_skills
```

### Install Plugins

```
/plugin install delivery-tooling@createfuture-delivery-marketplace
/plugin install governance-tools@createfuture-delivery-marketplace
/plugin install sow-tools@createfuture-delivery-marketplace
/plugin install agent-setup@createfuture-delivery-marketplace
```

Your skills are now available in every Claude Code session. Type `/` to see them.

## Available Plugins

### delivery-tooling

Delivery workflow and project setup tools.

| Skill | What It Does |
| ----- | ------------ |
| `new-project-kb` | Set up a new client project knowledge base — copies the KB template, creates the local folder structure, and creates or updates a GitHub repo under `xSolutions365` |

### governance-tools

Governance and compliance tools.

| Skill | What It Does |
| ----- | ------------ |
| `iso-compliance-check` | Audit a delivery KB against the seven CreateFuture ISO requirements — produces a RAG status report per requirement, cross-reference checks, and prioritised remediation steps |

### sow-tools

Statement of Work analysis tools.

| Skill | What It Does |
| ----- | ------------ |
| `sow-risk-analyzer` | Analyse SOWs from the supplier's perspective — produces a summary card, an interactive 5×5 risk radar, and a prioritised risk and redline recommendations table |

### agent-setup

Agent personalisation.

| Skill | What It Does |
| ----- | ------------ |
| `customise-agent` | Interactive wizard to personalise your Claude Code agent for delivery work |

## Auto-Enable for a Project

To make the marketplace plugins available to everyone on a project, copy the `starter-project/` contents into your project root. When team members open the project in Claude Code, they'll be prompted to install the marketplace automatically.

See `starter-project/README.md` for details.

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

### How to Add a New Skill

1. **Fork and clone** the repo, then create a feature branch.
2. **Decide which plugin** your skill belongs to (e.g. `delivery-tooling`), or propose a new plugin if it doesn't fit an existing one.
3. **Create a skill directory** at `plugins/<plugin-name>/skills/<your-skill-name>/` containing:
   - **`SKILL.md`** (required) — YAML frontmatter with `name` and `description`, followed by markdown instructions for how the skill works.
   - **`references/`** (optional) — Templates, guidelines, or documentation the skill loads into context.
   - **`scripts/`** (optional) — Executable code (Python, Bash, etc.) the skill runs.
   - **`assets/`** (optional) — Output templates or boilerplate.
4. **Use the official `skill-creator` skill** (from the `claude-plugins-official` marketplace) if you want a guided walkthrough.
5. **Open a pull request** with a short description of what the skill does and when it's useful.

### Tips

- Keep `SKILL.md` focused — put detailed reference material in the `references/` folder.
- Look at `new-project-kb` for a good example of structure and style.
- Test your skill locally before submitting by running it in a Claude Code session.

## Credits

Created by Richard Davidson, CreateFuture.
