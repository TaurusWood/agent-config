# Prompt — Slice Implementation

Use after `DELIVERY_FROZEN` when `implementation_mode: slice`.

```text
Implement the frozen delivery contract slice by slice.

Authority:
- Requirement Contract defines WHAT must be true.
- Experience Contract, when required, defines the approved user-visible target.
- Implementation Contract defines the approved change strategy and slice boundaries.
- Test Contract defines required evidence and human gates.
- Project-local rules override fallback coding conventions.

Do not redesign, reinterpret, or broaden the frozen contract.
Do not add unrelated cleanup, speculative abstraction, fallback behavior, dependencies, public API changes, persistence changes, or unapproved user-visible decisions.
If implementation requires a material decision not covered by the frozen contracts, stop and report the blocker instead of guessing.

For each slice:
1. read the slice type, goal, scope, invariants, tests, gate dependencies, and hard stops;
2. if experience-sensitive, verify the required Experience Contract/keyframe/storyboard/IA artifact is FROZEN;
3. verify every prerequisite blocking-human gate is PASS;
4. inspect relevant existing code before editing;
5. implement the smallest architecture-consistent change that reproduces the frozen target;
6. inspect the diff;
7. run targeted tests and required verification;
8. run relevant integration/journey checks;
9. verify invariants and non-goals;
10. confirm tests were not weakened to obtain green status;
11. self-review against all frozen contracts;
12. evaluate current-slice manual gates and record evidence.

Never continue to a dependent slice while a required blocking-human gate is PENDING or FAIL.

If a gate is pending, stop with:

HARD STOP — BLOCKING HUMAN GATE
Slice:
Gate:
Status: PENDING | FAIL
Evidence ready for human review:
Dependent work that must not begin:

If required experience authority is missing, stop with:

HARD STOP — EXPERIENCE GATE REQUIRED
Slice:
Missing decision/artifact:
Why implementation cannot safely continue:

Keep business rules owned in one authoritative place. Preserve clear module boundaries, explicit error behavior, readable code, existing project style, and approved experience fidelity.

At completion report:
- completed slices;
- changed files/components;
- verification commands and results;
- blocking-human gate results;
- deviations from plan, if any;
- unresolved blockers or unverified areas.

Do not claim completion for checks that were not run or human gates that were not explicitly approved.
```
