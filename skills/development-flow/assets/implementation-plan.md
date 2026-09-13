# Implementation Contract — <TASK-ID>

Status: DRAFT

## Task classification

Classify the task before planning:

- `engineering` — user-visible behavior is already frozen or the task is non-experiential;
- `experience-sensitive` — work creates or materially changes product entry, routes/navigation, visual composition, UI/UX, user-facing copy, interaction feel/discoverability, scene framing, major animation/effect language, or asset strategy.

Classification:
Reason:

If `experience-sensitive`, identify the Experience Contract and its status. Do not plan production implementation around unresolved visual/UX decisions.

Experience Contract:
Experience status: `NOT_REQUIRED | DRAFT | REVIEW | FROZEN | BLOCKED`
Blocking human approval evidence:

## Relevant architecture

Describe only the existing components, boundaries, and call/data/state paths needed for this task.

## Source of truth

State where authoritative state and decisions live. Avoid duplicate ownership across layers.

For experience-sensitive work, include the approved experience artifact as a higher-level source of truth than implementation convenience.

## Change strategy

Describe the smallest architecture-consistent approach that satisfies the Requirement Contract and, when applicable, reproduces the approved Experience Contract.

Do not use technical convenience to choose the product experience.

## Explicit constraints

List decisions the implementation agent must not reinterpret, including dependency, schema, compatibility, persistence, error, lifecycle, security, public-contract, route/navigation, visual, interaction, and asset-strategy rules where applicable.

## Implementation mode recommendation

Use one when the plan is ready:

- `slice` — low-discretion behavioral slices; execute the contract step by step.
- `goal` — frozen behavior with a bounded implementation search space; the agent may choose local HOW but not redefine WHAT.

Recommended mode:
Reason:
Escalation triggers:

Goal mode is not appropriate as a way to bypass unresolved Experience Design or blocking-human gates.

## Slice plan

### S1 — <behavioral goal>

**Type**

`engineering | experience-sensitive`

**Goal**

**Preconditions**

For experience-sensitive slices, name the exact frozen Experience Contract/keyframe/storyboard/IA artifact required before implementation.

**In scope**

**Out of scope**

**Relevant files/components**

**Required behavior**

**Experience fidelity requirements**

For experience-sensitive slices, state what must match the approved target and what the coding agent must not invent. Otherwise write `N/A`.

**Invariants**

**Acceptance criteria**

**Required tests**

**Manual gates**

Classify every manual gate as:

- `blocking-human` — dependent work must stop until explicit PASS;
- `nonblocking-human` — may remain pending only when it cannot change downstream architecture/product semantics.

Visual composition, route/entry/exit IA, interaction feel/discoverability, scene framing, and major UX are blocking by default.

**Verification commands**

**Dependencies**

Include both code dependencies and gate dependencies.

**Cognitive complexity / interacting constraints**

Record the state, lifecycle, contract, experience, or cross-module invariants that must hold simultaneously. Do not use file count or line count as a proxy for task simplicity.

**Hard-stop conditions**

Include `HARD STOP — EXPERIENCE GATE REQUIRED` whenever continuing would require the agent to invent a material user-visible decision or cross a pending blocking-human gate.

## Cross-slice dependencies

Record any ordering, shared state, migration, contract, experience, or human-gate dependency that can make individually correct slices fail when composed.

Do not allow a later slice to depend on an experience-sensitive slice whose blocking gate is still pending.

## Full verification

List the change-level checks required after all slices complete, including required human acceptance evidence.

## Known risks

Record only risks that could change implementation or acceptance decisions.

## Plan audit status

- Verdict: `PENDING | FREEZE | REQUEST_CHANGES`
- Reviewed baseline / commit:
- Experience gate status checked: `YES | N/A`
- Material findings:
