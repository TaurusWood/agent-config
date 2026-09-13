# Test Contract — <TASK-ID>

Status: DRAFT

## Test objective

Define evidence needed to prove the frozen Requirement Contract and, when applicable, the frozen Experience Contract.

## Preconditions

- Requirement Contract status:
- Experience Contract status: not_required | FROZEN | BLOCKED
- Approved keyframe/storyboard/IA version, if applicable:

If Experience Contract is required but not frozen, stop instead of inventing acceptance targets.

## Requirement traceability

| Acceptance | Scenario | Layer | Real entry point | Observable assertion | Failure mode | Gate | Test location / command |
| --- | --- | --- | --- | --- | --- | --- | --- |
| AC-01 |  |  |  |  |  | automated / blocking-human / nonblocking-human |  |

## Critical automated journeys

For every critical user-observable journey, identify the production-facing entry that can be exercised deterministically.

### J1 — <journey>

- Acceptance criteria:
- Entry point:
- Major boundaries crossed:
- Observable result:
- Why lower-level tests are insufficient:
- Automation mechanism:
- Verification command:

## Unit / integration / contract coverage

Add lower-level tests where they improve diagnosis or prove local invariants.

## Failure and recovery coverage

Cover invalid input, boundaries, repeated execution, partial failure, retry/recovery, existing-data protection, and cross-component propagation where applicable.

## Failure Challenge

For each critical automated test:

> If the corresponding behavior were deliberately broken, would this test reliably fail?

For visual/UX acceptance also ask:

> Does this prove fidelity to an approved target, or merely prove that something renders?

## Manual / computer-use acceptance

Manual does not mean optional.

| Check | Gate | Why automation is insufficient | Required evidence | Dependency blocked until PASS |
| --- | --- | --- | --- | --- |
|  | blocking-human / nonblocking-human |  |  |  |

Use `blocking-human` by default for visual composition, product IA, interaction feel/discoverability, major motion/effect language, responsive framing, and keyframe fidelity.

An agent cannot self-approve a blocking human gate.

## False-green risks

Record mocks, fixtures, shortcuts, bypassed entry paths, missing experience artifacts, or other assumptions that could make tests green while production behavior is wrong.

## Goal Mode stop rule

If a blocking human gate is `PENDING` or `FAIL`, dependent slices must not begin even when automated tests are green.

## Residual unverified risk

State what the contract still cannot prove.
