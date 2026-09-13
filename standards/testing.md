# Testing Baseline

This is the cross-project fallback testing standard for projects that do not define an explicit equivalent.

Project-local test rules, architecture constraints, and repository tooling take precedence.

## 1. Purpose

Tests exist to provide convincing evidence that required behavior and invariants hold and regressions are detected.

Do not optimize for test count, raw coverage percentage, snapshot volume, or framework sophistication.

## 2. Traceability

Every critical acceptance criterion should map to at least one meaningful evidence path.

A useful test should make clear:

- what behavior or invariant it proves;
- which boundary it exercises;
- what observable result is asserted;
- which defect would make it fail.

Tests must not become an independent source of product behavior. Their expected results should come from approved requirements, external contracts, verified invariants, or intentionally preserved behavior.

## 3. Choose the right layer

Use the cheapest layer that can prove the behavior without bypassing the likely failure boundary:

1. static checks for syntax, types, lint, or build constraints;
2. unit tests for pure logic and local invariants;
3. integration/contract tests for module, schema, persistence, state, or service boundaries;
4. automated journey/smoke tests for critical production-facing flows;
5. manual/computer-use acceptance only when deterministic automation is unreliable or uneconomical.

Do not prove a cross-component failure mode only with a unit test that bypasses the boundary where the defect can occur.

## 4. Failure Challenge

For every critical test ask:

> If the required behavior were deliberately broken, would this test reliably fail for the right reason?

If the answer is no or uncertain, strengthen the test or identify the evidence layer that is actually authoritative.

A green test that can remain green while production behavior is broken is false confidence.

## 5. Observable assertions

Prefer assertions on externally meaningful state, output, events, persisted data, API contracts, or user-visible results.

Avoid assertions that merely mirror internal implementation structure unless that structure itself is an intentional contract.

Do not overuse snapshots for logic where explicit assertions communicate the contract more clearly.

## 6. Determinism

Tests should be deterministic enough that failure is actionable.

Control time, randomness, ordering, external dependencies, and concurrency where needed, but do not mock away the behavior under test.

If a test is intentionally probabilistic or environment-sensitive, document why and how to interpret failure.

## 7. Fixtures and mocks

Use the smallest realistic fixture that preserves the relevant contract.

Mocks are appropriate for isolation from expensive, nondeterministic, unavailable, or independently-owned dependencies.

Do not mock the exact integration boundary that the test is supposed to prove.

Avoid fixtures that encode impossible production states unless the test explicitly verifies defensive behavior against corrupted input.

## 8. State, lifecycle, and repeated execution

For stateful behavior, test applicable:

- initial state;
- valid transitions;
- invalid transitions;
- repeated operations / idempotency;
- stale or late results;
- cancellation or teardown;
- partial failure;
- retry/recovery;
- existing-data protection.

Do not test every combinatorial permutation; cover the transitions and boundaries that materially change correctness.

## 9. Regression tests

For a real defect, prefer evidence of:

```text
failure reproduced before fix
→ bounded fix
→ same scenario passes after fix
```

A regression test should target the defect mechanism or externally observable failure, not merely the exact code shape of the fix.

## 10. Pre-implementation tests

When requirements and observable behavior are already frozen, executable tests may be written before production implementation.

This is useful when the test can express the contract without depending on speculative implementation structure.

Do not force test-first code when it requires production scaffolding, unnatural seams, or implementation-specific assertions merely to make the test executable early.

## 11. Test independence and cleanup

Tests should not depend on execution order unless the ordered sequence is itself the subject under test.

Clean up mutable global, filesystem, database, process, or external state that can leak between tests.

Parallel tests must not share writable state without explicit coordination.

## 12. Error-path testing

Test failure behavior when failure semantics materially affect correctness, data integrity, user behavior, or recovery.

Do not add low-value tests for every defensive branch if the branch cannot plausibly affect the required behavior.

## 13. Do not weaken the suite to get green

Never make a failing change pass by:

- deleting or skipping valid tests;
- lowering assertions;
- broadening tolerated output;
- replacing real boundaries with mocks;
- changing acceptance criteria inside the test;
- swallowing errors;

unless evidence shows the previous test/contract itself was wrong and the appropriate specification gate has been reopened.

## 14. Verification reporting

Report exactly what was run and what was not.

Distinguish:

- lint/static checks;
- typecheck;
- unit tests;
- integration/contract tests;
- journey/smoke tests;
- build;
- manual acceptance;
- environment blockers;
- pre-existing failures.

Do not summarize all of these as simply “tests passed.”

## 15. Completion standard

A test change is complete when:

- critical acceptance criteria have convincing evidence;
- important false-green paths have been considered;
- test oracles have authoritative sources;
- the suite remains proportionate and maintainable;
- verification results are reproducible enough for another agent or engineer to re-run.
