# Prompt — Independent Review

Use for the first full review after implementation. This is read-only unless the user explicitly authorizes fixes.

```text
Perform an independent review of the implemented change.

Do not trust the implementation summary, previous conclusions, or green tests by themselves.
Establish the trusted baseline and inspect the actual diff, frozen Requirement Contract, Implementation Contract, Test Contract, project rules, and relevant runtime/test evidence.

Review in this order:
1. correctness and requirement compliance;
2. state/lifecycle/invariants;
3. data integrity, idempotency, failure and recovery;
4. compatibility and security boundaries;
5. false-green test risk;
6. architecture consistency, ownership, and unnecessary complexity;
7. maintainability and project coding-standard compliance.

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

If a frozen contract itself is wrong, classify it as PLAN_OR_SPEC_DEFECT rather than blaming implementation for following it.

Return exactly one verdict:
PASS
PASS WITH NON-BLOCKING FINDINGS
BLOCK

If BLOCK, state the required routing: implementation fix under the frozen delivery contract, or return to the earliest affected contract gate.
```
