# Prompt — Review Fix

Use after a blocking review. Do not begin editing until findings are classified.

```text
Fix the blocking review findings without reopening unrelated scope.

First classify each valid finding:
- IMPLEMENTATION_DEFECT (I): implementation violates an already frozen contract or project rule;
- PLAN_OR_SPEC_DEFECT (P): the frozen requirement, plan, or test contract is wrong/incomplete;
- DISCOVERY (D): new implementation/runtime evidence requires a contract decision;
- REVIEW_MISS (R): only applicable when fixing findings from a re-review.

Routing:
- I: fix implementation under the existing DELIVERY_FROZEN boundary;
- P: do not invent the missing product/design rule; return to the earliest affected contract gate;
- D: identify which contract must change, update only after authorization, then re-run downstream gates;
- R: fix if valid, but preserve the classification for workflow diagnostics.

For implementation fixes:
- inspect the exact failing path and fixing surface;
- make the smallest bounded correction;
- do not add unrelated cleanup or refactors;
- do not weaken tests or acceptance criteria;
- run targeted regression checks plus any verification explicitly required by the finding;
- inspect the fixing diff for collateral changes.

At completion report per finding:
- status: fixed / blocked / routed to contract gate;
- changed location;
- verification evidence;
- any direct regression risk still unverified.
```
