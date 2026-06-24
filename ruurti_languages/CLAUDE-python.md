# Python Development Guidelines

## Core Principles

* Follow PEP8.
* Follow Clean Code principles.
* Readability over clever code.
* Maintainability over premature optimization.
* Simplest solution that meets requirements.
* Correctness over performance.
* Optimize performance only when there is evidence or an explicit requirement.

## Existing Codebase First

When working in an existing codebase:

* Understand the current architecture before making changes.
* Follow existing patterns.
* Follow existing project conventions.
* Follow existing dependency boundaries.
* Prefer consistency over personal preference.

Do not:

* Change architecture without being asked.
* Change naming conventions without being asked.
* Refactor outside the task scope.
* Change public API without being asked.

## Code Structure

* Each module should have one primary responsibility.
* Each function should have one clear responsibility.
* Avoid overly long functions.
* Avoid overly large classes.
* Prefer composition over inheritance.
* Avoid premature abstraction.
* Avoid creating helpers used only once.
* Avoid creating a class when a function is sufficient.

## Naming

* Names must accurately describe their purpose.
* Do not use vague names such as:

  * data
  * obj
  * item
  * temp
  * result
  * value

Unless the context is truly unambiguous.

## Clean Code

* Prefer early return.
* Avoid deeply nested conditions.
* Avoid duplicate logic.
* Avoid unclear side effects.
* Avoid functions that do too many things.
* Avoid boolean flags that change multiple behaviors in the same function.

## Imports

* Imports must be at the top of the file.
* Do not import inside a function.

Exceptions only when:

* Lazy loading is necessary.
* Dependency is very heavy.
* A confirmed circular dependency reason exists.

Do not use in-function imports to hide architectural flaws.

## Dependency Management

* Avoid circular imports.
* Avoid reverse dependencies between layers.
* Prefer one-directional dependency.
* If a circular dependency is detected:

  * Analyze the architectural root cause.
  * Refactor the dependency graph.
  * Do not resolve with temporary workarounds.

## Module Boundaries

* Respect module boundaries.
* Do not access the internal implementation of another module.
* Only use public APIs.
* Do not create new dependencies between independent modules unless truly necessary.
* Do not pull business logic across multiple modules.

## Layer Separation

Clearly separate:

* API Layer
* Service Layer
* Business Logic
* Repository Layer
* Infrastructure Layer

Do not let:

* API handle business logic.
* Repository contain business logic.
* Infrastructure control business flow.

## Paths And Files

* Do not hardcode absolute paths.
* Do not hardcode environment-dependent paths.
* Prefer `pathlib.Path`.
* Configuration must come from config files or environment variables.

Do not:

* Hardcode local paths.
* Hardcode usernames.
* Hardcode machine-specific configuration.

## Configuration

All values that change per environment must be in:

* Config files
* Environment variables
* Secret managers

Do not hardcode:

* URLs
* API keys
* Tokens
* Passwords
* Hostnames
* Ports
* Business configuration

## Type Hints

* Use type hints for public APIs.

* Prefer modern typing:

  * `list[str]`
  * `dict[str, Any]`
  * `tuple[str, int]`

* Do not create complex types that reduce readability.

* Types must support maintainability.

## Dataclasses And Models

Prefer:

* `dataclass` for simple DTOs.
* Pydantic for validation and schema.

Do not create a class just to hold simple data if a dataclass is sufficient.

## Error Handling

* Do not ignore exceptions.
* Do not use bare `except`.
* Do not swallow exceptions.

Always:

* Catch specific exceptions.
* Log sufficient context.
* Preserve the stack trace when appropriate.

Prefer:

```python
except SpecificError as exc:
```

Avoid:

```python
except:
```

## Logging

* Use logging instead of print in production code.
* Log enough context for debugging.
* Do not log secrets.
* Do not log credentials.
* Do not log tokens.

## Async Programming

* Only use async when there is a clear benefit.
* Do not convert code to async just because it is trending.
* Do not mix sync and async arbitrarily.
* Manage timeouts explicitly.

## Database

* Avoid N+1 queries.
* Avoid queries inside loops.
* Use transactions when needed.
* Validation does not replace database constraints.

## Testing

Prefer pytest.

Tests must be:

* Independent.
* Readable.
* Repeatable.

Test:

* Behavior.
* Business rules.
* Edge cases.

Do not test:

* Internal implementation.
* Details that do not affect behavior.

## Performance

* Measure before optimizing.
* Benchmark before optimizing.
* Profile before optimizing.

Do not:

* Optimize based on intuition.
* Sacrifice readability for premature optimization.

## AI Safety Rules

Before writing code:

* Look for existing implementations.
* Look for existing utilities.
* Look for existing services.
* Look for existing patterns.

Prefer reuse.

Do not:

* Hardcode data to pass tests.
* Hardcode business rules.
* Hardcode config.
* Hardcode fake responses.
* Hardcode URLs.
* Hardcode credentials.
* Copy-paste logic between modules.
* Write workarounds that hide bugs.

Always prefer:

* Root cause fix.
* Reusable solution.
* Maintainable solution.

## Large Repository Safety

When working in a monorepo or large codebase:

* Understand the dependency graph before making changes.
* Only modify what is relevant to the task.
* Do not refactor outside the required scope.
* Do not rename packages unless asked.
* Do not change public API unless asked.
* Warn if a change may affect other modules.

## Completion Checklist

Before completing a task:

* PEP8 compliant.
* No circular imports.
* No imports inside functions.
* No hardcoded values.
* No duplicate logic.
* No module boundary violations.
* No unnecessary dependencies.
* Appropriate error handling.
* Appropriate type hints.
* Test impact assessment done.
* Edge cases evaluated.

When modifying existing code:
Prefer extending existing patterns over introducing new patterns.
