#!/usr/bin/env bash

# ── Config ────────────────────────────────────────────────────────────────────
PREFIX="ruurti"
CLAUDE_DIR="${HOME}/.claude"
MENTION="@${PREFIX}_CLAUDE.md"

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "\033[0;36m  →${NC} $*"; }

echo ""
echo "=== agent-ai-md uninstaller ==="
echo ""

# ── Remove all PREFIX_* files/dirs ───────────────────────────────────────────
info "Removing ${PREFIX}_* from ${CLAUDE_DIR}..."
count=0
for entry in "${CLAUDE_DIR}/${PREFIX}_"*; do
    [[ -e "$entry" ]] || continue
    rm -rf "$entry"
    ok "Removed: $entry"
    count=$((count + 1))
done
if [[ $count -eq 0 ]]; then
    warn "Nothing to remove (not installed or already uninstalled)."
fi

# ── Remove @mention from CLAUDE.md ────────────────────────────────────────────
echo ""
info "Cleaning CLAUDE.md..."
main="${CLAUDE_DIR}/CLAUDE.md"
if [[ -f "$main" ]] && grep -qF "$MENTION" "$main"; then
    grep -vF "$MENTION" "$main" > "${main}.tmp" && mv "${main}.tmp" "$main"
    ok "Removed ${MENTION} from CLAUDE.md"
else
    warn "${MENTION} not found in CLAUDE.md — skipped."
fi

echo ""
ok "Done. Restart Claude Code to apply changes."
