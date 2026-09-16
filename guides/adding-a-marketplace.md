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

Claude Code can be used from a terminal (the CLI) or from the **Claude Code desktop app** (Mac/Windows). The two look and feel similar, but they don't have identical menus. In particular, the desktop app doesn't have its own screen for typing in a brand-new marketplace's GitHub repo — it can only *browse and install* from marketplaces that have already been "configured" for your account or project. The steps below use the two supported ways to get the CreateFuture marketplace configured, both without needing to use a terminal.

## Step-by-step: adding the CreateFuture marketplace (desktop app)

### Option A — Recommended: use the pre-configured project file

CreateFuture ships a ready-made settings file that registers the marketplace automatically the first time you open a project with it — no typing required.

1. **Get the `starter-project` files.** Copy the contents of the `starter-project/` folder from the [`xSolutions365/delivery_skills`](https://github.com/xSolutions365/delivery_skills) repo into the root of your project folder. (If you're not sure how to do this, ask a colleague or **#ITSD** to do it once — after that it's just a folder you keep in the project.)
2. **Open that project folder in the Claude Code desktop app.**
3. **Trust the folder** when prompted. Claude Code reads the `.claude/settings.json` file that came with `starter-project/` and registers the CreateFuture marketplace for you automatically.
4. **Open the plugin panel.** Click the **+** button next to the chat/prompt box, then select **Plugins**.
5. **Check or install the plugins.** Select **Manage plugins** to see the CreateFuture plugins (`delivery-tooling`, `governance-tools`, `sow-tools`, `agent-setup`). If any show as available but not yet installed, select it and choose **Install**.
6. **Check it worked.** Type `/` on its own in the chat box. You should see the new commands (like `/new-project-kb`) alongside Claude Code's built-in ones.

### Option B — If the marketplace is already known to your machine

If a colleague has already added the CreateFuture marketplace on your machine before (for example, using the terminal), you can install plugins from it directly through the desktop app's GUI:

1. Click the **+** button next to the chat/prompt box.
2. Select **Plugins**, then **Add plugin**.
3. Find the CreateFuture plugin you want in the browser and select it.
4. Choose a scope — just for you, for everyone on this project, or just this project — and install.

### If neither option shows the marketplace

The very first time the CreateFuture marketplace is added to your account or machine, someone needs to register it — either by using Option A above, or by having anyone with terminal access run `/plugin marketplace add xSolutions365/delivery_skills` once. After that, it's "configured" and appears for anyone using the desktop app on that same machine/account, per Option B.

That's it — the tools are now available every time you use Claude Code.

## Before you start: access to the repo

The marketplace lives in a private GitHub repository (`xSolutions365/delivery_skills`), so the first time you add it, Claude Code may ask you to sign in with GitHub. If you don't have access to the repo, ask on **#ITSD** on Slack to get added.

## Keeping it up to date

Claude Code checks for marketplace and plugin updates in the background automatically, so you'll usually get new tools without doing anything. If you want to check manually, open the plugin panel (**+** → **Plugins** → **Manage plugins**) and look for an update prompt there.

## Getting help

If any step doesn't work as described, ask in **#ITSD** on Slack, or ask Claude directly in the app — you can describe what you're seeing and it can help troubleshoot.
