#!/usr/bin/env bash

# ── Config ────────────────────────────────────────────────────────────────────
REPO="ruurti/agent-ai-md"
BRANCH="master"
RAW="https://raw.githubusercontent.com/${REPO}/${BRANCH}"

PREFIX="ruurti"
CLAUDE_DIR="${HOME}/.claude"
INSTALL_DIR="${CLAUDE_DIR}/${PREFIX}"
MENTION="@${PREFIX}/CLAUDE.md"

LANG_FILES=(CLAUDE-python.md CLAUDE-react.md CLAUDE-go.md CLAUDE-php.md)
TOOL_FILES=(RTK.md)

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "${CYAN}  →${NC} $*"; }
die()  { echo -e "\033[0;31m  ✗${NC} $*" >&2; exit 1; }

# ── Fetch: local copy takes priority, else download from GitHub ───────────────
fetch() {
    local src="$1" dst="$2"
    if [[ -f "$src" ]]; then
        cp "$src" "$dst"
    elif command -v curl &>/dev/null; then
        curl -fsSL "${RAW}/${src}" -o "$dst" || die "Failed to download: ${src}"
    elif command -v wget &>/dev/null; then
        wget -qO "$dst" "${RAW}/${src}" || die "Failed to download: ${src}"
    else
        die "Neither curl nor wget found."
    fi
}

# ── Cleanup: remove ~/.claude/ruurti/ if exists ───────────────────────────────
cleanup() {
    if [[ -d "$INSTALL_DIR" ]]; then
        rm -rf "$INSTALL_DIR"
        ok "Removed: ${INSTALL_DIR}"
    fi
}

# ── Install ───────────────────────────────────────────────────────────────────
install_languages() {
    mkdir -p "${INSTALL_DIR}/languages"
    for f in "${LANG_FILES[@]}"; do
        fetch "${PREFIX}/languages/${f}" "${INSTALL_DIR}/languages/${f}"
    done
    ok "Languages → ${INSTALL_DIR}/languages/"
}

install_tools() {
    mkdir -p "${INSTALL_DIR}/tools"
    for f in "${TOOL_FILES[@]}"; do
        fetch "${PREFIX}/tools/${f}" "${INSTALL_DIR}/tools/${f}"
    done
    ok "Tools     → ${INSTALL_DIR}/tools/"
}

install_claude_md() {
    local main="${CLAUDE_DIR}/CLAUDE.md"

    fetch "${PREFIX}/CLAUDE.md" "${INSTALL_DIR}/CLAUDE.md"
    ok "CLAUDE.md → ${INSTALL_DIR}/CLAUDE.md"

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

info "Cleaning ${INSTALL_DIR} ..."
cleanup
echo ""

info "Installing to ${INSTALL_DIR}..."
install_claude_md
install_languages
install_tools

echo ""
ok "Done. Restart Claude Code to apply changes."
