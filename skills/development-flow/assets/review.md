# Code Review — <TASK-ID>

Status: DRAFT

## Review baseline

- Target branch:
- Merge base / trusted commit:
- Reviewed head:
- Requirement contract version / commit:
- Implementation contract version / commit:
- Test contract version / commit:

## Contract verification

Summarize whether the observed behavior and diff satisfy the approved requirement, implementation, and test contracts.

## Findings

### <severity> — <title>

- Location:
- Contract / evidence:
- Actual behavior:
- Failure scenario:
- Impact:
- Recommended correction:

If there are no findings, write `None`.

## Test false-green assessment

State whether critical acceptance criteria are exercised through meaningful boundaries and identify any tests that can pass while the real behavior is broken.

## Architecture and complexity assessment

Record only material deviations: duplicate sources of truth, unnecessary abstractions, unplanned dependencies, excessive scope, or project-rule violations.

## Residual risks / unverified areas

List remaining uncertainty even when the verdict is PASS.

## Verdict

Use exactly one:

- PASS
- PASS WITH NON-BLOCKING FINDINGS
- BLOCK
