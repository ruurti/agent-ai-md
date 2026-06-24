# agent-ai-md

Personal [Claude Code](https://claude.ai/code) configuration — identity rules, coding standards, and tool guides packed into `CLAUDE.md`.

Clone → install → restart Claude Code. Done.

---

## What gets installed

| Destination | Content |
|---|---|
| `~/.claude/CLAUDE.md` | Global rules (identity, coding, communication) |
| `~/.claude/ruurti_languages/` | Per-language guidelines (Python, React, Go, PHP) |
| `~/.claude/ruurti_tools/` | Tool guides (RTK) |

Files prefixed with `ruurti_` so re-running install auto-cleans previous version.

---

## Install

### macOS / Linux

```bash
git clone https://github.com/ruurti/agent-ai-md.git
cd agent-ai-md
./install.sh
```

### Windows — WSL

```bash
git clone https://github.com/ruurti/agent-ai-md.git
cd agent-ai-md
bash install.sh
```

### Windows — Git Bash

```bash
git clone https://github.com/ruurti/agent-ai-md.git
cd agent-ai-md
bash install.sh
```

> **Note:** Native PowerShell is not supported. Use WSL or Git Bash.

After install, **restart Claude Code** to apply changes.

---

## Update

```bash
cd agent-ai-md
git pull
./install.sh
```

Re-running `install.sh` removes the previous install (`ruurti_*` glob) before copying fresh files.

---

## Uninstall

```bash
rm -rf ~/.claude/ruurti_languages ~/.claude/ruurti_tools
# Restore original CLAUDE.md if needed:
cp ~/.claude/CLAUDE.md.bak ~/.claude/CLAUDE.md
```

---

## Customize

If forking for personal use, change the prefix in `install.sh`:

```bash
PREFIX="yourname"   # line 5
```

Then rename the source directories to match:

```
ruurti_languages/ → yourname_languages/
ruurti_tools/     → yourname_tools/
```

And update `@references` in `CLAUDE.md` accordingly.
