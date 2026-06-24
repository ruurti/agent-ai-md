# PHP Development Guidelines

## Core Principles

* Follow PSR standards.
* Follow Clean Code principles.
* Prioritize readability.
* Prioritize maintainability.
* Prioritize consistency with the existing codebase.
* Simplest solution that works.

Do not write code in an old PHP style if the project uses modern PHP.

Prefer:

* PHP 8+
* Strict typing
* Constructor promotion
* Enum
* Readonly
* Modern language features

## Existing Codebase First

When working in an existing codebase:

* Understand the current architecture before making changes.
* Follow existing conventions.
* Follow framework conventions.
* Follow existing dependency boundaries.

Do not:

* Change architecture without being asked.
* Refactor outside the task scope.
* Change public API without being asked.
* Change framework patterns without being asked.

Prefer:

* Existing patterns.
* Existing conventions.

## Strict Types

Every new file must have:

```php
declare(strict_types=1);
```

Prefer full type declarations.

Do not use `mixed` if the type can be determined.

## Naming

* Class names must be clear.
* Method names must be clear.
* Variable names must be clear.

Do not use:

* `data`
* `value`
* `temp`
* `item`
* `result`

unless the context is truly unambiguous.

## Class Design

* Each class has one primary responsibility.
* Avoid God Classes.
* Avoid giant Utility Classes.
* Avoid Services that do everything.

Prefer:

* High cohesion.
* Clear responsibility.

## Dependency Injection

Prefer Dependency Injection.

Do not:

* Instantiate objects deep inside business logic.
* Use arbitrary service locators.
* Hide dependencies.

Dependencies must be explicit via the constructor.

## Interfaces

Only create an interface when:

* There are multiple implementations.
* There is a real abstraction need.
* The existing architecture requires it.

Do not create interfaces just to create interfaces.

## Controllers

Controllers must be thin.

Controllers should only:

* Validate the request.
* Call a service/use case.
* Return a response.

Do not:

* Contain large business logic.
* Contain complex queries.
* Contain business workflow.

## Business Logic

Business logic must not live in:

* Controllers
* Middleware
* Commands
* Jobs

Business logic should live in:

* Services
* Use Cases
* Domain Layer

following the project's existing architecture.

## Database

Do not:

* Query inside loops.
* N+1 queries.
* Duplicate queries.

Always consider:

* Eager loading.
* Query optimization.
* Transactions.

Validation does not replace database constraints.

## Eloquent / ORM

Prefer:

* Relationships.
* Scopes.
* Query Builder.

Do not:

* Use raw SQL when ORM handles it well.
* Put business logic in models.

Avoid turning models into God Objects.

## Laravel Specific

Follow Laravel conventions.

Prefer:

* Form Requests
* Service Layer (if the project already uses it)
* Resources
* Events
* Jobs

Do not overuse:

* Facades
* Global helpers
* Static methods

## Configuration

Do not hardcode:

* URLs
* API keys
* Tokens
* Credentials
* Feature flags
* Business configuration

Prefer:

* Config files
* Environment variables

## Paths

Do not hardcode:

* Absolute paths
* Machine-specific paths
* Local development paths

Use framework helpers or configuration instead.

## Error Handling

Do not swallow exceptions.

Do not:

```php
catch (\Exception $e) {
}
```

Always:

* Log appropriately.
* Preserve context.
* Handle explicitly.

## Logging

* Log enough context.
* Do not log secrets.
* Do not log tokens.
* Do not log passwords.

Prefer structured logging if the project supports it.

## Validation

Validation must be explicit.

Do not duplicate validation in multiple places.

Prefer:

* Request validation
* DTO validation
* Domain validation

following the project's existing architecture.

## Testing

Prefer:

* PHPUnit
* Pest (if the project uses it)

Test:

* Business behavior
* Business rules
* Edge cases
* Error cases

Do not test implementation details.

## Performance

* Measure before optimizing.
* Profile before optimizing.
* Check query count.
* Check memory usage.

Do not optimize based on intuition.

## Module Boundaries

Respect existing module boundaries.

Do not:

* Import across layers.
* Access internal implementations.
* Create unnecessary dependencies.

Prefer:

* Public contracts.
* Public APIs.

## AI Safety Rules

Before writing code:

* Look for existing implementations.
* Look for similar services.
* Look for similar controllers.
* Look for similar repositories.
* Look for existing patterns.

Prefer reuse.

Do not:

* Hardcode data.
* Hardcode config.
* Hardcode business rules.
* Hardcode permissions.
* Hardcode feature flags.
* Copy-paste logic between modules.

Always prefer:

* Root cause fix.
* Reusable solution.
* Maintainable solution.

## Large Repository Safety

When working in a large codebase:

* Understand the dependency graph before making changes.
* Only modify what is relevant to the task.
* Do not refactor outside the required scope.
* Do not change public API unless asked.
* Warn if a change may affect other modules.

## Completion Checklist

Before completing a task:

* PSR standards followed.
* `strict_types` declared.
* No hardcoded values.
* No duplicate logic.
* No N+1 queries.
* No queries inside loops.
* No module boundary violations.
* Errors handled appropriately.
* Edge cases evaluated.
* Follows existing project patterns.

## Laravel Architecture Preservation

Do not introduce:

* Repository Pattern
* Service Layer
* DTO Layer
* CQRS
* DDD

unless the existing project already uses them
or the task explicitly requires them.
