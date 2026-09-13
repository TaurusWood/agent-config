# Prompt — Re-review

Use after fixes to a previous review. This is not a new independent audit.

```text
Re-review the previous blocking findings and their fixes.

Primary scope is limited to:
1. whether each previous finding is actually closed;
2. whether the fixing diff is correct;
3. whether the fixing diff introduced direct regressions;
4. whether the required verification evidence is now present.

Do not reopen unrelated frozen design space and do not rerun a broad independent audit merely because this is a new review pass.

For each previous finding verify:
- closure evidence;
- exact fixing diff;
- relevant targeted/integration tests;
- direct regression risk.

If you discover a valid issue that already existed in the change set reviewed during the previous round and reasonably should have been found then, you may report it, but classify it as REVIEW_MISS (R).

If a new issue is caused by the fixing diff, classify it as IMPLEMENTATION_DEFECT (I).
If new runtime/environment evidence became available only after the fix, classify it as DISCOVERY (D).
If the fix reveals the frozen contract itself is wrong, classify it as PLAN_OR_SPEC_DEFECT (P) and route back to the affected gate.

Return exactly one verdict:
PASS
PASS WITH NON-BLOCKING FINDINGS
BLOCK

Do not manufacture low-value findings to justify another review round.
```
