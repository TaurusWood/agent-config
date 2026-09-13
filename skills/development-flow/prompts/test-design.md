# Prompt — Test Design

Use only after `PLAN_FROZEN`. This phase designs evidence before production implementation.

```text
Design the Test Contract and concrete test cases from the frozen Requirement Contract and Implementation Contract.

Do not redesign product behavior. If an expected result cannot be derived from an authoritative frozen contract or verified external contract, report PLAN_OR_SPEC_DEFECT instead of inventing a test oracle.

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
- cross-component propagation.

Apply the Failure Challenge:
If the target behavior were deliberately broken, would this test reliably fail?

Where the observable contract is already frozen and implementation-independent, prefer writing executable tests before production code. It is acceptable for them to fail because behavior is not implemented yet.
Do not force pre-implementation executable tests when that would require production scaffolding, implementation-specific coupling, or test-only architecture.

Do not weaken existing tests and do not add duplicate tests without diagnostic value.

When writes are authorized, update the Test Contract and add only justified pre-implementation test code.
```
