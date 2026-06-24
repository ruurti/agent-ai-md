# agent-ai-md

Personal [Claude Code](https://claude.ai/code) configuration — identity rules, coding standards, and tool guides packed into `CLAUDE.md`.

---

## Install / Update

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/install.sh | bash
```

```bash
wget -qO- https://raw.githubusercontent.com/ruurti/agent-ai-md/master/install.sh | bash
```

Works on macOS, Linux, WSL, and Git Bash. Re-running installs the latest version.

> Restart Claude Code after install to apply changes.

---

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/ruurti/agent-ai-md/master/uninstall.sh | bash
```

```bash
wget -qO- https://raw.githubusercontent.com/ruurti/agent-ai-md/master/uninstall.sh | bash
```

---

## What gets installed

Everything goes into `~/.claude/ruurti/`. Your existing `~/.claude/CLAUDE.md` is untouched — only an `@ruurti/CLAUDE.md` mention is appended.

| Path | Content |
| --- | --- |
| `~/.claude/ruurti/CLAUDE.md` | Global rules (identity, coding, communication) |
| `~/.claude/ruurti/languages/` | Per-language guidelines (Python, React, Go, PHP) |
| `~/.claude/ruurti/tools/` | Tool guides (RTK) |

---

## Customize (fork)

Change `PREFIX` in `install.sh` and `uninstall.sh`, then rename the `ruurti/` folder to match.
