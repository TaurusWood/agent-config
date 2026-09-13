# Prompt — Independent Review

Use for the first full review after implementation. This is read-only unless the user explicitly authorizes fixes.

```text
Perform an independent review of the implemented change.

Do not trust the implementation summary, previous conclusions, or green tests by themselves.
Establish the trusted baseline and inspect the actual diff, frozen Requirement Contract, required frozen Experience Contract, Implementation Contract, Test Contract, project rules, and relevant runtime/test evidence.

Review in this order:
1. correctness and requirement compliance;
2. experience fidelity for user-visible work: route/entry behavior, composition/framing, UI/UX hierarchy, interaction feel/discoverability, asset strategy, and match to approved keyframes/storyboards;
3. state/lifecycle/invariants;
4. data integrity, idempotency, failure and recovery;
5. compatibility and security boundaries;
6. false-green test risk, including automation that proves only “something renders” while the experience target is unmet;
7. architecture consistency, ownership, and unnecessary complexity;
8. maintainability and project coding-standard compliance;
9. gate integrity: no dependent slice progressed across a pending/failed blocking-human gate.

For experience-sensitive work, determine whether any user-visible decision was invented by the implementation agent rather than derived from frozen authority. Treat that as material even if automated tests pass.

Only report material findings with a concrete trigger/evidence path.
Do not report unrelated historical debt, pure style preference, or speculative risk without a plausible path.

For every finding record:
- severity;
- origin: IMPLEMENTATION_DEFECT (I), PLAN_OR_SPEC_DEFECT (P), or DISCOVERY (D);
- location;
- contract/evidence;
- actual behavior;
- failure scenario;
- impact;
- bounded correction direction.

Do not use REVIEW_MISS in the first independent review; that classification exists for later re-review.

If implementation failed to reproduce an approved experience target, classify IMPLEMENTATION_DEFECT.
If the approved experience target itself is insufficient/wrong, classify PLAN_OR_SPEC_DEFECT and route back to the Experience Gate rather than polishing code arbitrarily.

Return exactly one verdict:
PASS
PASS WITH NON-BLOCKING FINDINGS
BLOCK

If BLOCK, state the required routing: implementation fix under the frozen delivery contract, or return to the earliest affected requirement/experience/plan/test gate.
```
