# CreateFuture Delivery Skills

Reusable tools for delivery managers and engineers: review a Statement of Work,
assess delivery risks, prepare a stakeholder report, or build a project knowledge
base.

**Choose a task, install its plugin, and try the example request.** A plugin is
a bundle of related skills; you can install just the bundles you need.

## Start here

| I want to… | Go to |
| --- | --- |
| Find a tool for my work | [Browse the skill catalogue](CATALOG.md) |
| Use these tools in Cowork | [Set up Cowork](guides/cowork.md) |
| Use these tools in Claude Code | [Set up Claude Code](guides/claude-code.md) |
| Understand skills, plugins, and marketplaces | [Read the quick introduction](guides/adding-a-marketplace.md) |
| Fix an installation or update problem | [Get help](guides/troubleshooting.md) |
| Add or improve a skill | [Contribute](CONTRIBUTING.md) |

## Find a useful starting point

| Your task | What to use | Plugin to install |
| --- | --- | --- |
| Review a Statement of Work | [SOW risk analysis](CATALOG.md#review-risks-and-governance) | `governance-tools` |
| Assess an engagement's delivery risks | [Delivery risk scanner](CATALOG.md#review-risks-and-governance) | `governance-tools` |
| Check a project KB against delivery ISO requirements | [ISO compliance check](CATALOG.md#review-risks-and-governance) | `governance-tools` |
| Prepare a weekly or fortnightly client check-in | [Engagement reporting](CATALOG.md#prepare-an-engagement-report) | `engagement-reporting` |
| Start or maintain an engagement knowledge base | [Knowledge-base lifecycle](CATALOG.md#build-and-maintain-an-engagement-knowledge-base) | `kb-creation` |
| Work with an existing Open Knowledge Format vault | [Vault tools](CATALOG.md#work-with-an-open-knowledge-format-vault) | `OKF-commands` |
| Personalise a project's `CLAUDE.md` instructions | [Agent setup](CATALOG.md#personalise-your-project-agent) | `agent-setup` |

Not sure which knowledge-base tool to choose? See
[the catalogue comparison](CATALOG.md#which-knowledge-base-tool-should-i-use).

## Install one plugin

**Cowork:** use the [Cowork guide](guides/cowork.md) to add the marketplace and
choose a plugin through Claude's menus.

**Claude Code:** enter these commands one at a time in a Code session to try the
governance tools:

```text
/plugin marketplace add xSolutions365/delivery_skills
/plugin install governance-tools@createfuture-delivery-marketplace
```

Choose the option to install for yourself when prompted. Then type `/` and select
the skill you want, or ask for it by name. See the
[Code guide](guides/claude-code.md) for setup and updates.

You do not need to clone this repository or download individual files to install
a plugin. Some workflows have additional requirements listed in the catalogue.

## Where things live

| Location | Contents |
| --- | --- |
| [Catalogue](CATALOG.md) | Each tool's purpose, requirements, source, and example request |
| [Guides](guides/adding-a-marketplace.md) | Setup, updates, and troubleshooting |
| [Contributing](CONTRIBUTING.md) | How to propose changes and maintain the catalogue |
| [Marketplace manifest](.claude-plugin/marketplace.json) | The installable plugin list |

Plugin source folders: [governance-tools](governance-tools/),
[engagement-reporting](engagement-reporting/), [kb-creation](kb-creation/),
[delivery-tooling](delivery-tooling/), [OKF-commands](OKF-commands/),
[agent-setup](agent-setup/), and [example-skills](example-skills/).

## Help and feedback

Ask in **#ITSD** on Slack if setup is blocking you, or
[open an issue](https://github.com/xSolutions365/delivery_skills/issues).
Include the tool name, which app you used, and what you expected to happen.

Created by Richard Davidson, CreateFuture.
