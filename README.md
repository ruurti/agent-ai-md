# agent-ai-md

Personal [Claude Code](https://claude.ai/code) configuration — identity rules, coding standards, and tool guides packed into `CLAUDE.md`.

---

## Global install (recommended)

Installs into `~/.claude/` — applies to every Claude Code session on this machine.

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/install.sh | bash
```

```bash
wget -qO- https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/install.sh | bash
```

Works on macOS, Linux, WSL, and Git Bash. Re-running updates to the latest version.

> Restart Claude Code after install to apply changes.

### Uninstall (global)

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/uninstall.sh | bash
```

```bash
wget -qO- https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/uninstall.sh | bash
```

---

## Local workspace install

Installs into a specific project directory — applies only when Claude Code opens that workspace.

```bash
# Install into a specific project
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/install-local.sh | bash -s -- /path/to/your/project
```

```bash
wget -qO- https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/install-local.sh | bash -s -- /path/to/your/project
```

```bash
# Install into the current directory
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/install-local.sh | bash
```

### Uninstall (local)

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/uninstall-local.sh | bash -s -- /path/to/your/project
```

```bash
wget -qO- https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/uninstall-local.sh | bash -s -- /path/to/your/project
```

```bash
# Uninstall from the current directory
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/installer/uninstall-local.sh | bash
```

---

## What gets installed

### Global

Everything goes into `~/.claude/ruurti/`. Your existing `~/.claude/CLAUDE.md` is untouched — only an `@ruurti/CLAUDE.md` mention is appended.

| Path | Content |
| --- | --- |
| `~/.claude/ruurti/CLAUDE.md` | Global rules (identity, coding, communication) |
| `~/.claude/ruurti/languages/` | Per-language guidelines (Python, React, Go, PHP) |
| `~/.claude/ruurti/tools/` | Tool guides (RTK, codebase-memory-mcp, codegraph) |

### Local workspace

Everything goes into `<workspace>/.claude/ruurti/`. Your existing `<workspace>/.claude/CLAUDE.md` is untouched — only an `@ruurti/CLAUDE.md` mention is appended.

| Path | Content |
| --- | --- |
| `<workspace>/.claude/ruurti/CLAUDE.md` | Global rules (identity, coding, communication) |
| `<workspace>/.claude/ruurti/languages/` | Per-language guidelines (Python, React, Go, PHP) |
| `<workspace>/.claude/ruurti/tools/` | Tool guides (RTK, codebase-memory-mcp, codegraph) |

---

## MCP setup (optional)

These rules reference two MCP servers for code navigation. Install whichever you use.

> Both MCPs are optional. Without them, Claude falls back to Grep / Read automatically.

### codebase-memory-mcp

Knowledge graph for structural queries — find functions, trace call chains, get architecture overview.

**Install:**

```bash
claude mcp add codebase-memory-mcp -- npx -y codebase-memory-mcp
```

**Verify** (inside a Claude Code session):

```bash
/mcp
# → codebase-memory-mcp should show as "connected"
```

**Index your workspace** (one-time per project, re-run after large changes):

```text
index_repository
```

**Troubleshoot:**

- MCP shows "failed" → restart Claude Code, then run `/mcp` again
- `index_repository` times out → the codebase may be too large; use Grep / Read as fallback
- `npx` not found → install Node.js ≥18 first

### codegraph

Local code graph. Requires a `.codegraph/` directory in the project root.

**Install:**

```bash
npm install -g @codegraph/cli   # or follow the codegraph install docs
codegraph init                  # run in project root
```

**Verify:**

```bash
ls .codegraph/   # directory exists → codegraph is active
/mcp             # codegraph should show as "connected"
```

Start a new Claude Code session after running `codegraph init`.

**Troubleshoot:**

- `.codegraph/` missing → run `codegraph init` in project root first
- MCP not connected → check `claude mcp list` and add it if missing: `claude mcp add codegraph -- codegraph mcp`

### code-review-graph

Local code intelligence graph — 8.2× average context reduction on reviews, impact analysis, and large-repo navigation.

**Install:**

```bash
pip install code-review-graph   # or: uv pip install code-review-graph
```

**Index your workspace** (one-time per project, re-run after large changes):

```bash
code-review-graph build
```

**Wire into Claude Code** (auto-detects and adds MCP):

```bash
code-review-graph install
```

**Verify** (inside a Claude Code session):

```bash
/mcp
# → code-review-graph should show as "connected"
```

**Key tools available after setup:** `detect_changes_tool`, `get_impact_radius_tool`, `get_review_context_tool`, `semantic_search_nodes_tool`, `query_graph_tool`, `get_architecture_overview_tool`

**Troubleshoot:**

- MCP not connected → run `claude mcp list`; if missing, add manually: `claude mcp add code-review-graph -- code-review-graph mcp`
- `code-review-graph build` is slow → expected for first run; subsequent runs are incremental (~200ms)
- `pip` not found → install Python ≥3.10 first, or use `uv pip install code-review-graph`

---

## Customize (fork)

Change `PREFIX` in all four scripts and rename the `ruurti/` folder to match.
