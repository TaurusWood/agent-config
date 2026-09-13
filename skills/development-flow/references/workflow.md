# Development Flow Protocol v0.2

This document defines the durable workflow used by the `development-flow` skill. It is intentionally small enough to apply across projects; project-specific rules stay in the target repository.

The workflow separates specification closure, test design, implementation, and review so that defects can be attributed to the correct stage instead of being discovered through an unbounded sequence of code-review rounds.

## 1. Task packet

A task that needs cross-session continuity should use:

```text
.agent/tasks/<task-id>/
├── state.yaml
├── requirement.md
├── implementation-plan.md
├── test-contract.md
└── review.md
```

Not every file must exist in `DRAFT`, but files required by a completed gate must exist before advancing.

`state.yaml` is the routing index, not a substitute for the contracts. It records phase, implementation mode, contract status, slice status, evidence pointers, blockers, and next action.

## 2. State machine

Normal path:

```text
DRAFT
  → REQUIREMENT_READY
  → PLAN_READY
  → PLAN_FROZEN
  → TEST_READY
  → DELIVERY_FROZEN
  → IMPLEMENTING
  → IMPLEMENTATION_READY
  → REVIEWING
  → ACCEPTANCE
  → DONE
```

Any active phase may move to `BLOCKED` when a hard stop is reached. After the blocker is explicitly resolved, return to the earliest phase whose gate must be re-evaluated.

Do not skip a gate merely because a capable model could infer missing decisions.

The two freeze points have different meanings:

- **PLAN_FROZEN** — the requirement and implementation plan form an approved design baseline. Test design may challenge this baseline, but must not silently rewrite it.
- **DELIVERY_FROZEN** — requirement, implementation plan, and test contract form the implementation authority boundary. Implementation may choose how to execute within that boundary, but must not redefine observable behavior, acceptance criteria, or material architecture constraints.

## 3. Requirement gate

Advance to `REQUIREMENT_READY` only when:

- the user-observable goal is explicit;
- current and target behavior are distinguished;
- acceptance criteria are externally verifiable;
- important non-goals are explicit;
- invariants and compatibility constraints are recorded;
- material product decisions are resolved;
- remaining assumptions are low-impact and reversible.

If code, tests, docs, and user intent disagree, record the conflict. Do not let current code or existing tests silently redefine the requested behavior.

A requirement audit should challenge the requirement itself, not merely proofread it.

## 4. Planning gate

Create an implementation plan only after inspecting the relevant architecture, call/data/state paths, project rules, and current repository state.

Advance to `PLAN_READY` when the plan is ready for independent audit and:

- the source of truth is explicit;
- changes are minimal and architecture-consistent;
- new abstractions or dependencies have demonstrated need;
- work is split into behavioral slices rather than file-count targets;
- each slice has goal, scope, invariants, acceptance criteria, required tests, verification commands, dependencies, and hard-stop conditions;
- the plan does not defer a known product or architecture decision to the implementation agent.

A slice can be small in code volume and still be cognitively complex. Planning must account for the number of state, lifecycle, contract, or cross-module invariants that must hold simultaneously.

## 5. Plan audit and PLAN FREEZE

The plan audit is independent from plan authoring. Treat the plan as potentially wrong.

Check at minimum:

- complete requirement coverage;
- hidden state or lifecycle gaps;
- cross-slice dependencies;
- failure, recovery, compatibility, and persistence boundaries;
- whether acceptance criteria are implementable and testable;
- whether a lower-cost implementation agent can execute each slice without inventing product behavior;
- whether the plan introduces unnecessary architecture or duplicates an existing source of truth.

If the audit passes, advance to `PLAN_FROZEN`.

After `PLAN_FROZEN`, test authors may identify a `PLAN_OR_SPEC_DEFECT`, but they must not silently repair the design. A material defect returns the task to the earliest affected gate, followed by another plan audit before re-freezing.

## 6. Test design gate

After `PLAN_FROZEN`, design the test contract and concrete test cases before implementation.

Testing exists to prove the frozen behavior, not to maximize test count or coverage percentage.

Map every critical acceptance criterion to convincing evidence using the cheapest layer that does not bypass the failure-prone boundary:

1. static checks — syntax, lint, type, build;
2. unit tests — algorithms, pure functions, local invariants;
3. integration/contract tests — module boundaries, schemas, state transitions, persistence contracts;
4. automated journey/smoke tests — production-facing entry through the important component path;
5. manual/computer-use acceptance — visual, OS, third-party, or exploratory behavior that is not reliable or economical to automate.

Where practical, write executable pre-implementation tests for frozen externally observable behavior. They may initially fail because production behavior is not implemented yet. Do not force all tests to be executable before implementation when doing so would require production scaffolding or implementation-specific coupling.

For each critical test ask the Failure Challenge:

> If the acceptance criterion were deliberately broken, would this test reliably fail?

Mock only where isolation is necessary. Do not mock away the boundary the test exists to verify.

Advance to `TEST_READY` when the test contract and any pre-implementation test diff are ready for independent test review.

## 7. Test review and DELIVERY FREEZE

Test review is a distinct gate from test authoring.

Review whether:

- every critical acceptance criterion has meaningful evidence;
- test oracles are derived from the frozen requirement and plan rather than implementation convenience;
- tests would fail for the intended defect;
- important state transitions, boundaries, failure paths, and recovery paths are covered where applicable;
- mocks, fixtures, shortcuts, or bypassed entry paths create false-green risk;
- tests do not silently introduce new product behavior;
- the suite is proportionate and does not duplicate assertions without diagnostic value.

If test review exposes a requirement or plan defect, classify it as `PLAN_OR_SPEC_DEFECT`, return to the affected gate, and re-run the required audits.

If test review passes, advance to `DELIVERY_FROZEN`.

At `DELIVERY_FROZEN`, the requirement, implementation plan, and test contract are authoritative for implementation. Changes to any material frozen behavior require an explicit rollback to the affected gate.

## 8. Implementation mode selection

Choose the implementation mode after `DELIVERY_FROZEN`.

### Slice execution

Use when the plan already defines low-discretion behavioral slices.

The implementation agent executes slices in dependency order and must not redesign or reinterpret frozen behavior. This is the default mode for lower-cost implementation models.

### Goal execution

Use when the external behavior and constraints are frozen but the implementation search space remains bounded enough that prescribing every local step would add more overhead than value.

The goal agent may decide **how** to implement inside the frozen boundary, including local sequencing, internal function structure, and small architecture-consistent refactors required by the goal. It may not redefine **what** the system should do, acceptance criteria, public contracts, persistence semantics, security boundaries, or material architecture decisions.

Goal mode is not permission to broaden scope.

Record the chosen mode in `state.yaml`.

## 9. Implementation gate

During `IMPLEMENTING`, follow the selected execution mode and the target repository's project rules.

Use the project's explicit code and testing standards when present. If they are absent, use the fallback baseline defined by this configuration repository. Project-specific rules always win over the fallback baseline.

After each slice, or after each meaningful checkpoint in goal mode:

1. inspect the resulting diff;
2. run targeted tests;
3. run relevant integration or journey tests;
4. verify the applicable acceptance criteria;
5. verify invariants and non-goals;
6. confirm no duplicate source of truth or unplanned architecture was introduced;
7. confirm tests were not weakened to obtain green status;
8. perform a self-review against the frozen contracts;
9. record evidence and implementation deviations.

If execution requires a material product or architecture decision not covered by the frozen contracts, stop. Do not guess.

Advance to `IMPLEMENTATION_READY` only when the planned scope is complete and the full change-level verification appropriate to the risk is green or explicitly documented as unavailable.

## 10. Model routing

Model choice is a cost/complexity decision, not part of the product contract.

Default routing:

- requirement closure, plan creation, plan audit, test review, and independent review → high-reasoning model;
- low-discretion slice execution → lower-cost implementation model when task complexity permits;
- goal execution or slices with high semantic complexity → stronger implementation model.

Escalate implementation when the task involves several interacting invariants, cross-module semantic changes, complex state/lifecycle behavior, migrations, persistence, concurrency, security-sensitive logic, or repeated failure by a lower-cost model.

If the first independent review finds a severe semantic implementation defect despite a frozen and explicit contract, prefer escalating the implementation model rather than entering an indefinite low-cost patch/review loop.

## 11. Independent review

Independent review starts from the trusted pre-change baseline and does not trust the implementation summary.

Review against the frozen requirement, plan, test contract, project rules, and actual diff in this order:

1. correctness and requirement compliance;
2. state/lifecycle/invariants;
3. data integrity, idempotency, failure and recovery behavior;
4. compatibility and security boundaries;
5. false-green test risk;
6. architecture consistency and unnecessary complexity;
7. maintainability.

Do not use modified requirement documents in the same untrusted change set as sole evidence that the implementation is correct.

Every blocking finding must include evidence, impact, and a bounded correction direction.

## 12. Finding taxonomy

Severity and origin are separate dimensions.

Use one origin for each material finding:

- `IMPLEMENTATION_DEFECT` (`I`) — implementation violates an already frozen contract or project rule.
- `PLAN_OR_SPEC_DEFECT` (`P`) — the frozen requirement, plan, or test contract is incomplete, contradictory, or wrong.
- `REVIEW_MISS` (`R`) — during re-review, an issue is found that already existed in the previous reviewed change set and reasonably should have been detected then.
- `DISCOVERY` (`D`) — new evidence became available only through implementation, execution, environment, or integration and could not reasonably have been closed earlier.

Use severity independently, for example `Blocker`, `Required`, or `Follow-up` according to project review rules.

This taxonomy is for workflow diagnosis, not blame.

## 13. Fix routing

After a blocking review, classify findings before editing.

- `IMPLEMENTATION_DEFECT` → remain within the frozen delivery contract and fix the implementation.
- `PLAN_OR_SPEC_DEFECT` → return to the earliest affected contract gate; do not let the implementation agent invent the missing rule.
- `DISCOVERY` → decide which contract is affected, update it, and re-run the necessary downstream gates.
- `REVIEW_MISS` → fix if valid, but record it separately so review convergence can be measured.

Do not combine unrelated cleanup or redesign with a finding fix.

## 14. Re-review

Re-review is not a new independent audit.

Its primary scope is limited to:

1. whether the previous blocking findings are actually closed;
2. whether the fixing diff is correct;
3. whether the fixing diff introduced direct regressions;
4. whether required verification evidence is now present.

Do not reopen already frozen and unrelated design space merely because a new review pass is being performed.

If a valid pre-existing issue is discovered that reasonably should have been found in the previous review, it may still be reported, but classify it as `REVIEW_MISS`.

This distinction is required to prevent an endless sequence of statistically different full audits from being mistaken for repeated implementation failure.

Review outcomes:

- `PASS` → advance to `ACCEPTANCE` when acceptance evidence remains, otherwise `DONE`.
- `PASS_WITH_NON_BLOCKING_FINDINGS` → same transition, with findings recorded.
- `BLOCK` → route findings according to their origin.

## 15. Acceptance gate

Acceptance answers whether the shipped behavior is demonstrated in the environment that matters.

Prefer deterministic automated evidence. Add manual or computer-use checks only for residual behavior that automation cannot prove well.

Advance to `DONE` only when:

- all acceptance criteria are satisfied or explicitly waived by the user;
- required automated checks are green;
- required manual/computer-use checks are complete;
- blocking review findings are resolved;
- residual risks and unverified areas are documented;
- `state.yaml` points to the final verified commit or equivalent durable evidence when available.

## 16. Cross-chat handoff

A new agent or chat should be able to resume by reading project rules and the task packet.

Before ending an active phase, persist:

- current phase and freeze status;
- selected implementation mode when applicable;
- completed and pending slices or goal checkpoints;
- decisions that changed a contract;
- verification commands and outcomes;
- relevant commit SHA or diff baseline when known;
- review findings and origin classification;
- blockers;
- exact next role and action.

Do not store a long conversation transcript. Persist decisions and evidence, not discussion history.

## 17. State reconciliation

Repository state can move outside this workflow. Therefore `state.yaml` is not blindly authoritative about facts such as current commit or test status.

On resume:

1. compare the recorded branch/commit with the actual repository;
2. inspect relevant diff and working tree state;
3. re-run only the checks needed to establish a trustworthy baseline;
4. update stale state before making further transitions.

When a task packet conflicts with explicit new user instructions, follow the user and update the task packet so later agents do not inherit stale intent.

## 18. Workflow diagnostics

When evaluating whether the workflow or model routing is working, do not use review-round count alone.

Track at least:

- first-pass implementation defects after `DELIVERY_FROZEN`;
- `I / P / R / D` finding counts;
- severe semantic implementation defects;
- fix-induced regressions;
- number of re-reviews required for closure.

Repeated `I` findings indicate an implementation execution problem. Repeated `P` findings indicate premature freeze. Repeated `R` findings indicate review convergence problems. `D` findings indicate genuine implementation-time discovery rather than necessarily a process failure.
