#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# check-rules.sh — the ONE implementation of the vault's four safety rules.
#
# Called by TWO callers, deliberately:
#   1. .git/hooks/pre-commit  (local, installed by install-guard.sh)
#   2. .github/workflows/guard.yml (server-side, cannot be bypassed)
#
# Never copy these rules anywhere else. Two copies drift, and the copy that
# drifts is always the one you were relying on.
#
# Usage:  check-rules.sh <file> [<file> ...]
# Exit:   0 = all clear, 1 = at least one rule broken (message on stdout)
# ---------------------------------------------------------------------------
set -uo pipefail

MAXBYTES=$((50 * 1024 * 1024))   # 50 MB
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BLOCKED="$HERE/blocked-terms.txt"
CHANNEL="the project Slack channel"

# Shared folders that require a classification on every .md file
SHARED_RE='^(00-source-documents|01-engagement|02-discovery|03-deliverables|04-delivery|05-stakeholders|06-value-and-lessons|07-governance)/'

# Files whose JOB is to state, test or record the rules, and which must therefore
# be allowed to name the blocked phrases. Exempt from RULE 4 ONLY — rules 1, 2
# and 3 still apply to them. Every entry has a stated reason so nobody
# re-tightens the list later without understanding why.
#
# The transcripts under 00-source-documents/call-notes/ are also exempt. They are
# the raw call record — their integrity comes from the DM's own review before
# they land, not from a blunt term filter applied on top. If a term genuinely
# needs to survive inside a reviewed transcript, that is a deliberate DM call,
# recorded as its own dated exemption below — not a reason to weaken this list.
rule4_exempt() {
  case "$1" in
    SETUP/hooks/blocked-terms.txt) return 0 ;;   # is the list
    SETUP/hooks/check-rules.sh)    return 0 ;;   # implements the rules
    SETUP/preflight-checklist.md)  return 0 ;;   # tests the rules
    CLAUDE.md|AGENTS.md)           return 0 ;;   # state what must not be shared
    .claude/skills/*/SKILL.md)     return 0 ;;   # instruct agents on the same
    05-stakeholders/stakeholder-map.md) return 0 ;;  # carries the boundary rule
    schema/frontmatter.md)         return 0 ;;   # documents classification
    01-engagement/glossary.md)     return 0 ;;   # defines the terms neutrally
    SETUP/user-guide.html)         return 0 ;;   # explains the guard to the team
    SETUP/setup-sheet.md|SETUP/recovery-guide.md) return 0 ;;
    00-source-documents/call-notes/*) return 0 ;;  # raw call record; cleared by DM review before it lands, not by the term filter
    07-governance/ai-native-evidence-log.md) return 0 ;;  # records that material was withheld; naming the marker is the point
    # Add one-off, dated exemptions for this engagement below as they're
    # agreed — each needs its own stated reason, same as every entry above.
    # Never add a blanket exemption; a specific path with a specific reason
    # is what keeps this list auditable.
    *) return 1 ;;
  esac
}

# Escape regex metacharacters so a term is matched literally, then apply word
# boundaries. Substring matching was wrong: it made "margin" fire on CSS
# `margin:0` and would have made short terms like "MYO" fire inside words.
escape_re() {
  printf '%s' "$1" | sed 's/[][\.^$*+?(){}|\/]/\\&/g'
}

fail=0
say() { printf '%s\n' "$*"; }

problem() {
  # problem <file> <what> <fix>
  fail=1
  say ""
  say "  ✖  $1"
  say "     Why: $2"
  say "     Fix: $3"
}

for f in "$@"; do
  [ -f "$f" ] || continue

  # --- Rule 3: file size -------------------------------------------------
  size=$(wc -c < "$f" | tr -d ' ')
  if [ "$size" -gt "$MAXBYTES" ]; then
    problem "$f" \
      "it is $((size / 1024 / 1024)) MB, over the 50 MB limit for this vault." \
      "Leave the big file in Drive or Teams and capture a summary plus a link instead."
    continue
  fi

  # --- Rule 2: private material outside the ignored paths ----------------
  if grep -qiE '^classification:[[:space:]]*private' "$f" 2>/dev/null; then
    problem "$f" \
      "it is marked 'classification: private' but it is not in your own private folder." \
      "Move it under users/<your-name>/ — that folder never syncs. Or change the audience to 'project team' if you meant to share it."
    continue
  fi

  # --- Rule 1: shared .md must carry a valid classification --------------
  # Generated OKF index files (SETUP/tools/okf_index.py) have no frontmatter
  # by spec, so they are exempt from RULE 1 ONLY. They list links and notes'
  # own descriptions; rules 2, 3 and 4 still apply to them.
  case "$f" in
    *.md)
      if [ "$(basename "$f")" != "index.md" ] && printf '%s' "$f" | grep -qE "$SHARED_RE"; then
        if ! grep -qiE '^classification:[[:space:]]*(internal|client|portfolio)[[:space:]]*$' "$f" 2>/dev/null; then
          problem "$f" \
            "it is in a shared folder but has no audience set, so nobody can tell who it is for." \
            "Say \"capture this\" and point at it — that sets the audience for you. (Or add 'classification: internal' to the top of the file.)"
          continue
        fi
      fi
      ;;
  esac

  # --- Rule 4: blocked terms ---------------------------------------------
  # Word-boundary matched, and skipped entirely for the handful of files whose
  # purpose is to state or test these rules (see rule4_exempt above).
  if [ -f "$BLOCKED" ] && ! rule4_exempt "$f"; then
    while IFS= read -r term; do
      [ -z "$term" ] && continue
      case "$term" in \#*) continue ;; esac
      re="\\b$(escape_re "$term")\\b"
      if grep -qiE -- "$re" "$f" 2>/dev/null; then
        problem "$f" \
          "it contains the phrase \"$term\", which must not go into the shared vault." \
          "Remove or reword that line. If the phrase is genuinely fine here, ask the DM to adjust SETUP/hooks/blocked-terms.txt — the list is meant to be adjustable."
      fi
    done < "$BLOCKED"
  fi
done

if [ "$fail" -ne 0 ]; then
  say ""
  say "─────────────────────────────────────────────────────────────"
  say " Nothing was shared, and nothing you wrote has been lost."
  say " Fix the file(s) above and it will go through on its own."
  say " Stuck? Post a screenshot of this message in $CHANNEL."
  say "─────────────────────────────────────────────────────────────"
  say ""
  exit 1
fi

exit 0
