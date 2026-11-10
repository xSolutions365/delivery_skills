# Help with delivery skills

[Home](../README.md) · [Catalogue](../CATALOG.md) ·
[Install](adding-a-marketplace.md)

## I cannot find the marketplace or plugin

Follow the [install steps](adding-a-marketplace.md#install). The marketplace is
listed as `delivery_skills`, and its plugins are under **Discover**. Adding the
marketplace only makes the list available; you still select **Add** on a plugin.
If Claude refuses the repository, your organisation restricts sources; ask in
**#ITSD**.

## The skill does not appear or Claude does not use it

Start a new task/session and check that the containing plugin is installed and
enabled. Type `/` and find the plugin prefix, or name the skill in your request.
Provide the files/folder listed in the [catalogue](../CATALOG.md).

## I see the same skill twice

You probably have an older copy from another route: a personal skill folder
(`~/.claude/skills/`), a skill uploaded under **Customize → Skills**, or the
same plugin both synced from your account and installed directly in Code. Keep
the marketplace plugin, whose entries carry the plugin prefix (for example
`governance-tools:sow-risk-analyzer`), and remove or turn off the others so you
are not running an out-of-date copy.

## The plugin does not appear in Claude Code

Plugins added in Customize reach Claude Code only when all of these are true:

- You are signed in to Claude Code with your Claude account, not an API key or
  a cloud provider.
- Claude Code is version 2.1.273 or later (`claude --version`).
- You started a new session, or ran `/reload-plugins`, after adding the plugin.

If one of those cannot be met, install directly instead. Enter these one at a
time in a Claude Code session, replacing `governance-tools` with the plugin you
want, and choose **Install for you** when asked:

```text
/plugin marketplace add xSolutions365/delivery_skills
/plugin install governance-tools@createfuture-delivery-marketplace
```

A direct install stays on that machine and does not appear in Cowork. To keep
it current, open `/plugin`, go to **Marketplaces**, select
`createfuture-delivery-marketplace` and choose **Enable auto-update**. To update
one plugin now, run this in your terminal:

```bash
claude plugin update governance-tools@createfuture-delivery-marketplace
```

## It works in Claude Code but not in Cowork

You installed it directly in Claude Code, which stays on that machine. Follow
the [install steps](adding-a-marketplace.md#install) to add it to your account.

## An update has not appeared

Follow [keep up to date](adding-a-marketplace.md#keep-up-to-date), then start a
new task. For a direct Claude Code install, use the update command above. If
the change is still missing, ask the maintainer whether it has been merged.

## GitHub access or a local program is missing

This repo is public, but workflows may use other repos/services. For example,
`new-project-kb` needs Git, authenticated GitHub CLI, and access to the delivery
KB template. Check the catalogue requirements; ask **#ITSD** if setup blocks you.

## okf-commands was renamed

This plugin was called `OKF-commands`. Claude's account sync requires lowercase
plugin names, so it is now `okf-commands` and its commands are
`/okf-commands:<command>`. The marketplace records the rename, so Claude Code
moves an existing installation to the new name. If Code then reports the plugin
as not cached, run this once:

```text
/plugin install okf-commands@createfuture-delivery-marketplace
```

## Organisation marketplace setup

Adding your own marketplace and setting up an organisation's GitHub-synced
marketplace are different routes. The organisation-sync route currently requires
a private/internal repo on github.com; this repo is public. An Owner should
choose the appropriate route rather than assuming organisation sync is set up.
See [Anthropic's organisation guide](https://support.claude.com/en/articles/13837433-manage-plugins-for-your-organization).

## Ask for help or report a problem

Ask in **#ITSD** on Slack or [open an issue](https://github.com/xSolutions365/delivery_skills/issues).
Include the tool name, Cowork or Code, app version if known, failing step, error
message, and expected result. Use a fictional/redacted example in this public
repository.
