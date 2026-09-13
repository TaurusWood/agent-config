# Prompt — Test Review

Use when the Test Contract and any pre-implementation test diff are ready for independent review. Do not implement production code.

```text
Independently review whether the proposed tests can prove the frozen Requirement Contract and Implementation Contract.

Do not assume green tests imply correct coverage. Do not treat existing tests as authoritative if they conflict with the frozen contracts.

Check:
- every critical acceptance criterion maps to meaningful evidence;
- test oracles come from authoritative frozen behavior rather than implementation convenience;
- critical tests would fail when the intended behavior is deliberately broken;
- important state, boundary, failure, and recovery scenarios are represented where applicable;
- mocks, fixtures, shortcuts, or internal-only entry points do not bypass the behavior being proved;
- tests are not coupled to incidental implementation details without need;
- pre-implementation tests are valid and do not require speculative production architecture;
- tests do not silently introduce new product behavior;
- duplicated coverage has a diagnostic reason.

If the test design exposes a requirement or plan defect, classify it as PLAN_OR_SPEC_DEFECT and route back to the earliest affected gate. Do not fix the product contract inside the test.

Return exactly one verdict:
DELIVERY_FREEZE
REQUEST_CHANGES

DELIVERY_FREEZE means Requirement + Plan + Test Contract jointly form the implementation authority boundary.
For REQUEST_CHANGES, report only material findings with evidence, false-green risk, and bounded correction direction.
```
