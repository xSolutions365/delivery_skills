# Adding a Marketplace in Claude Code (Desktop App)

A plain-English guide for anyone who isn't a developer but wants to get the CreateFuture delivery tools working in Claude Code.

## What is a marketplace?

A **marketplace** is a curated list of add-ons for Claude Code, a bit like an app store. CreateFuture runs its own marketplace containing tools built specifically for delivery managers and engineers — things like setting up a new project knowledge base, checking a Statement of Work for risk, or auditing a project against ISO requirements.

You "add" a marketplace once, and after that you can install whichever add-ons from it are useful to you.

## What is a plugin?

A **plugin** is one add-on from a marketplace — a bundle of ready-made tools for a specific area of work. For example, the `sow-tools` plugin bundles together everything needed to analyse Statements of Work. Each plugin can be installed separately, so you only add what you actually need.

## Skills vs. commands — what's the difference?

Once a plugin is installed, it gives you **commands** and/or **skills**:

- **Commands** are things *you* ask for directly, by typing `/` followed by the command name (e.g. `/new-project-kb`). You're in control of exactly when it runs.
- **Skills** work in the background. You don't type anything special to trigger them — Claude notices when a skill is relevant to what you're doing (based on your conversation) and uses it automatically to help.

In short: commands are things you do, skills are things Claude does for you when it makes sense.

## A note on the desktop app vs. the terminal

Claude Code can be used from a terminal (the CLI) or from the **Claude Code desktop app** (Mac/Windows). The CreateFuture marketplace lives in a **private** GitHub repository, and the desktop app can't add a brand-new private marketplace by itself — that first step has to be done from the terminal, once. After that, the marketplace is available to the desktop app from then on, and everything else is done through the app's normal menus.

## Step-by-step: adding the CreateFuture marketplace

### Step 1 — One-off setup: add the marketplace from the terminal

This only needs doing once per machine (or once per person, if you each use your own account).

1. Open a terminal (on Mac: the **Terminal** app; on Windows: **Command Prompt**, **PowerShell**, or **WSL**).
2. Type `claude` and press Enter to start Claude Code.
3. Run:
   ```
   /plugin marketplace add xSolutions365/delivery_skills
   ```
   You may be asked to sign in with GitHub the first time — see "Before you start" below.
4. Once it confirms the marketplace has been added, exit Claude Code (type `/exit` or press Ctrl+C).

If you're not comfortable using a terminal, ask a colleague or **#ITSD** to do this one-off step for you.

### Step 2 — Install plugins from the desktop app

Once the marketplace has been added, install plugins through the desktop app's GUI — no more terminal needed:

1. Open the **Claude Code desktop app**.
2. Click your username in the bottom-left corner.
3. Go to **Settings → Plugins → Discover**.
4. Open the **Filter** dropdown, choose **Source**, and select the CreateFuture marketplace. This narrows the list down to just the CreateFuture plugins (`delivery-tooling`, `governance-tools`, `sow-tools`, `agent-setup`, `OKF-commands`).
5. For each plugin you want, click **Add** and pick an install option (see below).
6. **Check it worked.** Open a project and type `/` on its own in the chat box — you should see the new commands (like `/new-project-kb`) alongside Claude Code's built-in ones.

### Choosing an install option

Clicking **Add** next to a plugin offers three choices:

| Option | What it does | When to choose it |
| ------ | ------------ | ------------------ |
| **Install for me** | Installs to your personal Claude config (`~/.claude/`) — available in *every* project you open, just for you. | **Recommended for most people.** CreateFuture's delivery tools are things you'll want available everywhere, and this doesn't change anything for teammates. |
| **Install for project (shared)** | Installs into the project's `.claude/` folder, which is checked into the repo and shared with the whole team. | Choose this if you want *everyone* working on a specific client project to get the same plugin automatically — e.g. standardising `governance-tools` across a delivery team. |
| **Install for project (personal)** | Installs into `.claude.local/`, scoped to this one project, just for you, and git-ignored so it's never shared. | Choose this to try a plugin out on a single project without it affecting every project you work on, or showing up for teammates. |

For most delivery managers and engineers, **"Install for me"** is the simplest and most useful choice.

## Before you start: access to the repo

The marketplace lives in a private GitHub repository (`xSolutions365/delivery_skills`), so the first time you add it, Claude Code may ask you to sign in with GitHub. If you don't have access to the repo, ask on **#ITSD** on Slack to get added.

## Keeping it up to date

Claude Code checks for marketplace and plugin updates in the background automatically, so you'll usually get new tools without doing anything. If you want to check manually, go to **Settings → Plugins** in the desktop app and look for an update prompt there.

## Getting help

If any step doesn't work as described, ask in **#ITSD** on Slack, or ask Claude directly in the app — you can describe what you're seeing and it can help troubleshoot.
