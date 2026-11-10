# Use delivery skills in Cowork

[Home](../README.md) · [Catalogue](../CATALOG.md) ·
[Code setup](claude-code.md) · [Help](troubleshooting.md)

Use this route in the **Cowork** tab of Claude Desktop.

## 1. Choose a plugin

Find your task in the [catalogue](../CATALOG.md) and note its plugin name.

## 2. Find it in Claude

Open **Cowork → Customize → Plugins**. Check your installed list, then
**Discover**. If the plugin is offered by your organization, select it and click
**Add**. If already installed, continue to step 4.

## 3. Add the marketplace if it is missing

From **Customize → Plugins**, choose **Add → Add marketplace → Add from a
repository**. Enter:

```text
https://github.com/xSolutions365/delivery_skills
```

Open the resulting marketplace and add your chosen plugin. Turn on **Sync
automatically** for the marketplace if the option is shown, so improvements
reach you without another step. Organization policies may restrict sources; ask
an Owner or **#ITSD** if this source is blocked.

## 4. Try a skill

Start a task, give Cowork access to the relevant files/folder, and type `/` to
find the skill or use the catalogue's example request. For example, after adding
`governance-tools` and supplying a SOW:

> Use sow-risk-analyzer to review this SOW from our perspective as the supplier.

Check the catalogue requirements before starting tools that manage Git or hooks.
Installing a plugin does not verify its local dependencies.

## Updates and using Code too

For a marketplace you added yourself, **Sync automatically** delivers new
versions on their own. To pull the latest straight away, open the marketplace
and choose **Check for updates**. Changes appear in the next task you start.
Plugins supplied by the organization update through its own sync; ask **#ITSD**
if a published change is missing.

Account plugins can also sync into Code. Read [the Code guide](claude-code.md#already-added-it-in-cowork)
before installing a second copy directly.

Menu names were checked against [Anthropic's plugin guide](https://support.claude.com/en/articles/13837440-use-plugins-in-claude)
on 10 November 2026; the update controls are named in
[Anthropic's plugin overview](https://claude.com/docs/plugins/overview) and have
not been confirmed in the CreateFuture app. CreateFuture workflow execution in Cowork still needs
verification; see [compatibility status](../CATALOG.md#where-can-i-use-these).
