# Implementation Contract — <TASK-ID>

Status: DRAFT

## Relevant architecture

Describe only the existing components, boundaries, and call/data/state paths needed for this task.

## Source of truth

State where authoritative state and decisions live. Avoid duplicate ownership across layers.

## Change strategy

Describe the smallest architecture-consistent approach that satisfies the Requirement Contract.

## Explicit constraints

List decisions the implementation agent must not reinterpret, including dependency, schema, compatibility, persistence, error, lifecycle, security, and public-contract rules.

## Implementation mode recommendation

Use one when the plan is ready:

- `slice` — low-discretion behavioral slices; execute the contract step by step.
- `goal` — frozen behavior with a bounded implementation search space; the agent may choose local HOW but not redefine WHAT.

Recommended mode:
Reason:
Escalation triggers:

## Slice plan

### S1 — <behavioral goal>

**Goal**

**Preconditions**

**In scope**

**Out of scope**

**Relevant files/components**

**Required behavior**

**Invariants**

**Acceptance criteria**

**Required tests**

**Verification commands**

**Dependencies**

**Cognitive complexity / interacting constraints**

Record the state, lifecycle, contract, or cross-module invariants that must hold simultaneously. Do not use file count or line count as a proxy for task simplicity.

**Hard-stop conditions**

## Cross-slice dependencies

Record any ordering, shared state, migration, or contract dependency that can make individually correct slices fail when composed.

## Full verification

List the change-level checks required after all slices complete.

## Known risks

Record only risks that could change implementation or acceptance decisions.

## Plan audit status

- Verdict: `PENDING | FREEZE | REQUEST_CHANGES`
- Reviewed baseline / commit:
- Material findings:
