# Prompt — Test Design

Use only after `PLAN_FROZEN`. This phase designs evidence before production implementation.

```text
Design the Test Contract and concrete test cases from the frozen Requirement Contract, any required frozen Experience Contract, and the Implementation Contract.

Do not redesign product behavior or experience. If an expected result cannot be derived from authoritative frozen contracts or verified external evidence, report PLAN_OR_SPEC_DEFECT instead of inventing a test oracle.

Before authoring tests, confirm task classification and experience status. For experience-sensitive work, a missing/unfrozen Experience Contract is a blocker, not an invitation to create placeholder UI and test it.

For every critical acceptance criterion:
- define the scenario;
- choose the cheapest test layer that still crosses the failure-prone boundary;
- identify the real or production-facing entry point when applicable;
- define the observable assertion;
- identify the failure mode the test is intended to catch;
- record the test location and verification command.

Cover applicable:
- state transitions and boundary states;
- invalid input;
- repeated execution / idempotency;
- partial failure;
- retry or recovery;
- persistence and existing-data protection;
- cross-component propagation;
- product route/debug-route separation;
- required asset/fallback behavior;
- interaction-mode leakage where relevant.

Apply the Failure Challenge:
If the target behavior were deliberately broken, would this test reliably fail?

For visual/UX acceptance also ask:
Does this prove fidelity to the approved target, or only prove that something renders?

Where the observable contract is already frozen and implementation-independent, prefer writing executable tests before production code. It is acceptable for them to fail because behavior is not implemented yet.
Do not force pre-implementation executable tests when that would require production scaffolding, implementation-specific coupling, test-only architecture, or an unapproved placeholder experience.

Classify manual gates explicitly:
- blocking-human: dependent work must stop until explicit PASS;
- nonblocking-human: may remain pending only when the judgment cannot change downstream architecture/product semantics/correctness.

Visual composition, product entry/navigation, interaction feel/discoverability, scene framing, major effect language, and fidelity to approved keyframes/storyboards are blocking by default when downstream work depends on them.

Do not weaken existing tests and do not add duplicate tests without diagnostic value.

When writes are authorized, update the Test Contract and add only justified pre-implementation test code.
```
