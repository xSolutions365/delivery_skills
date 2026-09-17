#!/usr/bin/env bash
# Installs the local safety check into this clone. Run once, per laptop.
set -euo pipefail
ROOT="$(git rev-parse --show-toplevel)"
install -m 0755 "$ROOT/SETUP/hooks/pre-commit" "$ROOT/.git/hooks/pre-commit"
chmod +x "$ROOT/SETUP/hooks/check-rules.sh"
echo ""
echo "  ✓  Safety check installed for this vault."
echo ""
echo "     It now runs automatically before anything is shared, and will"
echo "     stop and explain itself if something looks like it should not be."
echo ""
echo "     Next: turn on Obsidian Git (setup sheet step 6). The check goes"
echo "     in first, on purpose — see SETUP/setup-sheet.md."
echo ""
