# Install delivery skills

[Home](../README.md) · [Catalogue](../CATALOGUE.md) · [Help](troubleshooting.md)

One setup covers Cowork, chat and Claude Code. You do not need a GitHub account,
and there is nothing to download.

## Install

1. Open Claude (the desktop app or claude.ai) and select **Customize**, then
   the **Plugins** tab.
2. Select **Add → Add marketplace → Add from a repository** and paste:

   ```text
   https://github.com/xSolutions365/delivery_skills
   ```

3. Open **Discover**. The delivery plugins are marked "by delivery_skills".
   Names appear without hyphens, so `governance-tools` in the
   [catalogue](../CATALOGUE.md) shows as **Governance tools**.
4. Select **Add** next to the plugin you want. Add more at any time.

You only add the marketplace once. If Claude refuses the repository, your
organisation restricts sources; ask in **#ITSD** on Slack.

## Use a skill

Start a task in Cowork, give it the files or folder the task needs, and ask for
the tool by name:

> Use sow-risk-analyzer to review this SOW from our perspective as the supplier.

You can also type `/` and pick the skill from the list. The
[catalogue](../CATALOGUE.md) gives a request to try for every tool and lists what
each one needs. For a practice run with no files, add **Example skills** and ask
for a joke.

## Keep up to date

On the Plugins page, open **Manage marketplaces**. `delivery_skills` shows
**Synced** and the version it last picked up.

- To get the latest now, open its **…** menu and check for updates.
- If **Sync automatically** is offered, turn it on so new versions arrive
  without another step.

Updates apply to the next task you start, not one already running.

## Claude Code

Plugins you add in Customize also appear in Claude Code when you are signed in
with the same Claude account. Start a new session, type `/plugin`, and look for
the plugin with `@synced` after its name. Nothing else to install.

If it is not there, see
[the plugin does not appear in Claude Code](troubleshooting.md#the-plugin-does-not-appear-in-claude-code).

## Words you will see

| Term | Meaning |
| --- | --- |
| **Skill** | Instructions for one task, such as `sow-risk-analyzer` |
| **Plugin** | A bundle of related skills that you add in one go |
| **Marketplace** | The list of plugins; ours is `delivery_skills` |

The steps follow Anthropic's [plugin guide](https://support.claude.com/en/articles/13837440-use-plugins-in-claude)
and [plugin overview](https://claude.com/docs/plugins/overview), checked on
10 November 2026. Adding the marketplace and plugins was confirmed in the
CreateFuture app; the update controls and the Claude Code sync were not.
