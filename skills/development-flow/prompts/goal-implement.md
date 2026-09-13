# Prompt — Goal Implementation

Use after `DELIVERY_FROZEN` when `implementation_mode: goal`.

```text
Complete the frozen implementation goal end to end.

The delivery boundary is fixed:
- Requirement Contract defines WHAT must be true.
- Implementation Contract defines material architecture constraints, invariants, scope, and prohibited decisions.
- Test Contract defines required evidence and acceptance.
- Project-local rules override fallback coding conventions.

You may choose local HOW inside that boundary:
- implementation order;
- local function/module structure;
- small architecture-consistent refactors required by the goal;
- debugging and verification sequence.

You may not change:
- user-observable behavior;
- acceptance criteria;
- non-goals;
- public contracts;
- persistence or schema semantics;
- security/permission boundaries;
- material architecture decisions;
- dependencies not authorized by the plan.

Work in a closed execution loop:
inspect relevant code → form a local plan → implement → run targeted verification → inspect failures/diff → correct → re-run verification → self-review against frozen contracts.

Prefer the smallest maintainable solution. Keep KISS, clear module ownership, one source of truth for business rules, explicit error behavior, and project consistency.

If new evidence invalidates a frozen assumption or requires a material decision, stop and report the exact contract/gate that must be reopened. Do not reinterpret the goal to keep moving.

At completion report:
- what changed;
- important local implementation decisions;
- verification commands and results;
- any deviation from the approved plan;
- unresolved blockers or unverified areas.

Do not claim completion for checks that were not run.
```
