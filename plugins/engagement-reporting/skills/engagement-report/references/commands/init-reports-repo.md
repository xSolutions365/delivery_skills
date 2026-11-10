# `init-reports-repo`

Scaffolds a new account-level reports repo — one per client account, holding
every engagement's reports for that account. This is the account's knowledge
base: reports are drafted and generated directly inside it, so "contributing to
the knowledge base" is just committing this repo.

## Input

An account name (e.g. "Contoso").

## Steps

1. Derive the repo folder name: lowercase, hyphenated account name +
   `-engagement-reports`, e.g. `contoso-engagement-reports`. If a folder with
   this name already exists, stop and ask the user rather than overwriting it.
2. Create the folder and run `git init` inside it.
3. Write a `README.md` into the repo root:
   ~~~markdown
   # {Account Name} Engagement Reports

   This repo holds every engagement report for the {Account Name} account —
   one folder per engagement, one subfolder per reporting period. See each
   engagement folder for its history.

   ## Access

   This repo should be shared with the CPG and extended CPG for this account —
   everyone with a reason to see the full reporting history, not just the
   latest period.

   ## Adding a new engagement

   Run the engagement-report-skill's `add-engagement` command with this repo
   and the new engagement's name.

   ## Structure

   ```
   {account-folder-name}/
   ├── README.md
   ├── {engagement-1}/
   │   ├── {period_start}_{period_end}/
   │   └── ...
   └── {engagement-2}/
       └── ...
   ```
   ~~~
   (Substitute the actual account name in place of `{Account Name}`.)
4. Commit the README with git, but **do not** create a remote or push anywhere
   — that stays a manual, explicitly-confirmed step for whoever owns the repo.

## Error handling

- Target folder already exists → stop and ask, never overwrite.
- No engagement created yet → that's expected; `init-reports-repo` only
  scaffolds the account-level shell. Run `add-engagement` next.
