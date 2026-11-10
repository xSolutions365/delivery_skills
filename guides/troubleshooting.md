# Help with delivery skills

[Home](../README.md) · [Catalogue](../CATALOG.md) ·
[Cowork setup](cowork.md) · [Code setup](claude-code.md)

## I cannot find the marketplace or plugin

- **Cowork:** [add the marketplace](cowork.md#3-add-the-marketplace-if-it-is-missing).
  Your organization may restrict sources or plugins.
- **Code:** run `/plugin` and check Marketplaces and Installed. The marketplace
  name is `createfuture-delivery-marketplace`.
- Adding a marketplace makes its list available; you still install the plugin.

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

## It works in Code but does not appear in Cowork

A direct Code installation is local to Code. Follow [Cowork setup](cowork.md)
to add it there. Account sync goes from Claude to Code, not the other way around.

## An update has not appeared

For direct Code installations, check auto-update and follow
[the manual update steps](claude-code.md#keep-a-direct-installation-up-to-date).
For organization plugins, ask the maintainer whether the version was published
or successfully synced. Refresh the session before checking the result.

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

## Organization marketplace setup

Adding your own marketplace and setting up an organization's GitHub-synced
marketplace are different routes. The organization-sync route currently requires
a private/internal repo on github.com; this repo is public. An Owner should
choose the appropriate route rather than assuming organization sync is set up.
See [Anthropic's organization guide](https://support.claude.com/en/articles/13837433-manage-plugins-for-your-organization).

## Ask for help or report a problem

Ask in **#ITSD** on Slack or [open an issue](https://github.com/xSolutions365/delivery_skills/issues).
Include the tool name, Cowork or Code, app version if known, failing step, error
message, and expected result. Use a fictional/redacted example in this public
repository.
