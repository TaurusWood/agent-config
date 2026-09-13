# Prompt — Test Review

Use when the Test Contract and any pre-implementation test diff are ready for independent review. Do not implement production code.

```text
Independently review whether the proposed tests can prove the frozen Requirement Contract, any required frozen Experience Contract, and the Implementation Contract.

Do not assume green tests imply correct coverage. Do not treat existing tests as authoritative if they conflict with frozen contracts.

Check:
- every critical acceptance criterion maps to meaningful evidence;
- test oracles come from authoritative frozen behavior/experience rather than implementation convenience;
- critical tests would fail when the intended behavior is deliberately broken;
- important state, boundary, failure, and recovery scenarios are represented where applicable;
- mocks, fixtures, shortcuts, or internal-only entry points do not bypass the behavior being proved;
- tests are not coupled to incidental implementation details without need;
- pre-implementation tests are valid and do not require speculative production architecture;
- tests do not silently introduce new product behavior or placeholder UX;
- duplicated coverage has a diagnostic reason;
- every manual gate is classified blocking-human or nonblocking-human;
- experience-sensitive acceptance does not rely only on “something renders” automation;
- visual composition, product entry/navigation, interaction feel/discoverability, scene framing, and major effect-language gates are blocking when downstream work depends on them;
- no pending blocking-human gate is being treated as permission for Goal/Slice progression.

If the test design exposes a requirement, experience, or plan defect, classify it as PLAN_OR_SPEC_DEFECT and route back to the earliest affected gate. Do not fix the product/experience contract inside the test.

Return exactly one verdict:
DELIVERY_FREEZE
REQUEST_CHANGES

DELIVERY_FREEZE means Requirement + required Experience Contract + Plan + Test Contract jointly form the implementation authority boundary.
For REQUEST_CHANGES, report only material findings with evidence, false-green risk, and bounded correction direction.
```
