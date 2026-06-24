# React Development Guidelines

## Core Principles

* Follow the project's existing code style.
* Prioritize readability.
* Prioritize maintainability.
* Prioritize consistency.
* Simplest solution that works.
* No premature optimization.
* No over-engineering.

## Existing Codebase First

When working in an existing codebase:

* Understand current patterns before making changes.
* Follow existing conventions.
* Follow existing directory structure.
* Follow existing state management.
* Follow existing data fetching patterns.

Do not:

* Change architecture without being asked.
* Change state management without being asked.
* Change UI framework without being asked.
* Refactor outside the task scope.

Prefer:

* Consistency over personal preference.
* Existing patterns over new ones.

## Component Design

* A component should have one primary responsibility.
* Components must be readable.
* Components must be testable.
* Components must be reusable.

Avoid:

* God Components.
* Overly long components.
* Components handling too much business logic.

If a component becomes complex:

* Split into smaller components.
* Or extract logic into a custom hook.

## State Management

Prefer in this order:

1. Local State
2. Lift State Up
3. Context
4. Global State

Do not promote state to global if local state is sufficient.

Do not create global state just to share with a few components.

## State Ownership

State should live as close to where it is used as possible.

Do not:

* Duplicate state.
* Mirror state unnecessarily.
* Copy props into state without a clear reason.

## Hooks

Follow the Rules of Hooks.

Do not:

* Call hooks inside conditions.
* Call hooks inside loops.
* Call hooks inside nested functions.

## useEffect Rules

Do not use `useEffect` for:

* Derived state.
* Simple data transformation.
* Simple computation.
* Unnecessary state synchronization.

Before writing a `useEffect`, ask:

* Is this truly a side effect?
* Can this be solved with state or props?

Prefer eliminating `useEffect` when not needed.

## Custom Hooks

Only create a custom hook when:

* Logic is reused.
* Logic is complex enough.

Do not create a custom hook for trivial logic.

Do not create a hook just to wrap a few lines of code.

## Data Fetching

Prefer the existing data fetching solution in the project.

If the project uses:

* TanStack Query
* React Query
* SWR

Continue using it.

Do not write your own:

* Cache layer
* Retry mechanism
* Loading manager

If the framework already provides it.

## API Layer

Do not call the API directly from multiple components.

Prefer:

* API client
* Service layer
* Query layer

Separate:

* UI
* Fetching
* Business logic

## Business Logic

Do not embed complex business logic in components.

Prefer:

* Services
* Utilities
* Custom hooks

Components should focus on rendering.

## Forms

Prefer the project's existing form pattern.

Do not:

* Write your own form framework.
* Duplicate validation logic.

Validation should include:

* Client side
* Server side

## Performance

Do not use:

* `useMemo`
* `useCallback`
* `memo`

By default.

Only use when:

* There is a real measured problem.
* Profiling confirms it.

Do not memoize everything.

## Rendering

Avoid:

* Unnecessary re-renders.
* Heavy computation during render.
* Complex inline objects.
* Complex inline functions.

Prefer readable code first.

## Component Communication

Prefer:

* Props
* Context
* State Management

Do not use:

* Arbitrary event buses.
* Shared mutable state.
* Unnecessary global singletons.

## Module Boundaries

Respect existing module boundaries.

Do not:

* Import across layers.
* Import internal implementations.
* Access private modules.

Prefer:

* Public APIs.
* Shared contracts.

## Imports

* Follow existing conventions.
* Do not create circular dependencies.
* Do not import from deep internal paths if the project already has a public export.

Avoid:

```ts
import "../../../../../feature/internal/component"
```

Prefer:

```ts
import { UserCard } from "@/features/user"
```

## Styling

Follow the existing solution:

* Tailwind
* CSS Modules
* Styled Components
* Emotion

Do not mix multiple styling strategies.

Do not create a new strategy unless necessary.

## Error Handling

Every async operation must have:

* Error handling
* Loading state

Do not:

* Ignore errors
* Silent failure

## UX Rules

Every screen should handle:

* Loading state
* Error state
* Empty state

Do not assume data always exists.

## Accessibility

Prefer:

* Semantic HTML
* Accessible form labels
* Keyboard navigation

Do not sacrifice accessibility for development speed.

## Testing

Test:

* User behavior
* Business behavior
* User interaction

Do not test:

* Internal implementation
* Hook internals
* State internals

Prefer:

* React Testing Library

## AI Safety Rules

Before modifying code:

* Look for existing patterns.
* Look for similar components.
* Look for similar hooks.
* Look for similar services.

Prefer reuse.

Do not:

* Hardcode data.
* Hardcode API responses.
* Hardcode business rules.
* Hardcode role permissions.
* Hardcode feature flags.
* Copy-paste logic between components.

## Large Repository Safety

When working in a monorepo or large codebase:

* Understand the dependency graph before making changes.
* Only modify what is relevant to the task.
* Do not refactor outside the required scope.
* Do not change public API unless asked.
* Warn if a change may affect other modules.

## Completion Checklist

Before completing a task:

* No redundant state.
* No unnecessary `useEffect`.
* No duplicate logic.
* No hardcoded values.
* No circular dependencies.
* No module boundary violations.
* Appropriate loading state.
* Appropriate error state.
* Edge cases evaluated.
* Follows existing project patterns.

## Framework Features First

Before introducing custom solutions:

* Check whether React already provides it.
* Check whether Next.js already provides it.
* Check whether the existing project already provides it.

Prefer framework-native solutions over custom abstractions.
