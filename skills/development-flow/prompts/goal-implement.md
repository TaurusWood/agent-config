# Prompt — Goal Implementation

Use after `DELIVERY_FROZEN` when `implementation_mode: goal`.

```text
Complete the frozen implementation goal end to end.

The delivery boundary is fixed:
- Requirement Contract defines WHAT must be true.
- Experience Contract, when required, defines the approved user-visible target.
- Implementation Contract defines material architecture constraints, invariants, scope, and prohibited decisions.
- Test Contract defines required evidence and acceptance.
- Project-local rules override fallback coding conventions.

Before editing, classify the task and every planned slice/checkpoint:
- Engineering: behavior/experience is already frozen; work is mainly logic, data, infrastructure, performance, integration, or faithful implementation of an approved target.
- Experience-sensitive: work creates or materially changes product entry, routes/navigation, visual composition, UI/UX, user-facing copy, interaction feel/discoverability, scene framing, major animation/effect language, or asset strategy.

For experience-sensitive work, verify that the required Experience Contract is FROZEN and that all prerequisite blocking-human gates are PASS. If not, stop. Goal mode never authorizes you to invent the missing experience or to treat PENDING HUMAN REVIEW as permission to continue dependent work.

You may choose local HOW inside the frozen boundary:
- implementation order;
- local function/module structure;
- small architecture-consistent refactors required by the goal;
- debugging and verification sequence.

You may not change or invent:
- user-observable behavior;
- product entry, routes, or navigation not already approved;
- visual composition, framing, palette, asset strategy, or major effects not already approved;
- interaction discovery/feel not already approved;
- acceptance criteria;
- non-goals;
- public contracts;
- persistence or schema semantics;
- security/permission boundaries;
- material architecture decisions;
- dependencies not authorized by the plan.

Work in a closed execution loop for each slice/checkpoint:
inspect frozen contracts → inspect relevant code → form a local plan → implement → run targeted verification → inspect failures/diff → correct → re-run verification → self-review against frozen contracts → evaluate manual gates.

Do not batch dependent slices across an unresolved blocking gate. A checkpoint is complete only when its automated checks pass and every prerequisite blocking-human gate is PASS.

Prefer the smallest maintainable solution. Keep KISS, clear module ownership, one source of truth for business rules, explicit error behavior, and project consistency.

If new evidence invalidates a frozen assumption or requires a material decision, stop and report the exact contract/gate that must be reopened. Do not reinterpret the goal to keep moving.

Use this stop format when experience authority is missing:

HARD STOP — EXPERIENCE GATE REQUIRED
Current slice/checkpoint:
Missing or pending decision/gate:
Why dependent implementation cannot safely continue:
Evidence/artifact ready for human review:
Safe engineering work that remains independent, if any:

At completion report:
- completed slices/checkpoints and commit/evidence where available;
- what changed;
- important local implementation decisions;
- verification commands and results;
- blocking-human gate results;
- any deviation from the approved plan;
- unresolved blockers or unverified areas.

Do not claim completion for checks that were not run or human gates that were not explicitly approved.
```
