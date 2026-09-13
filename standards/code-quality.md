# Code Quality Baseline

This is the cross-project fallback coding standard for projects that do not define an explicit equivalent.

It is intentionally language-agnostic and conservative. It does not replace project-local conventions.

## 1. Precedence

Resolve coding rules in this order:

1. explicit project-local `AGENTS.md`, architecture rules, style guides, and repository configuration;
2. conventions already established consistently in the target codebase;
3. this fallback baseline.

Never rewrite a mature project's conventions merely to match this document.

## 2. Core standard

Code should be:

- correct against the approved contract;
- simple enough to reason about locally;
- consistent with the existing architecture;
- explicit at state, lifecycle, error, and data boundaries;
- easy to test and debug;
- narrow in scope and reversible where practical;
- maintainable without relying on the original author or chat context.

Prefer KISS and YAGNI. Do not optimize for cleverness, abstraction count, or theoretical purity.

## 3. Scope discipline

A change should solve the authorized problem and no larger one.

Do not mix in unrelated cleanup, style migration, broad renaming, speculative extensibility, or architecture replacement.

If a necessary fix materially expands scope, make the expansion explicit and route it through the task's decision gate.

## 4. Ownership and source of truth

Each business rule, state transition, configuration value, or derived fact should have one clear authoritative owner.

Avoid:

- duplicated business logic across layers;
- two mutable sources for the same state;
- shadow caches without explicit invalidation semantics;
- UI, test, or adapter code silently redefining domain rules.

Derived data should remain derived unless there is a demonstrated persistence/performance need and a clear synchronization contract.

## 5. Module boundaries

A module should have a coherent responsibility and a clear reason to change.

Prefer existing boundaries before creating new layers.

Do not create wrappers, managers, services, adapters, factories, helpers, or generic frameworks solely to make a small change appear architecturally uniform.

Introduce an abstraction when it removes real duplication of policy, isolates a real boundary, or makes an otherwise unstable dependency explicit.

## 6. Functions and control flow

Prefer functions that:

- do one coherent thing;
- have explicit inputs and outputs;
- keep side effects visible;
- avoid hidden mutation of distant state;
- make important branches and failure paths readable.

Complexity should be reduced by clarifying responsibilities and state transitions, not by hiding logic behind indirection.

Avoid deeply nested control flow when an early return, extracted domain operation, or explicit state transition makes behavior clearer.

## 7. State and lifecycle

Stateful behavior must make valid states, transitions, ownership, and cleanup/recovery semantics understandable from the code.

Do not rely on undocumented ordering assumptions, implicit initialization, or invisible temporal coupling when they affect correctness.

For asynchronous or event-driven code, make cancellation, repeated execution, stale results, teardown, and race-sensitive ownership explicit where relevant.

## 8. Data and contracts

Treat public interfaces, persisted data, schemas, events, and cross-module payloads as contracts.

Do not silently broaden or change them for implementation convenience.

Validate at meaningful trust boundaries. Avoid repeated validation deep inside already-trusted internal paths unless it protects a distinct invariant.

Prefer explicit types/schemas where the project and language support them.

## 9. Error behavior

Do not swallow errors merely to keep execution moving.

Errors should be handled at the layer that has enough context to recover, translate, retry, or present them meaningfully.

Avoid catch-all fallback behavior unless the contract explicitly defines it.

Logging is not error handling. A logged failure that leaves incorrect state is still a failure.

## 10. Dependencies

Prefer the standard library and existing project dependencies when sufficient.

Add a dependency only when it materially reduces implementation/maintenance risk relative to a small local solution and is compatible with the project's operational constraints.

Do not add a dependency to avoid understanding a small existing subsystem.

## 11. Naming and comments

Follow project-local naming first.

Names should communicate domain meaning and ownership rather than implementation trivia.

Comments should explain non-obvious **why**, constraints, invariants, or external reasons. Do not narrate obvious code.

Do not preserve stale comments or TODOs that contradict current behavior.

## 12. Compatibility and migration

Do not add compatibility layers, dual-write paths, fallback schemas, or migration machinery unless compatibility is an explicit requirement.

When compatibility is required, define the supported old/new states, transition period, rollback behavior, and removal condition.

## 13. Refactoring

Refactor only when needed to make the authorized change correct, understandable, or safely testable, or when separately authorized.

Prefer small refactors with preserved behavior and independent verification.

Do not rewrite working subsystems merely because a cleaner design is imaginable.

## 14. Generated / agent-written code

Agent-generated code is production code unless explicitly marked otherwise.

Do not produce one-off scaffolding, duplicated helpers, placeholder abstractions, or temporary shortcuts that are left behind without ownership/removal criteria.

Before completion, inspect the final diff for:

- accidental duplication;
- dead code;
- stale compatibility paths;
- broadened APIs;
- unnecessary abstractions;
- debug output;
- weakened errors or tests;
- inconsistent naming or ownership.

## 15. Completion standard

Code is not complete because it compiles or tests are green.

Completion requires:

- conformance to the approved behavior and constraints;
- relevant verification evidence;
- no known blocking invariant or lifecycle defect;
- no unexplained scope expansion;
- a final diff that another engineer can reasonably maintain without reconstructing the implementation conversation.
