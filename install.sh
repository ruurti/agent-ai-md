#!/usr/bin/env bash

# ── Config ────────────────────────────────────────────────────────────────────
REPO="ruurti/agent-ai-md"
BRANCH="master"
PREFIX="ruurti"
CLAUDE_DIR="${HOME}/.claude"
INSTALL_DIR="${CLAUDE_DIR}/${PREFIX}"
MENTION="@${PREFIX}/CLAUDE.md"

# ── Output ────────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
ok()   { echo -e "${GREEN}  ✓${NC} $*"; }
warn() { echo -e "${YELLOW}  !${NC} $*"; }
info() { echo -e "${CYAN}  →${NC} $*"; }
die()  { echo -e "\033[0;31m  ✗${NC} $*" >&2; exit 1; }

# ── Cleanup ───────────────────────────────────────────────────────────────────
cleanup() {
    if [[ -d "$INSTALL_DIR" ]]; then
        rm -rf "$INSTALL_DIR"
        ok "Removed: ${INSTALL_DIR}"
    fi
}

# ── Install files ─────────────────────────────────────────────────────────────
install_files() {
    mkdir -p "$INSTALL_DIR"

    if [[ -d "$PREFIX" ]]; then
        # Local mode: running from the cloned repo
        cp -r "${PREFIX}/." "$INSTALL_DIR/"
        ok "Files copied → ${INSTALL_DIR}/"
    else
        # Remote mode: download as a single tarball, extract only PREFIX/ folder
        # </dev/null isolates stdin so it doesn't compete with bash's pipe read
        local archive_root="${REPO##*/}-${BRANCH}"
        local url="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz"

        if command -v curl &>/dev/null; then
            curl -fsSL "$url" </dev/null \
                | tar xz -C "$INSTALL_DIR" \
                    --strip-components=2 \
                    "${archive_root}/${PREFIX}" \
                || die "Download failed."
        elif command -v wget &>/dev/null; then
            wget -qO- "$url" \
                | tar xz -C "$INSTALL_DIR" \
                    --strip-components=2 \
                    "${archive_root}/${PREFIX}" \
                || die "Download failed."
        else
            die "Neither curl nor wget found."
        fi
        ok "Files downloaded → ${INSTALL_DIR}/"
    fi
}

# ── Wire @mention into ~/.claude/CLAUDE.md ────────────────────────────────────
wire_mention() {
    local main="${CLAUDE_DIR}/CLAUDE.md"

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

info "Cleaning ${INSTALL_DIR}..."
cleanup
echo ""

info "Installing to ${INSTALL_DIR}..."
install_files
wire_mention

echo ""
ok "Done. Restart Claude Code to apply changes."
