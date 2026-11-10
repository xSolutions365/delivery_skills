#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# session-sync.sh — commit and push the vault at the end of a Claude Code turn.
#
# Called by the Stop hook in .claude/settings.json.
#
# WHY THIS EXISTS: Obsidian is optional. Someone working only in Claude Code
# would otherwise rely on the agent remembering to commit and push — an
# instruction, not a mechanism. Instructions get missed, and the failure mode is
# a day's work sitting on one laptop while the team thinks it has it.
#
# WHAT IT DOES NOT DO: it never bypasses the safety guard. If the pre-commit
# check blocks, the commit does not happen, the work stays local and intact, and
# the reason is printed. That is correct behaviour.
#
# Deliberately bash-3.2 compatible (macOS ships 3.2).
# ---------------------------------------------------------------------------
set -uo pipefail

cd "$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0

# Nothing tracked has changed? Nothing to do. Stay silent.
if git diff --quiet HEAD -- 2>/dev/null && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  exit 0
fi

# --- Stage only known vault paths -------------------------------------------
# This used to be `git add -A`, which was wrong. Any tool that writes a new
# top-level directory got silently committed and pushed — that is exactly how a
# Claude Code `memory/` folder containing a personal profile ended up on the
# remote. In a repo with a strict content boundary, the default must be that
# unknown paths are NOT shared until a human decides.
KNOWN="00-source-documents 01-engagement 02-discovery 03-deliverables 04-delivery \
05-stakeholders 06-value-and-lessons 07-governance roles schema templates SETUP \
.claude .agents/skills .codex/hooks.json .github .obsidian CLAUDE.md AGENTS.md START-HERE.md project-config.md .gitignore"

for p in $KNOWN; do
  [ -e "$p" ] && git add -- "$p" 2>/dev/null
done

# --- Warn loudly about anything outside that list ---------------------------
unknown=""
while IFS= read -r entry; do
  [ -z "$entry" ] && continue
  top="${entry%%/*}"
  case " $KNOWN " in
    *" $top "*) ;;
    *) case "$entry" in .agents/skills/*|.codex/hooks.json) continue ;; esac
       case " $unknown " in *" $top "*) ;; *) unknown="$unknown $top" ;; esac ;;
  esac
done < <(git ls-files --others --exclude-standard)

if [ -n "$unknown" ]; then
  echo ""
  echo "  ⚠️  Not shared — unrecognised path(s) in the vault:"
  for u in $unknown; do echo "        $u"; done
  echo ""
  echo "     These were left alone deliberately. Nothing outside the known vault"
  echo "     structure is shared automatically, because tools sometimes write"
  echo "     folders nobody intended to publish."
  echo ""
  echo "     If it belongs in the vault, add it to KNOWN in this script."
  echo "     If it does not, add it to .gitignore. If you are unsure, ask the DM."
  echo ""
fi

# Nothing staged (e.g. only ignored or unknown paths changed) — silent exit.
if git diff --cached --quiet 2>/dev/null; then
  exit 0
fi

count=$(git diff --cached --name-only | wc -l | tr -d ' ')
stamp=$(date "+%Y-%m-%d %H:%M")

# The guard runs here. If it blocks, git commit exits non-zero and prints why.
if ! out=$(git commit -m "Vault update — $stamp ($count file(s))" 2>&1); then
  echo ""
  echo "$out"
  echo ""
  echo "  ⓘ  Your work is saved on your laptop and nothing is lost."
  echo "     Fix the file above and it will sync on the next turn."
  git reset --quiet
  exit 0
fi

# Pull anything new before pushing, so we never force a divergence.
if ! git pull --rebase --autostash --quiet 2>/dev/null; then
  echo "  ⓘ  Vault: committed locally, but could not pull to sync."
  echo "     Your work is safe. Post a screenshot in the project Slack channel if this repeats."
  exit 0
fi

if ! git push --quiet 2>/dev/null; then
  echo "  ⓘ  Vault: committed locally, but could not push."
  echo "     Your work is safe. Post a screenshot in the project Slack channel if this repeats."
  exit 0
fi

# Success is quiet by design — one line, no ceremony.
echo "  ✓ Vault synced ($count file(s))"
exit 0
