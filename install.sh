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
PREFIXED_CLAUDE="${CLAUDE_DIR}/${PREFIX}_CLAUDE.md"
MENTION="@${PREFIX}_CLAUDE.md"

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

# ── Cleanup: remove all PREFIX_* entries in ~/.claude/ ───────────────────────
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
    local main="${CLAUDE_DIR}/CLAUDE.md"
    local tmp
    tmp="$(mktemp)"

    # Fetch source and strip PROJECT CONTEXT → ruurti_CLAUDE.md
    fetch "CLAUDE.md" "$tmp"
    awk '
        /^## PROJECT CONTEXT/ { skip=1; next }
        skip && /^## /        { skip=0 }
        !skip                 { print }
    ' "$tmp" > "$PREFIXED_CLAUDE"
    rm -f "$tmp"
    ok "${PREFIX}_CLAUDE.md → ${PREFIXED_CLAUDE}"

    # Wire up: add @mention to main CLAUDE.md
    if [[ -f "$main" ]]; then
        if grep -qF "$MENTION" "$main"; then
            ok "CLAUDE.md already references ${MENTION} — skipped."
        else
            printf '\n%s\n' "$MENTION" >> "$main"
            ok "Added ${MENTION} to existing CLAUDE.md"
        fi
    else
        mkdir -p "$CLAUDE_DIR"
        printf '%s\n' "$MENTION" > "$main"
        ok "Created CLAUDE.md with ${MENTION}"
    fi
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
