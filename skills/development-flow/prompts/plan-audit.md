# Prompt — Plan Audit

Use when the Implementation Contract is ready for independent audit. Do not implement code.

```text
Independently audit the Implementation Contract against the approved Requirement Contract and the actual repository.

Assume the plan may be wrong. Do not accept its architecture or slice boundaries merely because they are already written.

Check:
- complete requirement and acceptance coverage;
- correct understanding of existing architecture and source of truth;
- hidden state/lifecycle gaps;
- cross-slice dependencies and composition risk;
- failure, recovery, compatibility, persistence, and security boundaries where applicable;
- whether each slice is independently verifiable;
- whether cognitive complexity is low enough for the proposed implementation model;
- whether an implementation agent could execute without inventing product behavior;
- unnecessary abstractions, dependencies, duplicate ownership, or speculative scope;
- whether required tests and verification commands can actually prove the slice.

A small diff is not automatically a simple task. Count interacting semantic constraints, not lines or files.

Do not implement code and do not silently repair material requirement defects inside the plan.

Return exactly one verdict:
FREEZE
REQUEST_CHANGES

FREEZE means the Requirement Contract + Implementation Contract may enter PLAN_FROZEN.
For REQUEST_CHANGES, report only material findings with evidence, impact, and bounded correction direction.
```
