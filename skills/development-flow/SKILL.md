---
name: development-flow
description: Govern non-trivial software and experience-driven product work across chats and agents using repository-persisted contracts, explicit experience gates, implementation slices, verification gates, and review evidence. Use when work must remain consistent across sessions or agents, especially when visual/UX/interaction decisions must not be invented by coding agents.
license: MIT
metadata:
  version: "0.2.0"
---

# Agent Development Flow

Use this skill to make the repository, rather than chat memory, the source of truth for requirement, experience, plan, test, implementation, review, and acceptance state.

The user's explicit instructions take precedence. Project-specific `AGENTS.md` and project contracts remain authoritative for local constraints.

## Core model

Keep four concerns distinct:

1. **Engineering protocol** — this skill defines phases and gates.
2. **Project rules** — the target repository defines architecture/coding constraints.
3. **Experience authority** — when work changes visual/UX/route/interaction behavior, approved experience artifacts define what the user should actually see and feel.
4. **Task packet** — `.agent/tasks/<task-id>/` records task-specific contracts, state, evidence, and next action.

Do not use chat history as the only durable source for an approved decision.

## Classify the task before planning

Every non-trivial task must be classified:

- `engineering` — user-visible behavior is already defined; work is primarily logic, infrastructure, data, API, performance, refactor, or implementation of frozen behavior;
- `experience` — work creates or materially changes visual composition, UX, routes/navigation, interaction feel/discoverability, animation language, visual assets, or product copy;
- `hybrid` — both are material.

If classification is `experience` or `hybrid`, the task must pass the Experience Gate before dependent implementation planning is considered ready.

A capable model being able to invent a plausible design is not permission to do so.

## Start or resume a task

For non-trivial work:

1. Read project rules and directly relevant documents.
2. Resolve the task ID and existing task packet if present.
3. Read `state.yaml` first.
4. Reconcile recorded branch/commit with actual repository state.
5. Read `references/workflow.md` and load artifacts required by the current phase.
6. Perform only work authorized by the current phase and user request.
7. Persist decisions, evidence, blockers, and next action before finishing when writes are authorized.

If no packet exists, bootstrap from `assets/` without guessing unknown decisions.

## Phase routing

Use `state.yaml.phase`:

- `DRAFT` → close requirement using `assets/requirement.md`.
- `REQUIREMENT_READY` → if experience/hybrid, create/audit `experience-contract.md`; otherwise create/audit implementation plan.
- `EXPERIENCE_DRAFT` → explore options cheaply; do not implement production experience.
- `EXPERIENCE_REVIEW` → present concrete keyframes/storyboards/IA/asset strategy for human approval.
- `EXPERIENCE_READY` → architecture/implementation planning may proceed.
- `PLAN_READY` → create/audit test contract.
- `TEST_READY` or `IMPLEMENTING` → implement slices and run slice gates.
- `IMPLEMENTATION_READY` or `REVIEWING` → independent code review.
- `ACCEPTANCE` → remaining automated and manual acceptance.
- `DONE` → do not reopen without new scope/defect.
- `BLOCKED` → resolve the recorded blocker before advancing.

## Experience Gate

Experience work is ready only when the repository contains an approved target sufficient for an implementation agent to execute without inventing product decisions.

Depending on the task, this includes:

- route/entry/exit IA;
- approved visual reference/keyframe;
- composition/framing;
- interaction storyboard;
- discoverability behavior;
- asset strategy;
- responsive behavior;
- user-facing copy where material;
- explicit human approval.

Use `assets/experience-contract.md`.

Human approval of Experience FREEZE is a **blocking human gate**. An agent cannot self-approve it.

## Verification rule

For critical user-observable acceptance criteria, prefer automated evidence through the production-facing entry point when deterministic automation can prove the behavior.

But automation cannot establish aesthetic or perceptual approval. Screenshot tests can protect an approved visual state from regression; they cannot decide whether the original state is acceptable.

Classify manual gates as:

- `blocking-human` — dependent work must stop until PASS;
- `nonblocking-human` — explicitly safe to defer because the decision cannot change downstream semantics/architecture.

Visual composition, product IA, interaction feel/discoverability, major animation language, and keyframe fidelity are blocking by default.

## Hard stops

Stop and record a blocker when continuing requires:

- contradictory approved requirements/contracts;
- breaking a non-goal/invariant;
- changing unapproved user-observable behavior;
- inventing visual composition, route/navigation, interaction feel, product copy, or asset strategy without an approved Experience Contract;
- proceeding past a pending/failed `blocking-human` gate;
- adding a major architecture layer/database/public API/permission model/dependency not covered by plan;
- incompatible schema/persistence migration not planned;
- irreversible/security-sensitive decision without authority;
- a slice expanding enough that the plan is probably wrong;
- a critical external fact that cannot be verified.

Ordinary compile/lint/test failures and small in-scope corrections are not hard stops.

## Goal Mode

Goal Mode may autonomously chain **Engineering Slices** when their dependency gates are satisfied.

Goal Mode must not cross an Experience Gate or pending blocking human gate.

Required stop format:

```text
HARD STOP — EXPERIENCE GATE REQUIRED
Current phase/slice:
Pending decision/gate:
Evidence prepared for human review:
Dependent work that must not begin:
Safe independent work remaining, if any:
```

Throughput does not override product uncertainty.

## Completion

Never report a phase complete merely because code exists or tests are green.

A phase is complete only when its gate in `references/workflow.md` is satisfied and another agent can resume from durable repository evidence without reconstructing decisions from chat history.
