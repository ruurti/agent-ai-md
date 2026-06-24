#!/usr/bin/env bash
set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
PREFIX="ai-md"
CLAUDE_DIR="${HOME}/.claude"
LANG_DIR="${CLAUDE_DIR}/${PREFIX}-languages"
TOOLS_DIR="${CLAUDE_DIR}/${PREFIX}-tools"
TRACK_FILE="${CLAUDE_DIR}/.${PREFIX}-installed"

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "${CYAN}  →${NC} $*"; }

# ── Cleanup ───────────────────────────────────────────────────────────────────
cleanup() {
    [[ ! -f "$TRACK_FILE" ]] && return
    info "Removing previous install..."
    while IFS= read -r entry; do
        if [[ -e "$entry" ]]; then
            rm -rf "$entry"
            ok "Removed: $entry"
        fi
    done < "$TRACK_FILE"
    rm -f "$TRACK_FILE"
}

track()      { echo "$1" >> "$TRACK_FILE"; }
is_managed() { [[ -f "$TRACK_FILE" ]] && grep -qF "$1" "$TRACK_FILE"; }

# ── Install ───────────────────────────────────────────────────────────────────
install_languages() {
    mkdir -p "$LANG_DIR"
    cp languages/*.md "$LANG_DIR/"
    track "$LANG_DIR"
    ok "Languages → ${LANG_DIR}/"
}

install_tools() {
    mkdir -p "$TOOLS_DIR"
    cp tools/*.md "$TOOLS_DIR/"
    track "$TOOLS_DIR"
    ok "Tools     → ${TOOLS_DIR}/"
}

install_claude_md() {
    local dst="${CLAUDE_DIR}/CLAUDE.md"

    # Backup only if not previously installed by us
    if [[ -f "$dst" ]] && ! is_managed "$dst"; then
        cp "$dst" "${dst}.bak"
        warn "Backed up existing CLAUDE.md → ${dst}.bak"
    fi

    # Strip PROJECT CONTEXT section + rewrite @references to use prefixed dirs
    awk '
        /^## PROJECT CONTEXT/ { skip=1; next }
        skip && /^## /        { skip=0 }
        !skip                 { print }
    ' CLAUDE.md \
    | sed "s|@languages/|@${PREFIX}-languages/|g" \
    | sed "s|@tools/|@${PREFIX}-tools/|g" \
    > "$dst"

    track "$dst"
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

cleanup
info "Installing to ${CLAUDE_DIR}..."
echo ""

install_languages
install_tools
install_claude_md

echo ""
ok "Done. Restart Claude Code to apply changes."
