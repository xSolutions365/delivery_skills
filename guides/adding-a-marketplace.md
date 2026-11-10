# Getting started with delivery skills

[Home](../README.md) · [Catalogue](../CATALOG.md) · [Help](troubleshooting.md)

Install a bundle once, then ask Claude to use a tool from it when you need it.
You do not need to understand the source files to get started.

## Three useful terms

| Term | Meaning | Example |
| --- | --- | --- |
| **Skill** | Instructions for a particular task | `sow-risk-analyzer` reviews a Statement of Work |
| **Plugin** | An installable bundle of related tools | `governance-tools` contains SOW analysis, risk scanning, and ISO checks |
| **Marketplace** | The list of plugins to choose from | `createfuture-delivery-marketplace` is this repository's marketplace |

Some tools are stored as **commands**, run explicitly through the `/` menu.
Skills can also be selected in that menu, or Claude can recognise when one
matches your request. Naming the skill makes your intention clear.

## Choose your app

- **[I use Cowork](cowork.md):** add the marketplace and plugin through Claude's
  menus, then share the files the task needs.
- **[I use Claude Code](claude-code.md):** check for an account-synced plugin or
  add the marketplace directly in a Code session.

Use both? Start with Cowork and read [how account sync works](claude-code.md#already-added-it-in-cowork).

## Choose one task

Browse the [catalogue](../CATALOG.md), note the containing plugin, install it, and
try the example request. Add other plugins later. For a practice run without
project files, try [the joke example](../CATALOG.md#try-a-simple-example).

## What do I need to download?

Normal installation fetches the plugin for you; no manual GitHub download or
clone is needed. This repository is public, so direct installation from its
public Git source does not require GitHub organization membership. Individual
workflows may need access to another repository or service.

## Keeping it working

Follow the update steps for your app. A change on GitHub does not immediately
replace the version in every running session. If something looks different in
your app, see [Help](troubleshooting.md) or ask in **#ITSD** on Slack.
