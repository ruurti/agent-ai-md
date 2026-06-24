# Go Development Guidelines

## Core Principles

* Follow idiomatic Go.
* Follow Effective Go.
* Follow Go Code Review Comments.
* Prefer simplicity.
* Prefer readability.
* Prefer maintainability.
* Prefer consistency with the existing codebase.

Do not bring patterns from:

* Java
* Spring
* C#
* Enterprise frameworks

into Go unless truly necessary.

## Existing Codebase First

When working in an existing codebase:

* Understand the current architecture before making changes.
* Follow existing conventions.
* Follow existing dependency boundaries.
* Follow existing package structure.

Do not:

* Refactor outside the task scope.
* Change public API without being asked.
* Change package structure without being asked.

Prefer:

* Existing patterns.
* Existing conventions.

## Simplicity First

Prefer:

* Function.
* Struct.
* Package.

Before creating:

* Interface.
* Generic abstraction.
* Framework layer.

If a simple function solves the problem, do not create a new abstraction.

## Package Design

* Packages must have a clear responsibility.
* Packages should be small and focused.

Avoid turning these into dumping grounds:

* `utils`
* `helpers`
* `common`
* `misc`

## Interfaces

Principle:

Accept Interfaces, Return Structs.

Interfaces should be:

* Small.
* Focused.
* Defined close to where they are used.

Do not:

* Create an interface just to mock.
* Create an interface with only one implementation.
* Define an interface in the implementer's package.

Prefer:

```go
type UserReader interface {
    GetByID(ctx context.Context, id string) (*User, error)
}
```

Over large interfaces.

## Dependency Management

* Dependencies must be one-directional.
* Avoid circular dependencies.
* Avoid mutually dependent packages.

If a circular dependency appears:

* Fix the architecture.
* Do not workaround.

## Struct Design

* Structs must have a clear responsibility.
* Avoid overly large structs.
* Avoid God Objects.

Do not cram the entire system into one struct.

## Context

Every request-scoped operation must accept:

```go
context.Context
```

Context should be the first parameter.

Do not:

* Store context in a struct.
* Create unnecessary fake contexts.

## Error Handling

Always handle errors.

Do not:

```go
_, _ = doSomething()
```

Do not:

```go
if err != nil {
    panic(err)
}
```

for normal flow.

Prefer:

```go
if err != nil {
    return fmt.Errorf("create user: %w", err)
}
```

## Error Wrapping

When propagating errors:

```go
fmt.Errorf("operation failed: %w", err)
```

Preserve the original cause.

Do not lose stack information.

## Logging

* Use structured logging if the project supports it.
* Log enough context.
* Do not log secrets.
* Do not log tokens.
* Do not log passwords.

## Concurrency

Only use goroutines when there is a real benefit.

Do not:

* Spawn goroutines arbitrarily.
* Uncontrolled fan-out.
* Spawn goroutines in a loop without assessing risks.

Always consider:

* Goroutine leaks.
* Deadlocks.
* Race conditions.

## Channels

Use channels for communication.

Do not use channels instead of mutexes just out of preference.

Choose the simplest tool:

* Mutex when appropriate.
* Channel when appropriate.

## Synchronization

Assess before completing a task:

* Race conditions.
* Deadlocks.
* Resource leaks.

## Database

* Avoid N+1 queries.
* Avoid queries inside loops.
* Transactions must be explicit.
* Validation does not replace database constraints.

## HTTP Handlers

Handlers should be:

* Thin.
* Focused on HTTP concerns.

Do not embed large business logic in handlers.

Prefer:

Handler → Service → Repository

## Business Logic

Business logic must not live in:

* HTTP handlers.
* Transport layer.
* Infrastructure layer.

Keep business logic separate.

## Configuration

Do not hardcode:

* URLs
* Hosts
* Ports
* Credentials
* API keys
* Environment-specific values

Prefer:

* Environment variables
* Config files

## Paths

Do not hardcode:

* Absolute paths
* Machine-specific paths
* Local development paths

## Generics

Only use generics when:

* They genuinely reduce duplication.
* They improve readability.

Do not use generics to show off.

## Testing

Prefer:

* Table-driven tests.

Example:

```go
tests := []struct {
    name     string
    input    string
    expected string
}{
    ...
}
```

Test:

* Business behavior.
* Edge cases.
* Error cases.

Do not test implementation details.

## Benchmarks

Benchmark before optimizing.

Do not optimize based on intuition.

## AI Safety Rules

Before writing code:

* Look for similar packages.
* Look for similar services.
* Look for similar repositories.
* Look for existing patterns.

Prefer reuse.

Do not:

* Hardcode data.
* Hardcode config.
* Hardcode business rules.
* Hardcode permissions.
* Hardcode feature flags.
* Copy-paste logic between packages.

## Large Repository Safety

When working in a monorepo or large codebase:

* Understand the dependency graph before making changes.
* Only modify what is relevant to the task.
* Do not refactor outside the required scope.
* Do not change package structure unless asked.
* Do not change public API unless asked.
* Warn if a change may affect other packages.

## Completion Checklist

Before completing a task:

* No circular dependencies.
* No hardcoded values.
* No goroutine leaks.
* No obvious race conditions.
* No duplicate logic.
* No package boundary violations.
* Errors handled correctly.
* Context passed correctly.
* Follows idiomatic Go.
* Edge cases evaluated.

## Architecture Preservation

Do not introduce:

* Service layer
* Repository layer
* Interface abstraction
* Generic abstraction

unless the existing codebase already uses them
or the task explicitly requires them.
