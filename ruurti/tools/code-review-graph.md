# code-review-graph

Local code intelligence graph for token-efficient reviews. Builds a persistent map of the codebase so Claude reads only what matters — 8.2× average context reduction.

## Check Availability

Graph is active when the workspace has been indexed (via `code-review-graph build`).

If not indexed → fall back to Grep / Read, or suggest Sếp run `code-review-graph build`.

## Core Tools

### Code review workflow

```
detect_changes_tool          # risk-scored analysis of changed files — start here
get_impact_radius_tool       # blast radius of changes across codebase
get_review_context_tool      # token-efficient source snippets for the changed code
get_affected_flows_tool      # impacted execution paths
```

### Code exploration

```
semantic_search_nodes_tool   # find functions / classes by keyword
query_graph_tool             # trace relationships: callers, callees, imports, tests, deps
get_architecture_overview_tool  # high-level structural overview
```

### Refactoring

```
refactor_tool                # rename planning, dead code detection
```

## Usage Rules

* **Always call before Grep / Read** when the graph is available — gives precise context with fewer tokens.
* Start with `detail_level="minimal"` in first calls; upgrade only if more detail is needed.
* Target ≤ 5 tool calls per task.

## Recommended Workflows

**Code review:**
```
detect_changes_tool → get_impact_radius_tool → get_review_context_tool
```

**Exploration / navigation:**
```
semantic_search_nodes_tool → query_graph_tool
```

**Impact analysis before refactor:**
```
get_impact_radius_tool → get_affected_flows_tool → refactor_tool
```

## When NOT to Use

* Graph not built (`code-review-graph build` not run) → Grep / Read directly.
* Config / YAML / markdown files → Read / Grep directly.
* Simple single-file lookup → Read directly.
