#!/usr/bin/env bash
set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PREFIX="ruurti"
CLAUDE_DIR="${HOME}/.claude"
LANG_DIR="${CLAUDE_DIR}/${PREFIX}_languages"
TOOLS_DIR="${CLAUDE_DIR}/${PREFIX}_tools"

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "${CYAN}  →${NC} $*"; }

# ── Cleanup: remove anything matching PREFIX_* in ~/.claude/ ──────────────────
cleanup() {
    local found=0
    for entry in "${CLAUDE_DIR}/${PREFIX}_"*; do
        [[ -e "$entry" ]] || continue
        rm -rf "$entry"
        ok "Removed: $entry"
        found=1
    done
    [[ $found -eq 1 ]] && info "Previous install cleaned."
}

# ── Install ───────────────────────────────────────────────────────────────────
install_languages() {
    mkdir -p "$LANG_DIR"
    cp languages/*.md "$LANG_DIR/"
    ok "Languages → ${LANG_DIR}/"
}

install_tools() {
    mkdir -p "$TOOLS_DIR"
    cp tools/*.md "$TOOLS_DIR/"
    ok "Tools     → ${TOOLS_DIR}/"
}

install_claude_md() {
    local dst="${CLAUDE_DIR}/CLAUDE.md"

    # Backup original only once (skip if .bak already exists)
    if [[ -f "$dst" ]] && [[ ! -f "${dst}.bak" ]]; then
        cp "$dst" "${dst}.bak"
        warn "Backed up original CLAUDE.md → ${dst}.bak"
    fi

    # Strip PROJECT CONTEXT section + rewrite @references to prefixed dirs
    awk '
        /^## PROJECT CONTEXT/ { skip=1; next }
        skip && /^## /        { skip=0 }
        !skip                 { print }
    ' CLAUDE.md \
    | sed "s|@languages/|@${PREFIX}_languages/|g" \
    | sed "s|@tools/|@${PREFIX}_tools/|g" \
    > "$dst"

    ok "CLAUDE.md → ${dst}"
}

# ── Main ──────────────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

if [[ ! -f "CLAUDE.md" ]] || [[ ! -d "languages" ]] || [[ ! -d "tools" ]]; then
    echo "Error: run install.sh from the agent-ai-md project root" >&2
    exit 1
fi

echo ""
echo "=== agent-ai-md installer ==="
echo ""

info "Cleaning ${CLAUDE_DIR}/${PREFIX}_* ..."
cleanup
echo ""

info "Installing to ${CLAUDE_DIR}..."
install_languages
install_tools
install_claude_md

echo ""
ok "Done. Restart Claude Code to apply changes."
