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
| `~/.claude/CLAUDE.md` | Global rules (identity, coding, communication) |
| `~/.claude/ruurti_languages/` | Per-language guidelines (Python, React, Go, PHP) |
| `~/.claude/ruurti_tools/` | Tool guides (RTK) |

Files prefixed with `ruurti_` — re-running install auto-cleans previous version.

---

## Update

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/install.sh | bash
```

Same command. Install cleans `ruurti_*` in `~/.claude/` before copying fresh files.

---

## Uninstall

```bash
rm -rf ~/.claude/ruurti_languages ~/.claude/ruurti_tools
# Restore original CLAUDE.md if needed:
cp ~/.claude/CLAUDE.md.bak ~/.claude/CLAUDE.md
```

---

## Customize (fork)

Change the prefix in `install.sh` line 5:

```bash
PREFIX="yourname"
```

Then rename the source directories to match:

```
ruurti_languages/ → yourname_languages/
ruurti_tools/     → yourname_tools/
```

And update `@references` in `CLAUDE.md` accordingly.
