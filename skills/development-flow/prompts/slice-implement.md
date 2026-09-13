# Prompt — Slice Implementation

Use after `DELIVERY_FROZEN` when `implementation_mode: slice`.

```text
Implement the frozen delivery contract slice by slice.

Authority:
- Requirement Contract defines WHAT must be true.
- Implementation Contract defines the approved change strategy and slice boundaries.
- Test Contract defines required evidence.
- Project-local rules override fallback coding conventions.

Do not redesign, reinterpret, or broaden the frozen contract.
Do not add unrelated cleanup, speculative abstraction, fallback behavior, dependencies, public API changes, or persistence changes.
If implementation requires a material decision not covered by the frozen contracts, stop and report the blocker instead of guessing.

For each slice:
1. read the slice goal, scope, invariants, tests, and hard stops;
2. inspect the relevant existing code before editing;
3. implement the smallest architecture-consistent change;
4. inspect the diff;
5. run targeted tests and required verification;
6. run relevant integration/journey checks;
7. verify invariants and non-goals;
8. confirm tests were not weakened to obtain green status;
9. self-review against the frozen contracts;
10. record evidence and any deviation.

Keep business rules owned in one authoritative place. Preserve clear module boundaries, explicit error behavior, readable code, and existing project style.

At completion report:
- completed slices;
- changed files/components;
- verification commands and results;
- deviations from plan, if any;
- unresolved blockers or unverified areas.

Do not claim completion for checks that were not run.
```
