#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# sync-pull.sh — bring the vault up to date with the shared repo.
#
# Called by the SessionStart hook (Claude and Codex) and by session-sync.sh
# before it pushes. Exits 0 when up to date, non-zero when it could not sync.
#
# WHY NOT `git pull --rebase`: pull reads .git/FETCH_HEAD, a file every fetch
# rewrites. Obsidian's Git plugin fetches on open and every few minutes, so when
# it fetches at the same moment as this hook, FETCH_HEAD briefly lists the branch
# twice and pull fails with "Cannot rebase onto multiple branches". First seen
# in a live vault on 2026-11-12. Rebasing onto the upstream ref directly never
# reads FETCH_HEAD, and --no-write-fetch-head stops this script disturbing
# Obsidian's own pull.
#
# If a rebase hits a conflict it is aborted, so the vault is never left
# mid-rebase. Local commits stay intact; the next sync tries again.
#
# Deliberately bash-3.2 compatible (macOS ships 3.2).
# ---------------------------------------------------------------------------
set -uo pipefail

cd "$(git rev-parse --show-toplevel 2>/dev/null)" || exit 1

fetch() { git fetch --quiet --no-write-fetch-head 2>/dev/null; }

# One retry covers a concurrent fetch holding the ref lock.
fetch || { sleep 2; fetch; } || exit 1

if ! git rebase --autostash --quiet '@{upstream}' >/dev/null 2>&1; then
  git rebase --abort >/dev/null 2>&1
  exit 1
fi
exit 0
