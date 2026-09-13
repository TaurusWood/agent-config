# Test Contract — <TASK-ID>

Status: DRAFT

## Test objective

Define the evidence needed to prove the frozen Requirement Contract, approved Experience Contract when required, and Implementation Contract. Do not optimize for test count or coverage percentage.

Automation can prove deterministic behavior; it cannot create visual/UX approval that has never occurred.

## Experience authority check

Task classification: `engineering | experience-sensitive`
Experience Contract: `N/A | <path>`
Experience status: `NOT_REQUIRED | DRAFT | REVIEW | FROZEN | BLOCKED`

If the task is experience-sensitive and the target is not `FROZEN`, stop test finalization with `PLAN_OR_SPEC_DEFECT` / `HARD STOP — EXPERIENCE GATE REQUIRED`. Tests must not invent the missing product experience.

## Requirement traceability

| Acceptance | Scenario | Layer | Real entry point | Observable assertion | Failure mode | Test location / command |
| --- | --- | --- | --- | --- | --- | --- |
| AC-01 |  |  |  |  |  |  |

For visual/UX criteria, distinguish “page/scene renders” from “matches the approved experience target.” The former is not sufficient acceptance evidence for the latter.

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

Do not author final visual/interaction acceptance tests against an agent-created placeholder before the experience target is approved.

| Test | Expected pre-implementation state | Why it is safe to author before implementation |
| --- | --- | --- |
|  | failing / blocked / already passing |  |

## Unit / integration / contract coverage

Add lower-level tests where they give faster diagnosis or prove local invariants. Do not duplicate journey assertions without a reason.

## State, failure, and recovery coverage

Cover applicable invalid input, boundary state, repeated execution, partial failure, retry/recovery, existing-data protection, and cross-component propagation.

For experience-sensitive work, include relevant negative paths such as unapproved debug routes becoming product navigation, missing required assets silently falling back, or interaction modes leaking across approved variants.

## Test oracle authority

For each non-obvious assertion, identify which frozen requirement, approved Experience Contract, plan rule, invariant, external contract, or verified existing behavior defines the expected result.

Tests must not invent missing product behavior. If the oracle cannot be determined from authoritative evidence, record a `PLAN_OR_SPEC_DEFECT` and return to the affected gate.

## Failure Challenge

For each critical acceptance test answer:

> If the corresponding behavior were deliberately broken, would this test reliably fail?

Any `no` or uncertain answer requires strengthening the test or recording why another evidence layer is authoritative.

For visual/UX acceptance also ask:

> Does this evidence prove fidelity to the approved target, or merely that something renders?

## Manual / computer-use acceptance

Manual checks must be classified by gate semantics, not merely listed as optional residual QA.

- `blocking-human` — explicit human PASS is required before dependent implementation may proceed. Use by default for visual composition, product entry/navigation, interaction feel/discoverability, scene framing, major motion/effect language, and fidelity to an approved keyframe/storyboard.
- `nonblocking-human` — may remain pending only when the unresolved judgment cannot change downstream architecture, product semantics, or correctness.

| Check | Gate | Why automation is insufficient | Required evidence | Dependent work blocked until PASS |
| --- | --- | --- | --- | --- |
|  | blocking-human / nonblocking-human |  |  |  |

`PENDING HUMAN REVIEW` is not a pass. A pending blocking-human gate stops dependent slices and Goal Mode progression.

## False-green risks

Record mocks, fixtures, shortcuts, shared assumptions, implementation-coupled assertions, bypassed entry paths, or automation-only evidence that could make the suite green while production behavior is wrong or visually unacceptable.

## Residual unverified risk

State what the test contract still cannot prove.

## Test review status

- Verdict: `PENDING | DELIVERY_FREEZE | REQUEST_CHANGES`
- Reviewed baseline / commit:
- Experience gate checked: `YES | N/A`
- Blocking-human gates classified: `YES | N/A`
- Material findings:
