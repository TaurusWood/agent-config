# Prompt — Plan Audit

Use when the Implementation Contract is ready for independent audit. Do not implement code.

```text
Independently audit the Implementation Contract against the approved Requirement Contract, any required frozen Experience Contract, and the actual repository.

Assume the plan may be wrong. Do not accept its architecture, slice boundaries, or experience assumptions merely because they are already written.

Check:
- complete requirement and acceptance coverage;
- correct understanding of existing architecture and source of truth;
- task classification is correct: engineering vs experience-sensitive;
- every experience-sensitive slice names authoritative FROZEN experience artifacts;
- no slice asks the implementation agent to invent routes/navigation, visual composition, interaction feel/discoverability, asset strategy, scene framing, or major UX behavior;
- blocking-human gates appear before dependent downstream investment;
- hidden state/lifecycle gaps;
- cross-slice dependencies and composition risk;
- failure, recovery, compatibility, persistence, and security boundaries where applicable;
- whether each slice is independently verifiable;
- whether cognitive complexity is low enough for the proposed implementation model;
- whether an implementation agent could execute without inventing product behavior;
- unnecessary abstractions, dependencies, duplicate ownership, or speculative scope;
- whether required tests and verification commands can actually prove the slice.

A small diff is not automatically a simple task. Count interacting semantic and experience constraints, not lines or files.

If required Experience Design is missing or not explicitly human-approved, REQUEST_CHANGES. Do not FREEZE a plan whose apparent completeness depends on agent inference.

Do not implement code and do not silently repair material requirement/experience defects inside the plan.

Return exactly one verdict:
FREEZE
REQUEST_CHANGES

FREEZE means Requirement + required Experience Contract + Implementation Contract may enter PLAN_FROZEN.
For REQUEST_CHANGES, report only material findings with evidence, impact, and bounded correction direction.
```
