---
name: development-flow
description: Govern non-trivial software work across multiple chats, agents, and roles using repository-persisted task contracts, workflow state, verification gates, and review evidence. Use when starting, continuing, testing, implementing, or reviewing a task that must remain consistent across sessions or agents, especially when the repository contains .agent/tasks or the user asks to follow the standard development flow.
license: MIT
metadata:
  version: "0.1.0"
---

# Agent Development Flow

Use this skill to make the repository, rather than chat memory, the source of truth for a software task's current phase, approved contracts, execution evidence, and next action.

The user's explicit instructions take precedence over this skill. Project-specific `AGENTS.md` and architecture rules remain authoritative for project-local constraints.

## Core model

Separate three sources of truth:

1. **Engineering protocol** — this skill defines how work moves through phases and gates.
2. **Project rules** — the target repository defines how that project is structured and engineered.
3. **Task packet** — `.agent/tasks/<task-id>/` defines what the current task means and where it is in the flow.

Do not use chat history as the only durable source for an approved decision or task status.

## Start or resume a task

For non-trivial work:

1. Read the target repository's `AGENTS.md` and directly relevant project documentation.
2. Resolve the task ID. If an existing task packet is referenced, use it. Do not create a second task for the same work.
3. Read `.agent/tasks/<task-id>/state.yaml` first, then the artifacts required by its current phase.
4. Inspect the actual repository state, branch, diff, code, and tests needed to verify that the persisted state is not stale.
5. Read `references/workflow.md` and follow the gate for the current phase.
6. Perform only work authorized by the current phase and user request.
7. Before finishing, update durable task artifacts and `state.yaml` with evidence, blockers, and the next action when repository writes are authorized.

If no task packet exists and the user is beginning a non-trivial task that needs this flow, bootstrap it from the templates in `assets/`. Keep the first version minimal; do not fill unknown decisions by guessing.

## Phase routing

Use `state.yaml.phase` to decide what to load and do:

- `DRAFT` → clarify and audit the requirement using `assets/requirement.md`.
- `REQUIREMENT_READY` → create or audit the implementation plan using `assets/implementation-plan.md`.
- `PLAN_READY` → create the test contract using `assets/test-contract.md`.
- `TEST_READY` or `IMPLEMENTING` → implement slices and run slice gates.
- `IMPLEMENTATION_READY` or `REVIEWING` → perform independent code review using `assets/review.md`.
- `ACCEPTANCE` → run remaining acceptance evidence, including manual or computer-use checks only where automation is unsuitable.
- `DONE` → do not reopen implementation unless new scope or a defect creates a new task or explicitly reopens this one.
- `BLOCKED` → resolve the recorded blocker before advancing the flow.

A checkpoint is not automatically a human approval point. If a gate is green and no material decision is required, continue when the user's instruction authorizes continued execution.

## Verification rule

For each critical user-observable acceptance criterion, prefer at least one automated test that enters through the production-facing entry point for that behavior and crosses the important component boundaries. Examples include viewport/input for a game, Playwright for a web journey, an HTTP request through the real router for an API, a subprocess invocation for a CLI, or the public pipeline with realistic fixtures for file processing.

Do not equate “real entry” with computer use. Computer use or manual acceptance belongs at the final layer for behavior that cannot be verified reliably and economically in code, such as visual layout, OS dialogs, third-party OAuth, or exploratory UX checks.

## Hard stops

Do not silently make a new material product or architecture decision merely to keep execution moving. Stop the current direction and record a blocker when continuing requires one of the following:

- contradictory approved requirements or contracts;
- breaking an explicit non-goal or invariant;
- changing an unapproved user-observable behavior;
- adding a major architecture layer, database, public API, permission model, or dependency not covered by the plan;
- an unplanned incompatible schema or persistence migration;
- an irreversible or security-sensitive decision without authority;
- a slice expanding enough that the implementation plan is probably wrong;
- a critical external fact that cannot be verified and would otherwise have to be guessed.

Ordinary implementation defects, lint failures, compile failures, local test failures caused by the change, and small in-scope corrections are not hard stops.

## Completion

Never report a phase complete only because code was written or tests are green. A phase is complete only when its gate in `references/workflow.md` is satisfied and the task packet contains enough durable evidence for another chat or agent to resume without reconstructing decisions from conversation history.
