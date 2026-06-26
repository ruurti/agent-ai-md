#!/usr/bin/env bash
# uninstall-local.sh — Remove agent-ai-md from a local workspace
#
# Usage:
#   bash uninstall-local.sh [WORKSPACE_DIR]
#
# WORKSPACE_DIR defaults to the current directory.

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PREFIX="ruurti"
MENTION="@${PREFIX}/CLAUDE.md"

WORKSPACE="${1:-$(pwd)}"
CLAUDE_DIR="${WORKSPACE}/.claude"
INSTALL_DIR="${CLAUDE_DIR}/${PREFIX}"

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "${CYAN}  →${NC} $*"; }
die()  { echo -e "\033[0;31m  ✗${NC} $*" >&2; exit 1; }

echo ""
echo "=== agent-ai-md local uninstaller ==="
echo ""
info "Workspace: ${WORKSPACE}"

# ── Guard ─────────────────────────────────────────────────────────────────────
if [[ ! -d "$WORKSPACE" ]]; then
    die "Workspace does not exist: ${WORKSPACE}"
fi

# ── Remove <workspace>/.claude/ruurti/ ───────────────────────────────────────
echo ""
info "Removing ${INSTALL_DIR}..."
if [[ -d "$INSTALL_DIR" ]]; then
    rm -rf "$INSTALL_DIR"
    ok "Removed: ${INSTALL_DIR}"
else
    warn "Not found: ${INSTALL_DIR} (not installed or already uninstalled)."
fi

# ── Remove @mention from <workspace>/.claude/CLAUDE.md ───────────────────────
echo ""
info "Cleaning ${CLAUDE_DIR}/CLAUDE.md..."
local_main="${CLAUDE_DIR}/CLAUDE.md"
if [[ -f "$local_main" ]] && grep -qF "$MENTION" "$local_main"; then
    grep -vF "$MENTION" "$local_main" > "${local_main}.tmp" && mv "${local_main}.tmp" "$local_main"
    ok "Removed ${MENTION} from ${local_main}"
else
    warn "${MENTION} not found in ${local_main} — skipped."
fi

echo ""
ok "Done. Restart Claude Code to apply changes."
