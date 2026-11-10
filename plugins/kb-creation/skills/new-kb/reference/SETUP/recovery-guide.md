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

# Recovery guide

**The one rule: if anything looks weird, don't fix it — post a screenshot in the
project Slack channel.**

Your work is safe on your laptop whatever the message says. Stopping costs
nothing. An attempted fix is genuinely harder to unpick than the original problem,
and nobody here is expected to debug Git alone.

## "Blocked" — a message naming one of my files

**This is the system working, not a fault.** It is the most common message you
will see.

The safety check found something it will not share and stopped before it went
anywhere. The message names the file, the reason, and the one thing to change.
Usually it is a note with no audience set — say **"capture this"** and let it file
the note properly. Fix it and the sync goes through on its own.

**Do not** look for a way to force it through. If the reason genuinely does not
apply, say so in Slack and the DM will adjust the rule — the rules are meant to be
adjustable, unlike a leak.

## "Conflict", or a file with strange `<<<<<<<` markers

You and someone else changed the same part of the same file at about the same
time.

1. **Stop editing that file.**
2. Screenshot the message and post it in Slack.
3. Wait. Both versions still exist and nothing is lost.

It takes a couple of minutes to sort out with someone who has done it before.
This should be rare — we work in separate files and append to the bottom of shared
lists precisely so it does not happen. **If it happens twice in the same file,
say so**: that is a signal to change how we are working, not just a nuisance.

## A warning triangle, or red sync error text

Usually your GitHub sign-in needs renewing, the network dropped, or single sign-on
wants reauthorising.

Screenshot the exact wording and post it. The exact wording is what makes this a
two-minute fix rather than twenty. **Meanwhile keep working normally** — your
changes queue up locally and go when the connection is back.

## Nothing is syncing and there is no indicator at all

Two checks, in this order:

1. *Settings → Community plugins* — is **Obsidian Git** actually on? This is the answer most of the time.
2. Did you use **Open folder as vault**? Opening it another way can leave the plugin unable to see the repository.

If both look right: screenshot and post. **Do not reinstall anything and do not
re-clone** — that is the route to a genuinely confusing situation.

## Something has vanished

If it was ever synced, it still exists in the vault's history. Deleting a file
removes it from view, not from the record.

Say what went missing and roughly when you last saw it. **Do not recreate it from
memory yet** — the original is probably two minutes away.

**The exception:** files in `users/<your-name>/` never sync, so they have no
history to recover from. That is the trade for privacy — never keep the only copy
of something that matters in there.

## Someone's version replaced mine

Almost certainly you both edited around the same time and one sync landed after
the other. The earlier version is still in the history — say so rather than
retyping.

Then, for shared lists, add your content as a **new row at the bottom** instead of
editing existing rows. That habit prevents it entirely.

---

**Anything not listed here?** Same rule: screenshot, post, don't fix. Anything
genuinely new is worth adding to this guide.
