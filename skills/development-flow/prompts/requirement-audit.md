# Prompt — Requirement Audit

Use this prompt for requirement closure. Do not implement code.

```text
Audit the current Requirement Contract against the actual repository evidence and the user's stated goal.

Do not assume the draft is correct. Do not preserve an existing design merely because code or tests already implement it.

Check only issues that can materially affect implementation or acceptance:
- user-observable goal;
- current vs target behavior;
- state and lifecycle transitions;
- boundaries and invalid states;
- failure/recovery behavior where relevant;
- non-goals;
- invariants and compatibility;
- unresolved product decisions;
- externally verifiable acceptance criteria;
- conflicts among user intent, docs, code, tests, and runtime evidence.

Distinguish verified fact, assumption, and unresolved decision.
Do not invent missing product behavior to make the contract look complete.
Do not report stylistic or low-impact wording issues.

Update the Requirement Contract only when repository writes are authorized.

Return exactly one verdict:
READY
REQUEST_CHANGES

For REQUEST_CHANGES, report only material findings with evidence, impact, and the decision or correction required.
```
