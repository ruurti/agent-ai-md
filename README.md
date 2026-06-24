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
| `~/.claude/ruurti_CLAUDE.md` | Global rules (identity, coding, communication) |
| `~/.claude/ruurti_languages/` | Per-language guidelines (Python, React, Go, PHP) |
| `~/.claude/ruurti_tools/` | Tool guides (RTK) |

`ruurti_CLAUDE.md` is wired into your existing `~/.claude/CLAUDE.md` via an `@ruurti_CLAUDE.md` mention — existing config is untouched. All installed files share the `ruurti_` prefix for easy cleanup.

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

Removes all `ruurti_*` files/dirs from `~/.claude/` and cleans the `@ruurti_CLAUDE.md` mention from `CLAUDE.md`.
