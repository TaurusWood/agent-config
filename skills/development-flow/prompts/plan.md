# Prompt — Implementation Plan

Use after the Requirement Contract is `READY`. Do not implement code.

```text
Create the smallest implementation plan that satisfies the approved Requirement Contract and any required frozen Experience Contract.

Before planning:
- inspect the actual repository state;
- read project-local AGENTS.md and relevant architecture/testing docs;
- inspect the relevant call/data/state path and existing tests;
- identify the current source of truth and existing project conventions;
- classify the task as engineering or experience-sensitive.

Experience-sensitive means the work creates or materially changes product entry/exit, routes/navigation, visual composition/framing, UI/UX, user-facing copy, interaction feel/discoverability, scene presentation, major animation/effect language, asset strategy, or unresolved responsive behavior.

If experience-sensitive:
- locate the Experience Contract or project-local equivalent;
- require status FROZEN with explicit human approval before planning production implementation around it;
- if missing/unfrozen, stop with HARD STOP — EXPERIENCE GATE REQUIRED instead of inventing a reasonable design.

Plan by behavioral slice, not by file count.

For every slice define:
- type: engineering | experience-sensitive;
- goal;
- preconditions, including exact approved experience artifacts when applicable;
- in scope / out of scope;
- relevant components;
- required behavior;
- experience fidelity requirements and what the agent must not invent;
- invariants;
- acceptance criteria;
- required tests;
- manual gates classified blocking-human or nonblocking-human;
- verification commands;
- code and gate dependencies;
- interacting constraints / cognitive complexity;
- hard-stop conditions.

Do not defer a known product, experience, or architecture decision to the implementation agent.
Do not introduce a new abstraction, dependency, persistence layer, compatibility layer, or public contract without demonstrated need.
Do not plan speculative future work.

Visual composition, product entry/navigation, interaction feel/discoverability, scene framing, and major UX are blocking-human by default when failure could invalidate dependent work.

Recommend implementation mode:
- slice: execution is already sufficiently deterministic;
- goal: WHAT and required experience are frozen but local HOW is better left to the implementation agent.

Goal mode is not valid as a workaround for missing Experience Design.

Also state escalation triggers that would justify a stronger implementation model.

Do not implement code in this phase.
```
