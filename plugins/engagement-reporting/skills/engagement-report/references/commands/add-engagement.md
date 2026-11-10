# `add-engagement`

Adds a new engagement folder to an existing account reports repo. An account
often runs more than one engagement at a time (e.g. two different teams on the
same client account); each gets its own folder inside the same repo.

## Input

- An existing account reports repo (path).
- The new engagement's name.

## Steps

1. Derive the engagement folder name: lowercase, hyphenated version of the
   engagement name, e.g. "Permits" → `permits`. This folder name is what
   `draft-report` and `present-report` will later read as the engagement
   identifier for filenames: every file in a period folder is prefixed
   `{engagement-folder-name}-{period-folder-name}-`.
2. If a folder with this name already exists in the repo root, stop and ask the
   user rather than overwriting it.
3. Create the empty engagement folder at the repo root. Do not create any period
   folders inside it — that's `draft-report`'s job, run next, once the team is
   ready to start their first period.

## Error handling

- Target account repo path doesn't look like one (no `README.md` at its root,
  or not a git repo) → ask for confirmation before proceeding.
- Engagement folder name already exists → stop and ask, never overwrite.
