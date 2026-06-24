#!/usr/bin/env bash
set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
REPO="ruurti/agent-ai-md"
BRANCH="master"
RAW="https://raw.githubusercontent.com/${REPO}/${BRANCH}"

PREFIX="ruurti"
CLAUDE_DIR="${HOME}/.claude"
LANG_DIR="${CLAUDE_DIR}/${PREFIX}_languages"
TOOLS_DIR="${CLAUDE_DIR}/${PREFIX}_tools"

LANG_FILES=(CLAUDE-python.md CLAUDE-react.md CLAUDE-go.md CLAUDE-php.md)
TOOL_FILES=(RTK.md)

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "${CYAN}  →${NC} $*"; }

# ── Fetch: local copy takes priority, else download from GitHub ───────────────
fetch() {
    local src="$1" dst="$2"
    if [[ -f "$src" ]]; then
        cp "$src" "$dst"
    elif command -v curl &>/dev/null; then
        curl -fsSL "${RAW}/${src}" -o "$dst"
    else
        wget -qO "$dst" "${RAW}/${src}"
    fi
}

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
    for f in "${LANG_FILES[@]}"; do
        fetch "${PREFIX}_languages/${f}" "${LANG_DIR}/${f}"
    done
    ok "Languages → ${LANG_DIR}/"
}

install_tools() {
    mkdir -p "$TOOLS_DIR"
    for f in "${TOOL_FILES[@]}"; do
        fetch "${PREFIX}_tools/${f}" "${TOOLS_DIR}/${f}"
    done
    ok "Tools     → ${TOOLS_DIR}/"
}

install_claude_md() {
    local dst="${CLAUDE_DIR}/CLAUDE.md"
    local tmp
    tmp="$(mktemp)"

    fetch "CLAUDE.md" "$tmp"

    # Backup original only once (skip if .bak already exists)
    if [[ -f "$dst" ]] && [[ ! -f "${dst}.bak" ]]; then
        cp "$dst" "${dst}.bak"
        warn "Backed up original CLAUDE.md → ${dst}.bak"
    fi

    # Strip PROJECT CONTEXT section
    awk '
        /^## PROJECT CONTEXT/ { skip=1; next }
        skip && /^## /        { skip=0 }
        !skip                 { print }
    ' "$tmp" > "$dst"

    rm -f "$tmp"
    ok "CLAUDE.md → ${dst}"
}

# ── Main ──────────────────────────────────────────────────────────────────────
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
