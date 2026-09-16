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

## Step-by-step: adding the CreateFuture marketplace

These steps use the **Claude Code desktop app** (the Mac/Windows app — not the general claude.ai chat app).

1. **Open the Claude Code desktop app.**
2. **Open or create a project.** Claude Code works within a project folder, so open the folder you're working in (or create a new one) from the app's start screen.
3. **Find the chat/prompt box** at the bottom of the window — this is where you type messages to Claude.
4. **Type the following and press Enter:**
   ```
   /plugin marketplace add xSolutions365/delivery_skills
   ```
   This tells Claude Code where to find the CreateFuture marketplace. You only need to do this once — after that, the marketplace is available in every project you open.
5. **Install the plugins you want.** Type each of these on its own line and press Enter after each:
   ```
   /plugin install delivery-tooling@createfuture-delivery-marketplace
   /plugin install governance-tools@createfuture-delivery-marketplace
   /plugin install sow-tools@createfuture-delivery-marketplace
   /plugin install agent-setup@createfuture-delivery-marketplace
   /plugin install OKF-commands@createfuture-delivery-marketplace
   ```
   You don't have to install all of them — just the ones relevant to your work.
6. **Check it worked.** Type `/` on its own in the chat box. You should see a list appear that includes the new commands (like `/new-project-kb`) alongside Claude Code's built-in ones.

That's it — the tools are now available every time you use Claude Code.

## Before you start: access to the repo

The marketplace lives in a private GitHub repository (`xSolutions365/delivery_skills`), so the first time you add it, Claude Code may ask you to sign in with GitHub. If you don't have access to the repo, ask on **#ITSD** on Slack to get added.

## Keeping it up to date

The marketplace is updated from time to time with new tools. To pull in the latest version, type:
```
/plugin marketplace update
```

## Getting help

If any step doesn't work as described, ask in **#ITSD** on Slack, or ask Claude directly in the app — you can describe what you're seeing and it can help troubleshoot.
