# Contribute a delivery skill

[Home](README.md) · [Catalogue](CATALOGUE.md) · [Help](guides/troubleshooting.md)

[Open an issue](https://github.com/xSolutions365/delivery_skills/issues) with an
idea or feedback; you do not need to write a skill to contribute. For file
changes, create a branch (or fork) and open a small pull request.

## Choose where it belongs

Check the [catalogue](CATALOGUE.md) for overlap. Use an existing plugin when its
purpose fits: governance, reporting, engagement KBs, delivery-template setup,
OKF vaults, agent personalisation, or learning examples. New plugin names use
lowercase letters, numbers, and hyphens.

Still trying an idea out? Put it in [drafts](drafts/README.md) first. Drafts are
not installable, so nothing reaches anyone's Claude until it moves into a
plugin.

## Add a skill or command

A skill lives in `plugins/<plugin>/skills/<skill-name>/SKILL.md`:

```yaml
---
name: my-skill
description: Explain the task and the requests that should trigger it.
---
```

Below the frontmatter, describe the inputs, steps, output, and handling of
missing information. Put longer references/templates alongside it and use
fictional examples.

An explicit command can live in `plugins/<plugin>/commands/<command-name>.md`:

```yaml
---
description: Explain what the command produces.
argument-hint: "[optional input]"
---
```

Both kinds can be selected by users; skills can also match a request
automatically. Choose the form that suits the workflow.

A new plugin also needs `plugins/<plugin>/.claude-plugin/plugin.json` and an entry in
[the marketplace manifest](.claude-plugin/marketplace.json). Keep skills,
commands, and resources outside `.claude-plugin/`, which holds the manifest.

## Keep the catalogue useful

Update [CATALOGUE.md](CATALOGUE.md) in the same PR as a new or changed tool:

- Explain the task and expected output in plain language.
- Link the source and name the containing plugin.
- Give a request to try and list files, tools, access, and setup prerequisites.
- Record actual app/version checks in the PR; add compatibility claims only
  when supported by that evidence.

The catalogue is the detailed user-facing inventory. Keep README short and link
to catalogue sections rather than repeating the full inventory in other guides.
Update README navigation if plugin names or task categories change.

## Check and release

1. Run `claude plugin validate .` and `claude plugin validate ./plugins/<plugin>` for
   each changed plugin.
2. Exercise the workflow on a representative fictional example in the intended
   app. Describe the input and result in the PR.
3. Run `python3 scripts/check_repo.py`. It confirms that every skill and command
   is in the catalogue, the marketplace matches the plugin folders, and links
   resolve.
4. For changed plugin behaviour or bundled files, increase the version in its
   `plugin.json`. This repo also declares versions in marketplace entries, so
   keep the matching entry equal; the plugin manifest takes precedence.
   Root README/guide-only changes do not need a plugin version bump.
5. Open a PR explaining the problem, result, and validation. After merging a
   plugin release, verify the relevant marketplace sync or installed Code update.

A plugin's name is its install identifier. If one must change, add the old
name to `renames` in the marketplace manifest, as was done for
[`okf-commands`](guides/troubleshooting.md#okf-commands-was-renamed); do not
rename a plugin incidentally as part of another change.

A version bump signals a release; it does not enable users' automatic updates.
Follow [the update guidance](guides/adding-a-marketplace.md#keep-up-to-date)
or the organisation's publishing process.
