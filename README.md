# agent-ai-md

Personal [Claude Code](https://claude.ai/code) configuration — identity rules, coding standards, and tool guides packed into `CLAUDE.md`.

---

## Install

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/install.sh | bash
```

### Windows — WSL / Git Bash

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/install.sh | bash
```

No `curl`? Use `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/ruurti/agent-ai-md/master/install.sh | bash
```

> **Restart Claude Code** after install to apply changes.

---

## What gets installed

| Destination | Content |
| --- | --- |
| `~/.claude/ruurti/CLAUDE.md` | Global rules (identity, coding, communication) |
| `~/.claude/ruurti/languages/` | Per-language guidelines (Python, React, Go, PHP) |
| `~/.claude/ruurti/tools/` | Tool guides (RTK) |

Everything goes into `~/.claude/ruurti/`. Your existing `~/.claude/CLAUDE.md` is untouched — only an `@ruurti/CLAUDE.md` mention is appended.

---

## Update

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/install.sh | bash
```

Same command. Install cleans `ruurti_*` in `~/.claude/` before copying fresh files.

---

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/uninstall.sh | bash
```

No `curl`? Use `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/ruurti/agent-ai-md/master/uninstall.sh | bash
```

Removes `~/.claude/ruurti/` and cleans the `@ruurti/CLAUDE.md` mention from `CLAUDE.md`.
