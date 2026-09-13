# Test Contract — <TASK-ID>

Status: DRAFT

## Test objective

Define the evidence needed to prove the frozen Requirement Contract and Implementation Contract. Do not optimize for test count or coverage percentage.

## Requirement traceability

| Acceptance | Scenario | Layer | Real entry point | Observable assertion | Failure mode | Test location / command |
| --- | --- | --- | --- | --- | --- | --- |
| AC-01 |  |  |  |  |  |  |

## Critical automated journeys

For every critical user-observable journey, identify the production-facing entry that can be exercised deterministically in code.

### J1 — <journey>

- Acceptance criteria:
- Entry point:
- Major boundaries crossed:
- Observable result:
- Why unit/integration tests alone are insufficient:
- Automation mechanism:
- Verification command:

## Pre-implementation executable tests

List tests that can be written before production implementation because their observable contract is already frozen.

Do not force executable pre-implementation tests when doing so requires production scaffolding, implementation-specific coupling, or a test-only architecture change.

| Test | Expected pre-implementation state | Why it is safe to author before implementation |
| --- | --- | --- |
|  | failing / blocked / already passing |  |

## Unit / integration / contract coverage

Add lower-level tests where they give faster diagnosis or prove local invariants. Do not duplicate journey assertions without a reason.

## State, failure, and recovery coverage

Cover applicable invalid input, boundary state, repeated execution, partial failure, retry/recovery, existing-data protection, and cross-component propagation.

## Test oracle authority

For each non-obvious assertion, identify which frozen requirement, plan rule, invariant, external contract, or verified existing behavior defines the expected result.

Tests must not invent missing product behavior. If the oracle cannot be determined from authoritative evidence, record a `PLAN_OR_SPEC_DEFECT` and return to the affected gate.

## Failure Challenge

For each critical acceptance test answer:

> If the corresponding behavior were deliberately broken, would this test reliably fail?

Any `no` or uncertain answer requires strengthening the test or recording why another evidence layer is authoritative.

## Manual / computer-use acceptance

Use only where code automation is unreliable or uneconomical, such as visual layout, OS dialogs, external OAuth, or exploratory UX.

| Check | Why automation is insufficient | Required evidence |
| --- | --- | --- |
|  |  |  |

## False-green risks

Record mocks, fixtures, shortcuts, shared assumptions, implementation-coupled assertions, or bypassed entry paths that could make the suite green while production behavior is wrong.

## Residual unverified risk

State what the test contract still cannot prove.

## Test review status

- Verdict: `PENDING | DELIVERY_FREEZE | REQUEST_CHANGES`
- Reviewed baseline / commit:
- Material findings:
