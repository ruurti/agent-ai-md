# MCP Tools Index

## Decision Flow

```
Task requires finding code / symbols / call chains?
│
├─ Check session hook context or run index_status
│   ├─ codebase-memory-mcp indexed → use it first → @codebase-memory-mcp.md
│   └─ not indexed → Grep / Read directly
│       └─ complex navigation needed? → suggest Sếp run index_repository
│
└─ .codegraph/ exists in project root?
    ├─ yes → codegraph tools available → @codegraph.md
    └─ no  → codegraph inactive, do not use
```

## Quick Reference

| Task | Tool |
|------|------|
| Find function / class by name | `search_graph` |
| Trace call chain | `trace_path` |
| Get exact source of a symbol | `get_code_snippet` |
| Project structure overview | `get_architecture` |
| Text search (graph-augmented) | `search_code` |
| Config / text / non-code files | Read / Grep directly |
| List files / git status / log | Bash via `rtk` |

## Rules

* Do not call MCP tools manually when the hook auto-augments Grep/Glob results.
* Do not run `index_repository` or `codegraph init` — indexing is Sếp's decision.
* If workspace is not indexed and Grep is insufficient → tell Sếp, suggest indexing.

## MCP Docs

* [codebase-memory-mcp](codebase-memory-mcp.md) — knowledge graph, structural queries
* [codegraph](codegraph.md) — local code graph (requires `.codegraph/` dir)
