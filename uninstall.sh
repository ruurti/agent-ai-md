#!/usr/bin/env bash
set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PREFIX="ruurti"
CLAUDE_DIR="${HOME}/.claude"

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "${CYAN}  →${NC} $*"; }

echo ""
echo "=== agent-ai-md uninstaller ==="
echo ""

# ── Remove prefixed dirs/files ─────────────────────────────────────────────────
info "Removing ${PREFIX}_* from ${CLAUDE_DIR}..."
found=0
for entry in "${CLAUDE_DIR}/${PREFIX}_"*; do
    [[ -e "$entry" ]] || continue
    rm -rf "$entry"
    ok "Removed: $entry"
    found=1
done
[[ $found -eq 0 ]] && warn "Nothing to remove (not installed or already uninstalled)."

# ── Restore CLAUDE.md from backup ─────────────────────────────────────────────
echo ""
info "Restoring CLAUDE.md..."
if [[ -f "${CLAUDE_DIR}/CLAUDE.md.bak" ]]; then
    cp "${CLAUDE_DIR}/CLAUDE.md.bak" "${CLAUDE_DIR}/CLAUDE.md"
    rm -f "${CLAUDE_DIR}/CLAUDE.md.bak"
    ok "Restored CLAUDE.md from backup."
else
    warn "No backup found (${CLAUDE_DIR}/CLAUDE.md.bak). CLAUDE.md left as-is."
fi

echo ""
ok "Done. Restart Claude Code to apply changes."
