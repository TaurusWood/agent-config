---
name: development-flow
description: Govern non-trivial software work across multiple chats, agents, and roles using repository-persisted task contracts, staged freezes, test design/review, implementation routing, verification gates, and review evidence. Use when starting, continuing, testing, implementing, or reviewing a task that must remain consistent across sessions or agents, especially when the repository contains .agent/tasks or the user asks to follow the standard development flow.
license: MIT
metadata:
  version: "0.2.0"
---

# Agent Development Flow

Use this skill to make the repository, rather than chat memory, the source of truth for a software task's current phase, approved contracts, freeze status, execution evidence, and next action.

The user's explicit instructions take precedence over this skill. Project-specific `AGENTS.md`, architecture rules, code standards, and test rules remain authoritative for project-local constraints.

## Core model

Separate four sources of truth:

1. **Engineering protocol** — this skill defines how work moves through phases, reviews, freezes, and gates.
2. **Project rules** — the target repository defines how that project is structured and engineered.
3. **Fallback standards** — when the project has no explicit code or testing standard, use this configuration repository's baseline standards.
4. **Task packet** — `.agent/tasks/<task-id>/` defines what the current task means and where it is in the flow.

Do not use chat history as the only durable source for an approved decision or task status.

## Start or resume a task

For non-trivial work:

1. Read the target repository's `AGENTS.md` and directly relevant project documentation.
2. Resolve the task ID. If an existing task packet is referenced, use it. Do not create a second task for the same work.
3. Read `.agent/tasks/<task-id>/state.yaml` first, then the artifacts required by its current phase.
4. Inspect the actual repository state, branch, diff, code, and tests needed to verify that the persisted state is not stale.
5. Read `references/workflow.md` and follow the gate for the current phase.
6. Read the phase-specific prompt in `prompts/` when one exists.
7. Perform only work authorized by the current phase, freeze status, implementation mode, and user request.
8. Before finishing, update durable task artifacts and `state.yaml` with evidence, blockers, and the next action when repository writes are authorized.

If no task packet exists and the user is beginning a non-trivial task that needs this flow, bootstrap it from the templates in `assets/`. Keep the first version minimal; do not fill unknown decisions by guessing.

## Phase routing

Use `state.yaml.phase` to decide what to load and do:

- `DRAFT` → author the Requirement Contract with `prompts/requirement.md`, then independently audit it with `prompts/requirement-audit.md` and `assets/requirement.md`.
- `REQUIREMENT_READY` → create the implementation plan using `assets/implementation-plan.md` and `prompts/plan.md`.
- `PLAN_READY` → independently audit the plan using `prompts/plan-audit.md`.
- `PLAN_FROZEN` → design the test contract and concrete test cases using `assets/test-contract.md` and `prompts/test-design.md`.
- `TEST_READY` → independently review the test design using `prompts/test-review.md`.
- `DELIVERY_FROZEN` → choose `slice` or `goal` implementation mode and begin implementation with the matching prompt.
- `IMPLEMENTING` → continue the selected execution mode and run implementation checkpoints.
- `IMPLEMENTATION_READY` → perform independent review using `prompts/independent-review.md` and `assets/review.md`.
- `REVIEWING` → classify findings, fix only authorized scope with `prompts/fix.md`, then use `prompts/re-review.md` for closure.
- `ACCEPTANCE` → run remaining acceptance evidence using `prompts/acceptance.md`.
- `DONE` → do not reopen implementation unless new scope or a defect creates a new task or explicitly reopens this one.
- `BLOCKED` → resolve the recorded blocker before advancing the flow.

A checkpoint is not automatically a human approval point. If a gate is green and no material decision is required, continue when the user's instruction authorizes continued execution.

## Freeze rules

### PLAN FREEZE

`PLAN_FROZEN` means the Requirement Contract and Implementation Contract form an approved design baseline.

Test design may challenge this baseline. It must not silently rewrite product behavior, architecture constraints, invariants, scope, or acceptance criteria. A material problem found during test design or test review is a `PLAN_OR_SPEC_DEFECT` and returns the task to the earliest affected gate.

### DELIVERY FREEZE

`DELIVERY_FROZEN` means the Requirement Contract, Implementation Contract, and Test Contract jointly define the implementation authority boundary.

Implementation may choose how to execute within the authorized mode, but must not silently redefine what the system should do or what constitutes acceptance.

## Implementation modes

### Slice execution

Use `prompts/slice-implement.md` when the plan already defines low-discretion behavioral slices. Execute the contract; do not redesign it.

This is the default mode for lower-cost implementation agents when semantic complexity is low enough.

### Goal execution

Use `prompts/goal-implement.md` when the goal, constraints, external behavior, and tests are frozen but prescribing every local implementation step would add more overhead than value.

Goal mode gives freedom over **how**, not **what**. It does not authorize scope expansion or material architecture changes.

Record the selected mode in `state.yaml`.

## Test rule

Test design and test review are separate from implementation.

For each critical user-observable acceptance criterion, prefer at least one automated test that enters through the production-facing entry point for that behavior and crosses the important component boundaries. Examples include viewport/input for a game, Playwright for a web journey, an HTTP request through the real router for an API, a subprocess invocation for a CLI, or the public pipeline with realistic fixtures for file processing.

Where practical, write executable pre-implementation tests for frozen observable behavior. Do not force pre-implementation executable tests when doing so would require production scaffolding or implementation-specific coupling.

For critical tests apply the Failure Challenge: if the target behavior were deliberately broken, the test should reliably fail.

Do not equate “real entry” with computer use. Computer use or manual acceptance belongs at the final layer for behavior that cannot be verified reliably and economically in code, such as visual layout, OS dialogs, third-party OAuth, or exploratory UX checks.

## Standards inheritance

When implementing or reviewing code, resolve standards in this order:

1. explicit project-local rules and project `AGENTS.md`;
2. language/framework conventions already established in the project;
3. fallback standards from `../../standards/code-quality.md` and `../../standards/testing.md`.

Do not impose the fallback baseline when the target project has an explicit conflicting convention.

The fallback baseline should preserve KISS, single ownership of business rules, clear module boundaries, explicit error behavior, minimal scope, readable code, and tests that prove behavior rather than implementation details.

## Hard stops

Do not silently make a new material product or architecture decision merely to keep execution moving. Stop the current direction and record a blocker when continuing requires one of the following:

- contradictory approved requirements or frozen contracts;
- breaking an explicit non-goal or invariant;
- changing an unapproved user-observable behavior;
- adding a major architecture layer, database, public API, permission model, or dependency not covered by the plan;
- an unplanned incompatible schema or persistence migration;
- an irreversible or security-sensitive decision without authority;
- a slice expanding enough that the implementation plan is probably wrong;
- a critical external fact that cannot be verified and would otherwise have to be guessed.

Ordinary implementation defects, lint failures, compile failures, local test failures caused by the change, and small in-scope corrections are not hard stops.

## Review rules

Independent review and re-review are different operations.

- **Independent review** re-establishes correctness from the trusted baseline, frozen contracts, actual diff, tests, and project rules.
- **Re-review** primarily checks previous finding closure, the fixing diff, direct regressions, and required evidence. It is not a fresh invitation to reopen unrelated design space.

Classify material findings by origin:

- `IMPLEMENTATION_DEFECT` (`I`)
- `PLAN_OR_SPEC_DEFECT` (`P`)
- `REVIEW_MISS` (`R`)
- `DISCOVERY` (`D`)

Severity is tracked separately from origin.

## Completion

Never report a phase complete only because code was written or tests are green. A phase is complete only when its gate in `references/workflow.md` is satisfied and the task packet contains enough durable evidence for another chat or agent to resume without reconstructing decisions from conversation history.
