# Development Flow Protocol v0.1

This document defines the durable workflow used by the `development-flow` skill. It is intentionally small enough to apply across projects; project-specific rules stay in the target repository.

## 1. Task packet

A task that needs cross-session continuity should use:

```text
.agent/tasks/<task-id>/
├── state.yaml
├── requirement.md
├── implementation-plan.md
├── test-contract.md
└── review.md
```

Not every file must exist in `DRAFT`, but files required by a completed gate must exist before advancing.

`state.yaml` is the routing index, not a substitute for the contracts. It records phase, ownership, slice status, evidence pointers, blockers, and next action.

## 2. State machine

Normal path:

```text
DRAFT
  → REQUIREMENT_READY
  → PLAN_READY
  → TEST_READY
  → IMPLEMENTING
  → IMPLEMENTATION_READY
  → REVIEWING
  → ACCEPTANCE
  → DONE
```

Any active phase may move to `BLOCKED` when a hard stop is reached. After the blocker is explicitly resolved, return to the phase whose gate must be re-evaluated.

Do not skip a gate merely because a capable model could infer the missing decisions.

## 3. Requirement gate

Advance to `REQUIREMENT_READY` only when:

- the user-observable goal is explicit;
- current and target behavior are distinguished;
- acceptance criteria are externally verifiable;
- important non-goals are explicit;
- invariants and compatibility constraints are recorded;
- material product decisions are resolved;
- remaining assumptions are low-impact and reversible.

If code, tests, docs, and user intent disagree, record the conflict. Do not let current code or existing tests silently redefine the requested behavior.

## 4. Planning gate

Advance to `PLAN_READY` only when:

- the relevant existing architecture and call/data/state path were inspected;
- source of truth is explicit;
- changes are minimal and consistent with the project;
- new abstractions or dependencies have demonstrated need;
- work is split into independently verifiable slices;
- each slice has goal, scope, invariants, acceptance criteria, required tests, verification commands, dependencies, and hard-stop conditions;
- the plan does not defer a known business decision to the implementation agent.

A slice is a behavioral unit, not a file-count or line-count target.

## 5. Test gate

Advance to `TEST_READY` only when every critical acceptance criterion maps to convincing evidence.

Use the cheapest test layer that can prove the behavior without bypassing the failure-prone boundary:

1. static checks — syntax, lint, type, build;
2. unit tests — algorithms, pure functions, local invariants;
3. integration/contract tests — module boundaries, schemas, state transitions, persistence contracts;
4. automated journey/smoke tests — production-facing entry through the important component path;
5. manual/computer-use acceptance — visual, OS, third-party, or exploratory behavior that is not reliable or economical to automate.

Critical user journeys should not be proven only through unit tests when the actual defect could occur between components.

For each critical test ask a Failure Challenge: **if the acceptance criterion were deliberately broken, would this test reliably fail?** If not, it is not sufficient acceptance evidence.

Mock only where isolation is necessary. Do not mock away the boundary the test exists to verify.

## 6. Implementation gate

During `IMPLEMENTING`, execute slices in dependency order unless the plan explicitly allows parallel work.

After every slice run a checkpoint:

1. inspect the resulting diff;
2. run targeted tests;
3. run relevant integration or journey tests;
4. verify slice acceptance criteria;
5. verify invariants and non-goals;
6. confirm no duplicate source of truth or unplanned architecture was introduced;
7. confirm tests were not weakened to obtain green status;
8. record evidence and slice status.

A green checkpoint may proceed automatically when the user's instruction authorizes completing the task and no hard stop is present.

Advance to `IMPLEMENTATION_READY` only when all planned slices are complete and the full change-level verification appropriate to the risk is green or explicitly documented as unavailable.

## 7. Review gate

Review against the trusted pre-change baseline, normally `merge-base(target, HEAD)` for a branch review.

Review in this order:

1. correctness and requirement compliance;
2. state/lifecycle/invariants;
3. data integrity, idempotency, failure and recovery behavior;
4. compatibility and security boundaries;
5. false-green test risk;
6. architecture consistency and unnecessary complexity;
7. maintainability.

Do not use modified requirement documents in the same untrusted change set as sole evidence that the implementation is correct.

Review outcomes:

- `PASS` → advance to `ACCEPTANCE` when acceptance evidence remains, otherwise `DONE`.
- `PASS_WITH_NON_BLOCKING_FINDINGS` → same transition, with findings recorded.
- `BLOCK` → record findings and return to the required earlier phase or `BLOCKED` if a material decision is needed.

## 8. Acceptance gate

Acceptance answers whether the shipped behavior is demonstrated in the environment that matters.

Prefer deterministic automated evidence. Add manual or computer-use checks only for residual behavior that automation cannot prove well.

Advance to `DONE` only when:

- all acceptance criteria are satisfied or explicitly waived by the user;
- required automated checks are green;
- required manual/computer-use checks are complete;
- blocking review findings are resolved;
- residual risks and unverified areas are documented;
- `state.yaml` points to the final verified commit or equivalent durable evidence when available.

## 9. Cross-chat handoff

A new agent or chat should be able to resume by reading project rules and the task packet.

Before ending an active phase, persist:

- current phase;
- completed and pending slices;
- decisions that changed a contract;
- verification commands and outcomes;
- relevant commit SHA or diff baseline when known;
- blockers;
- exact next role and action.

Do not store a long conversation transcript. Persist decisions and evidence, not discussion history.

## 10. State reconciliation

Repository state can move outside this workflow. Therefore `state.yaml` is not blindly authoritative about facts such as current commit or test status.

On resume:

1. compare the recorded branch/commit with the actual repository;
2. inspect relevant diff and working tree state;
3. re-run only the checks needed to establish a trustworthy baseline;
4. update stale state before making further transitions.

When a task packet conflicts with explicit new user instructions, follow the user and update the task packet so later agents do not inherit stale intent.
