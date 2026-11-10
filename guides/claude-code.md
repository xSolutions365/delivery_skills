# Use delivery skills in Claude Code

[Home](../README.md) · [Catalogue](../CATALOG.md) ·
[Cowork setup](cowork.md) · [Help](troubleshooting.md)

Use this guide in a terminal or a local Code session in the desktop app.

## Already added it in Cowork?

On Code v2.1.273 or later, account plugins can sync at startup when you sign in
with the same Claude account and syncing is enabled. Check `/plugin` first;
synced entries use an `@synced` identifier. API-key/cloud-provider sign-in does
not use this route. Direct Code installations do not sync back to Cowork.

## Add the marketplace directly

You need **Claude Code and Git** installed. This public repository does not
require GitHub CLI authentication for direct installation.

Enter these one at a time in a Claude Code session:

```text
/plugin marketplace add xSolutions365/delivery_skills
/plugin install governance-tools@createfuture-delivery-marketplace
```

Choose **Install for you** (user scope) when prompted. This makes the plugin
available in your projects on this machine. Project scope shares configuration
with collaborators; local scope applies only to you in this project.

For other bundles, replace `governance-tools` with the plugin named in the
[catalogue](../CATALOG.md). Browse the list through `/plugin`. The registered
marketplace is `createfuture-delivery-marketplace`, not `delivery_skills`.

### Prefer your normal terminal?

Outside the Claude conversation, run:

```bash
claude plugin marketplace add xSolutions365/delivery_skills
claude plugin install governance-tools@createfuture-delivery-marketplace --scope user
```

The terminal and desktop app's local Code sessions on this machine share user
settings, so you do not need to install again for each one.

## Check it worked

Open the project the task needs and start a new session. Type `/` and look for
the plugin's skill/command. Its prefix identifies the plugin, for example:

```text
/governance-tools:sow-risk-analyzer
```

You can also use the catalogue's example request. Extra dependencies such as
GitHub CLI apply only to the workflows that list them.

## Keep a direct installation up to date

Open `/plugin → Marketplaces`, select this marketplace, and choose **Enable
auto-update**. It is off by default for directly added third-party marketplaces.
Exporting a GitHub token does not enable this setting.

To update one installed plugin now, run in your terminal:

```bash
claude plugin update governance-tools@createfuture-delivery-marketplace
```

Replace the plugin name for another bundle. Start a new session or use
`/reload-plugins` to apply the update. Refreshing a marketplace listing alone is
not proof that the installed plugin version changed.

For account-synced plugins, use the account/organization route that supplied
them rather than adding a second direct copy just to update.

Installation, scopes, and sync: [Anthropic's installation guide](https://code.claude.com/docs/en/plugins/install).
Releases and updates: [marketplace maintenance](https://code.claude.com/docs/en/plugins/host-marketplace).
Guidance checked on 10 November 2026.
