# Test Contract — <TASK-ID>

Status: DRAFT

## Test objective

Define the evidence needed to prove the Requirement Contract, not a target number of tests or coverage percentage.

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

## Unit / integration / contract coverage

Add lower-level tests where they give faster diagnosis or prove local invariants. Do not duplicate journey assertions without a reason.

## Failure and recovery coverage

Cover applicable invalid input, boundary state, repeated execution, partial failure, retry/recovery, existing-data protection, and cross-component propagation.

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

Record mocks, fixtures, shortcuts, shared assumptions, or bypassed entry paths that could make the suite green while production behavior is wrong.

## Residual unverified risk

State what the test contract still cannot prove.
