# Code Review — <TASK-ID>

Status: DRAFT

## Review type

Use exactly one:

- `INDEPENDENT_REVIEW`
- `RE_REVIEW`

## Review baseline

- Target branch:
- Merge base / trusted commit:
- Reviewed head:
- Requirement contract version / commit:
- Implementation contract version / commit:
- Test contract version / commit:
- Plan freeze evidence:
- Delivery freeze evidence:
- Previous review / findings reviewed during re-review:

## Contract verification

Summarize whether the observed behavior and diff satisfy the frozen requirement, implementation, and test contracts.

For re-review, do not perform a fresh full audit unless a new material defect or contract change requires it. Focus on finding closure, fixing diff, direct regressions, and missing evidence.

## Findings

### <severity> / <origin> — <title>

- Location:
- Contract / evidence:
- Actual behavior:
- Failure scenario:
- Impact:
- Recommended correction:

`origin` must be one of:

- `IMPLEMENTATION_DEFECT` (`I`)
- `PLAN_OR_SPEC_DEFECT` (`P`)
- `REVIEW_MISS` (`R`)
- `DISCOVERY` (`D`)

Severity and origin are separate dimensions.

If there are no findings, write `None`.

## Previous finding closure

Required for `RE_REVIEW`.

| Finding | Closure evidence | Fixing diff | Regression check | Status |
| --- | --- | --- | --- | --- |
|  |  |  |  | closed / open |

## Test false-green assessment

State whether critical acceptance criteria are exercised through meaningful boundaries and identify any tests that can pass while the real behavior is broken.

## Architecture and complexity assessment

Record only material deviations: duplicate sources of truth, unnecessary abstractions, unplanned dependencies, excessive scope, unclear ownership, or project-rule violations.

## Residual risks / unverified areas

List remaining uncertainty even when the verdict is PASS.

## Verdict

Use exactly one:

- PASS
- PASS WITH NON-BLOCKING FINDINGS
- BLOCK

If `BLOCK`, state the required routing:

- implementation fix under frozen delivery contract;
- return to requirement / plan / test gate;
- discovery-driven contract update.
