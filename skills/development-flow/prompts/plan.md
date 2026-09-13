# Prompt — Implementation Plan

Use after the Requirement Contract is `READY`. Do not implement code.

```text
Create the smallest implementation plan that satisfies the approved Requirement Contract.

Before planning:
- inspect the actual repository state;
- read project-local AGENTS.md and relevant architecture/testing docs;
- inspect the relevant call/data/state path and existing tests;
- identify the current source of truth and existing project conventions.

Plan by behavioral slice, not by file count.

For every slice define:
- goal;
- preconditions;
- in scope / out of scope;
- relevant components;
- required behavior;
- invariants;
- acceptance criteria;
- required tests;
- verification commands;
- dependencies;
- interacting constraints / cognitive complexity;
- hard-stop conditions.

Do not defer a known product decision to the implementation agent.
Do not introduce a new abstraction, dependency, persistence layer, compatibility layer, or public contract without demonstrated need.
Do not plan speculative future work.

Recommend implementation mode:
- slice: execution is already sufficiently deterministic;
- goal: WHAT is frozen but local HOW is better left to the implementation agent.

Also state escalation triggers that would justify a stronger implementation model.

Do not implement code in this phase.
```
