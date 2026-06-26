# codebase-memory-mcp

Knowledge graph for structural code queries. Requires workspace to be indexed.

## Check Status

```
index_status                    # is workspace indexed?
list_projects                   # list all indexed projects
```

## Core Commands

### Find symbols

```
search_graph(name_pattern="UserService")
search_graph(label="Function", qn_pattern=".*auth.*")
search_graph(label="Class", name_pattern=".*Repository")
```

### Trace call chains

```
trace_path("createUser", mode="calls")           # who does createUser call?
trace_path("createUser", mode="data_flow")       # data flow through createUser
trace_path("createUser", mode="cross_service")   # across service boundaries
```

### Get source

```
get_code_snippet("UserService.createUser")       # exact source with line range
get_code_snippet("auth.middleware.validateToken")
```

### Architecture

```
get_architecture(aspects=["overview"])
get_architecture(aspects=["dependencies", "layers"])
```

### Text search (graph-augmented)

```
search_code("pattern")    # grep + graph context; prefer over bare Grep when indexed
```

### Advanced Cypher

```
query_graph("MATCH (f:Function)-[:CALLS]->(g:Function) WHERE f.name = 'foo' RETURN g")
get_graph_schema           # see available node labels and edge types
```

## Indexing (Sếp's decision — do not run yourself)

```
index_repository           # index the workspace
detect_changes             # detect changes since last index
```

## When NOT to Use

* Config, YAML, markdown, non-code files → Read / Grep directly
* Workspace not indexed → Grep/Read; tell Sếp to run `index_repository`
* Simple single-file lookup → Read directly
