---
type: reference
owner: "[DM name]"
area: engagement
classification: internal
status: active
date: "[YYYY-MM-DD]"
updated: "[YYYY-MM-DD]"
tags: [setup]
---

# Setup sheet

About 20 minutes, seven steps, in this order. **Every step ends with how to
tell it worked.** If a step does not do what it says, stop there and post a
screenshot in the project Slack channel — do not skip ahead.

A richer version of this with screenshots, every sync symbol explained and a
troubleshooting tree is at [`user-guide.html`](user-guide.html). This sheet
is the short path.

## Why the order matters

Step 4 installs a check that reads what you are about to share and stops
anything that should not go out. Step 5 turns on automatic syncing. **The
check goes in first, on purpose** — so nothing can sync before something is
watching it.

---

## 1. Accept the GitHub invite

[DM name] invites you to `[org]/[repo-name]`. Accept from the email or the
notifications bell on github.com. You may need your organisation's single
sign-on and two-factor.

**Worked when:** you can open the repository page and see folders, not a 404.

## 2. Clone it with GitHub Desktop

Install [GitHub Desktop](https://desktop.github.com), sign in, then
*File → Clone repository →* `[org]/[repo-name]`.

Put it somewhere easy to find — your Documents or a `GitHub` folder inside
it. **Avoid iCloud Drive, Dropbox and OneDrive:** two sync systems fighting
over one folder causes exactly the confusion this setup avoids.

**Worked when:** you can open that folder in Finder and see `START-HERE.md`.

## 3. Open the folder as an Obsidian vault

Install [Obsidian](https://obsidian.md) if you need it. Choose **Open folder
as vault** and pick the folder you cloned. It will ask whether you trust the
author and want community plugins — **say yes.** A private repository, and
the plugin it means is the one that does your syncing.

**Worked when:** the file list on the left shows the vault's folders, and
`START-HERE.md` opens as readable text.

## 4. Install the safety check

Open Terminal, then paste this — adjusting the path if you cloned elsewhere:

```bash
cd [local clone path]
bash SETUP/hooks/install-guard.sh
```

**Worked when:** it prints a line confirming the check is installed, with no
red error text.

## 5. Turn on automatic syncing *(optional — see note)*

In Obsidian: *Settings → Community plugins* → make sure **Obsidian Git** is
on. Its settings ship with the vault, so you should not need to change
anything. What it does: pulls when Obsidian opens and every 5 minutes, sends
your changes about 2 minutes after you stop typing, and stays quiet unless
something is wrong.

Two commands worth knowing, both from the palette (**Cmd+P**): **Sync now**,
and **Commit-and-sync and close** for when you are shutting the laptop.

> **Prefer not to use Obsidian at all?** That is fine, and you can skip this
> step. Claude Code syncs the vault on its own: it pulls when a session
> starts and commits-and-pushes when it finishes. You would lose the
> continuous background syncing while you work, and Obsidian's reading
> experience (backlinks, graph, quick search) — but nothing breaks and
> nothing is lost. Read the vault in any editor, or on GitHub in a browser.

## 6. Open the same folder in Claude Code

Open the Claude Code desktop app and point it at the **same folder.** Two
apps, one folder — that is what makes the rest work.

**Worked when:** typing "capture this" gets a sensible response rather than
a blank look.

## 7. Onboard yourself

Say **"onboard me"** in Claude Code. Two or three minutes: it creates your
private folder, checks step 4 took, sets up your sync test, and finishes by
telling you what is happening on your part of the engagement.

**Worked when:** `SETUP/sync-tests/<your-name>.md` exists, and after a
minute or two you can see that file on GitHub in your browser. That round
trip proves your syncing works both ways.

---

## From here

Three things and nothing else:

1. Keep Obsidian open beside Claude Code
2. Start from `START-HERE.md`
3. Say **"capture this"** when you have anything, and just ask questions in
   plain English

**If anything looks weird, don't fix it — post a screenshot in the Slack
channel.**

## Optional: the terminal inside Obsidian

Some people prefer a terminal in the same window. It opens Claude Code on
the same folder and changes nothing else. Entirely optional — the standard
route above is fully supported and this is not a second workflow.
