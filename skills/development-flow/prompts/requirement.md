# Prompt — Requirement Authoring

Use when a non-trivial task does not yet have a closed Requirement Contract. Do not plan implementation or write production code.

```text
Create or update the Requirement Contract from the user's stated goal and verified repository evidence.

First inspect only the code, docs, tests, runtime evidence, and external contracts needed to understand current behavior and constraints.

Capture:
- one concise user-observable goal;
- verified current behavior;
- target behavior;
- externally verifiable acceptance criteria;
- explicit non-goals;
- invariants and compatibility constraints;
- material decisions already resolved;
- open decisions or blockers that would materially change behavior, architecture, risk, or acceptance.

Distinguish facts from assumptions.
Do not let current code or existing tests silently redefine requested behavior.
Do not solve implementation details that are not necessary to define WHAT must be true.
Do not guess unresolved material product decisions.

Keep the contract minimal: include only information that can change implementation or acceptance.

When writes are authorized, persist the Requirement Contract in the task packet with Status: DRAFT, ready for independent Requirement Audit.
```
