# codegraph

Local code graph. Only active when `.codegraph/` directory exists in project root.

## Check Availability

```bash
rtk ls .codegraph/    # exists → available; "No such file" → inactive
```

Session hook also reports status at startup — check that first.

## Activation (Sếp's decision — do not run yourself)

```bash
codegraph init        # run in project root, then start a new session
```

## When to Use vs codebase-memory-mcp

| Situation | Use |
|-----------|-----|
| `.codegraph/` exists | codegraph |
| Indexed via codebase-memory-mcp | codebase-memory-mcp |
| Neither indexed | Grep / Read directly |

If both are available, prefer `codebase-memory-mcp` (richer query API).

## When Inactive

Do not attempt any codegraph tool calls — they will fail.
Fall back to Grep / Read, or suggest Sếp run `codegraph init`.
