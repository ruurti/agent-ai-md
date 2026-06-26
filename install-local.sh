#!/usr/bin/env bash
# install-local.sh — Install agent-ai-md into a local workspace (not global ~/.claude/)
#
# Usage:
#   bash install-local.sh [WORKSPACE_DIR]
#
# WORKSPACE_DIR defaults to the current directory.
# Files are installed to <WORKSPACE_DIR>/.claude/ruurti/
# @ruurti/CLAUDE.md is wired into <WORKSPACE_DIR>/.claude/CLAUDE.md

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
REPO="ruurti/agent-ai-md"
BRANCH="master"
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

# ── Guard: workspace must exist ───────────────────────────────────────────────
guard_workspace() {
    if [[ ! -d "$WORKSPACE" ]]; then
        die "Workspace does not exist: ${WORKSPACE}"
    fi
    info "Workspace: ${WORKSPACE}"
}

# ── Cleanup ───────────────────────────────────────────────────────────────────
cleanup() {
    if [[ -d "$INSTALL_DIR" ]]; then
        rm -rf "$INSTALL_DIR"
        ok "Removed: ${INSTALL_DIR}"
    fi
}

# ── Download from GitHub ──────────────────────────────────────────────────────
install_files() {
    mkdir -p "$INSTALL_DIR"

    local archive_root="${REPO##*/}-${BRANCH}"
    local url="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz"

    info "Downloading from GitHub (${REPO}@${BRANCH})..."

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

    ok "Files installed → ${INSTALL_DIR}/"
}

# ── Wire @mention into <workspace>/.claude/CLAUDE.md ─────────────────────────
wire_mention() {
    local main="${CLAUDE_DIR}/CLAUDE.md"

    if [[ -f "$main" ]]; then
        if grep -qF "$MENTION" "$main"; then
            ok "CLAUDE.md already references ${MENTION} — skipped."
        else
            printf '\n%s\n' "$MENTION" >> "$main" || die "Failed to write to ${main}"
            ok "Added ${MENTION} to existing ${main}"
        fi
    else
        mkdir -p "$CLAUDE_DIR"
        printf '%s\n' "$MENTION" > "$main" || die "Failed to create ${main}"
        ok "Created ${main} with ${MENTION}"
    fi
}

# ── Verify install ────────────────────────────────────────────────────────────
verify_install() {
    local main="${CLAUDE_DIR}/CLAUDE.md"
    local rules="${INSTALL_DIR}/CLAUDE.md"
    local passed=true

    echo ""
    echo "── Verification ──────────────────────────────────────────────"

    if [[ -f "$rules" ]]; then
        ok "${rules}"
    else
        warn "MISSING: ${rules}"
        passed=false
    fi

    if [[ -f "$main" ]] && grep -qF "$MENTION" "$main"; then
        ok "${main}  (contains ${MENTION})"
    else
        warn "MISSING mention in ${main}"
        passed=false
    fi

    echo ""
    echo "── ${main} content ────────────────────"
    if [[ -f "$main" ]]; then
        cat "$main"
    else
        warn "(file not found)"
    fi
    echo "──────────────────────────────────────────────────────────────"

    if [[ "$passed" == false ]]; then
        die "Verification failed — re-run the installer or check permissions."
    fi
}

# ── Main ──────────────────────────────────────────────────────────────────────
echo ""
echo "=== agent-ai-md local installer ==="
echo ""

guard_workspace

info "Cleaning ${INSTALL_DIR}..."
cleanup
echo ""

info "Installing to ${INSTALL_DIR}..."
install_files
wire_mention

verify_install

echo ""
echo -e "${YELLOW}  ★  RESTART REQUIRED  ★${NC}"
echo "     CLI  : exit and reopen your terminal, then run 'claude'"
echo "     VSCode: Ctrl+Shift+P → 'Developer: Reload Window'"
echo "     App  : quit and reopen Claude Code"
echo ""
