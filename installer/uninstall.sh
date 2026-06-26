#!/usr/bin/env bash

# ── Config ────────────────────────────────────────────────────────────────────
PREFIX="ruurti"
CLAUDE_DIR="${HOME}/.claude"
INSTALL_DIR="${CLAUDE_DIR}/${PREFIX}"
MENTION="@${PREFIX}/CLAUDE.md"

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "${CYAN}  →${NC} $*"; }

echo ""
echo "=== agent-ai-md uninstaller ==="
echo ""

# ── Remove ~/.claude/ruurti/ ─────────────────────────────────────────────────
info "Removing ${INSTALL_DIR}..."
if [[ -d "$INSTALL_DIR" ]]; then
    rm -rf "$INSTALL_DIR"
    ok "Removed: ${INSTALL_DIR}"
else
    warn "Not found: ${INSTALL_DIR} (not installed or already uninstalled)."
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
