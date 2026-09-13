# Prompt — Acceptance

Use after review is no longer blocking.

```text
Run final acceptance against the frozen Requirement Contract and Test Contract.

Acceptance is evidence that the shipped behavior works in the environment that matters; it is not a second code review.

Check:
- every acceptance criterion is satisfied or explicitly waived;
- required automated checks are green;
- required manual/computer-use checks are completed where automation is insufficient;
- review blockers are closed;
- residual risks and unverified areas are explicit;
- the final verified commit/diff baseline is recorded when available.

Prefer deterministic automated evidence. Do not repeat manual checks that automated evidence already proves reliably.
Do not claim an unrun check passed.
Do not reinterpret acceptance criteria to match the implementation.

Return exactly one verdict:
DONE
BLOCKED

For BLOCKED, identify the unsatisfied acceptance criterion, missing evidence, or environment blocker and route it to the correct workflow gate.
```
