# Development Flow Protocol v0.2

This document defines the durable workflow used by the `development-flow` skill. It is intentionally small enough to apply across projects; project-specific rules stay in the target repository.

The workflow separates specification closure, conditional experience closure, test design, implementation, and review so defects can be attributed to the correct stage instead of being discovered through an unbounded sequence of code-review rounds.

## 1. Task packet

A task that needs cross-session continuity should use:

```text
.agent/tasks/<task-id>/
├── state.yaml
├── requirement.md
├── experience-contract.md   # only when experience-sensitive
├── implementation-plan.md
├── test-contract.md
└── review.md
```

Not every file must exist in `DRAFT`, but files required by a completed gate must exist before advancing.

`state.yaml` is the routing index, not a substitute for the contracts. It records phase, task classification, experience status, implementation mode, contract status, slice status, human-gate status, evidence pointers, blockers, and next action.

## 2. State machine

Normal path:

```text
DRAFT
  → REQUIREMENT_READY
  → [EXPERIENCE GATE when required]
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

The Experience Gate is conditional rather than a separate mandatory phase value. Track it in `state.yaml.classification`, `contracts.experience`, `reviews.experience`, and `manual_gates`.

Any active phase may move to `BLOCKED` when a hard stop is reached. After the blocker is explicitly resolved, return to the earliest phase/gate whose assumptions changed.

Do not skip a gate merely because a capable model could infer missing decisions.

The two freeze points have different meanings:

- **PLAN_FROZEN** — requirement + required frozen experience + implementation plan form an approved design baseline.
- **DELIVERY_FROZEN** — requirement + required frozen experience + implementation plan + test contract form the implementation authority boundary.

## 3. Requirement gate

Advance to `REQUIREMENT_READY` only when:

- the user-observable goal is explicit;
- current and target behavior are distinguished;
- acceptance criteria are externally verifiable;
- important non-goals are explicit;
- invariants and compatibility constraints are recorded;
- material product decisions are resolved enough to identify whether Experience Design is required;
- remaining assumptions are low-impact and reversible.

Classify the task before planning:

- `engineering` — user-visible behavior is already frozen or the work is non-experiential;
- `experience-sensitive` — implementation would create/materially change home/entry/exit, routes/navigation, visual composition/framing, UI/UX, user-facing copy, interaction feel/discoverability, scene presentation, major animation/effect language, asset strategy, or unresolved responsive behavior.

If code, tests, docs, and user intent disagree, record the conflict. Do not let current code or existing tests silently redefine requested behavior.

A requirement audit should challenge the requirement itself, not merely proofread it.

## 4. Conditional Experience Gate

For `experience-sensitive` work, close Experience Design **before production implementation planning is frozen**.

Use a project-local experience document or `assets/experience-contract.md`.

The artifact should define enough of the user-visible target that an implementation agent can reproduce approved decisions rather than inventing them. Depending on scope, include:

- first screen / entry / exit;
- route/navigation IA;
- approved visual/UX references;
- keyframes/mockups/storyboards;
- composition/framing/hierarchy;
- interaction states and discoverability;
- asset strategy and code responsibility split;
- responsive behavior;
- failure/fallback experience;
- explicit non-goals.

Approval states:

- `DRAFT` — unresolved;
- `REVIEW` — concrete proposal ready for human decision;
- `FROZEN` — explicit human approval; implementation authority granted;
- `BLOCKED` — required decision/artifact missing.

Experience FREEZE is a **blocking-human gate**. An agent may prepare options, generated keyframes, mockups, storyboards, or throwaway feasibility spikes, but may not self-set `FROZEN`.

A technical spike proves feasibility only. It does not make its routes, visual composition, interaction presentation, or UI accepted product behavior.

If no experience decision is required, record `experience_status: NOT_REQUIRED` and continue.

## 5. Planning gate

Create an implementation plan only after inspecting relevant architecture, call/data/state paths, project rules, current repository state, and any required frozen Experience Contract.

Advance to `PLAN_READY` when the plan is ready for independent audit and:

- the source of truth is explicit;
- changes are minimal and architecture-consistent;
- new abstractions/dependencies have demonstrated need;
- work is split into behavioral slices rather than file-count targets;
- every slice is classified `engineering` or `experience-sensitive`;
- each slice has goal, scope, invariants, acceptance criteria, required tests, verification commands, dependencies, human-gate dependencies, and hard-stop conditions;
- experience-sensitive slices name the exact approved artifacts they implement;
- the plan does not defer a known product, experience, or architecture decision to the implementation agent.

A slice can be small in code volume and still be cognitively complex. Planning must account for state, lifecycle, contract, experience, and cross-module invariants.

## 6. Plan audit and PLAN FREEZE

The plan audit is independent from plan authoring. Treat the plan as potentially wrong.

Check at minimum:

- complete requirement coverage;
- hidden state/lifecycle gaps;
- cross-slice dependencies;
- failure/recovery/compatibility/persistence boundaries;
- whether acceptance criteria are implementable/testable;
- whether a lower-cost implementation agent can execute each slice without inventing product behavior;
- whether experience-sensitive slices are backed by `FROZEN` experience authority;
- whether blocking-human gates occur before dependent downstream investment;
- whether the plan introduces unnecessary architecture or duplicate sources of truth.

If the audit passes, advance to `PLAN_FROZEN`.

For experience-sensitive work, `PLAN_FROZEN` is invalid if the required Experience Contract is not `FROZEN` with explicit human PASS.

After `PLAN_FROZEN`, test authors may identify a `PLAN_OR_SPEC_DEFECT`, but they must not silently repair the design. A material defect returns the task to the earliest affected gate, followed by required re-review before re-freezing.

## 7. Test design gate

After `PLAN_FROZEN`, design the test contract and concrete test cases before implementation.

Testing exists to prove frozen behavior, not to maximize test count or coverage percentage.

Map every critical acceptance criterion to convincing evidence using the cheapest layer that does not bypass the failure-prone boundary:

1. static checks;
2. unit tests;
3. integration/contract tests;
4. automated journey/smoke tests through production-facing entry;
5. manual/computer-use acceptance where human judgment is authoritative.

Where practical, write executable pre-implementation tests for frozen externally observable behavior. Do not force them when this requires production scaffolding or implementation-specific coupling.

For each critical test ask:

> If the acceptance criterion were deliberately broken, would this test reliably fail?

For visual/UX acceptance also ask:

> Does this prove fidelity to the approved target, or only that something renders?

Classify every manual gate:

- `blocking-human` — dependent work stops until explicit PASS;
- `nonblocking-human` — may remain pending only when it cannot change downstream architecture/product semantics/correctness.

Visual composition, product entry/navigation, interaction feel/discoverability, scene framing, major effect language, and fidelity to approved keyframes/storyboards are blocking by default when failure would invalidate downstream work.

Advance to `TEST_READY` only when the contract and pre-implementation test diff are ready for independent review.

## 8. Test review and DELIVERY FREEZE

Review whether:

- every critical acceptance criterion has meaningful evidence;
- test oracles derive from frozen requirements/experience/plan rather than implementation convenience;
- tests would fail for intended defects;
- important state transitions, boundaries, failure paths, and recovery paths are covered;
- mocks/fixtures/shortcuts/bypassed entry paths create false-green risk;
- tests do not silently introduce product behavior;
- all manual gates have correct blocking classification;
- the suite is proportionate.

If review exposes a requirement, experience, or plan defect, classify it `PLAN_OR_SPEC_DEFECT`, return to the affected gate, and re-run downstream audits.

If test review passes, advance to `DELIVERY_FROZEN`.

At `DELIVERY_FROZEN`, implementation authority consists of the requirement, required frozen experience, implementation plan, and test contract. Material changes require explicit rollback to the affected gate.

## 9. Implementation mode selection

Choose implementation mode after `DELIVERY_FROZEN`.

### Slice execution

Use when the plan already defines low-discretion behavioral slices. The agent executes dependency order and must not redesign frozen behavior.

### Goal execution

Use when external behavior, experience, constraints, and tests are frozen but the local implementation search space remains bounded enough that prescribing every step adds more overhead than value.

Goal mode gives freedom over **how**, not **what**. It may not redefine user-visible behavior, acceptance, public contracts, persistence/security semantics, material architecture, or approved experience.

Goal mode must evaluate gate dependencies at every slice/checkpoint. It may chain engineering work only while prerequisite blocking-human gates are PASS.

`PENDING HUMAN REVIEW` is not permission to continue dependent work.

Record mode in `state.yaml`.

## 10. Implementation gate

During `IMPLEMENTING`, follow selected mode and target-repository rules.

After each slice/checkpoint:

1. inspect diff;
2. run targeted tests;
3. run relevant integration/journey tests;
4. verify acceptance criteria;
5. verify invariants/non-goals;
6. confirm no duplicate source of truth or unplanned architecture;
7. confirm tests were not weakened;
8. self-review against all frozen contracts;
9. evaluate every manual gate owned/prerequisite at this point;
10. record evidence and deviations.

If a required blocking-human gate is `PENDING` or `FAIL`, stop dependent work with:

```text
HARD STOP — BLOCKING HUMAN GATE
Slice/checkpoint:
Gate:
Status: PENDING | FAIL
Evidence ready for human review:
Dependent work that must not begin:
```

If execution requires a material product/experience/architecture decision not covered by frozen contracts, stop with:

```text
HARD STOP — EXPERIENCE GATE REQUIRED
Current slice/checkpoint:
Missing decision/artifact:
Why dependent implementation cannot safely continue:
Safe independent engineering work, if any:
```

Advance to `IMPLEMENTATION_READY` only when planned scope is complete, verification is green or explicitly unavailable, and all required blocking-human gates are PASS.

## 11. Model routing

Model choice is a cost/complexity decision, not part of the product contract.

Default routing:

- requirement closure, experience-option synthesis/review support, plan creation, plan audit, test review, and independent review → high-reasoning model;
- low-discretion engineering slice execution → lower-cost model when complexity permits;
- goal execution/high semantic complexity → stronger implementation model.

Coding agents can generate experience options, but human approval is required to freeze material visual/UX decisions unless the user explicitly delegates that authority.

Escalate implementation when several interacting invariants, cross-module semantics, migrations, persistence, concurrency, security, or repeated lower-cost model failures are involved.

## 12. Independent review

Independent review starts from the trusted pre-change baseline and does not trust the implementation summary.

Review against frozen requirement, approved experience when applicable, plan, test contract, project rules, and actual diff in this order:

1. correctness/requirement compliance;
2. experience fidelity for user-visible work;
3. state/lifecycle/invariants;
4. data integrity/idempotency/failure/recovery;
5. compatibility/security;
6. false-green test risk;
7. architecture consistency/unnecessary complexity;
8. maintainability.

Do not use modified contracts in the same untrusted implementation change set as sole evidence that implementation is correct.

Every blocking finding must include evidence, impact, and bounded correction direction.

## 13. Finding taxonomy

Severity and origin are separate:

- `IMPLEMENTATION_DEFECT` (`I`) — implementation violates a frozen contract/approved experience/project rule;
- `PLAN_OR_SPEC_DEFECT` (`P`) — requirement, experience, plan, or test contract is incomplete/contradictory/wrong;
- `REVIEW_MISS` (`R`) — re-review finds a pre-existing issue the prior review reasonably should have caught;
- `DISCOVERY` (`D`) — new evidence available only through execution/environment/integration.

This taxonomy is for workflow diagnosis, not blame.

## 14. Fix routing

- `IMPLEMENTATION_DEFECT` → stay within frozen delivery contract and fix implementation.
- `PLAN_OR_SPEC_DEFECT` → return to earliest affected gate; implementation agent must not invent missing rule.
- `DISCOVERY` → decide which contract is affected, update it, re-run downstream gates.
- `REVIEW_MISS` → fix if valid and record separately.

For visual/UX failure, distinguish:

- implementation failed to reproduce approved target → implementation defect;
- approved target itself is unacceptable → reopen Experience Gate, not random code polishing.

Do not combine unrelated cleanup/redesign with finding fixes.

## 15. Re-review

Re-review primarily checks previous finding closure, fixing diff correctness, direct regressions, and required evidence. It is not a new invitation to reopen unrelated design space.

Outcomes:

- `PASS` → advance to `ACCEPTANCE` or `DONE`;
- `PASS_WITH_NON_BLOCKING_FINDINGS` → same transition with findings recorded;
- `BLOCK` → route by origin.

## 16. Acceptance gate

Acceptance answers whether shipped behavior is demonstrated in the environment that matters.

Prefer deterministic automated evidence, but do not postpone a required blocking-human product/experience gate to final acceptance when dependent implementation should have stopped earlier.

Advance to `DONE` only when:

- all acceptance criteria are satisfied/explicitly waived;
- required automated checks are green;
- required manual/computer-use checks are complete;
- all blocking-human gates are PASS;
- blocking review findings are resolved;
- residual risks/unverified areas are documented;
- `state.yaml` points to final verified commit/evidence when available.

## 17. Cross-chat handoff

Before ending an active phase, persist:

- current phase/freeze status;
- task classification and experience status;
- selected implementation mode;
- completed/pending slices/checkpoints;
- blocking/nonblocking human gates and evidence;
- decisions that changed a contract;
- verification commands/outcomes;
- relevant commit/diff baseline;
- review findings/origin;
- blockers;
- exact next role/action.

Persist decisions/evidence, not conversation transcripts.

## 18. State reconciliation

Repository state can move outside this workflow. `state.yaml` is not blindly authoritative.

On resume:

1. compare recorded branch/commit with actual repository;
2. inspect relevant diff/working tree;
3. verify required experience artifact still matches the implementation target;
4. re-run only checks needed for trustworthy baseline;
5. update stale state before further transitions.

Explicit new user instructions win; update the packet so later agents do not inherit stale intent.

## 19. Workflow diagnostics

Do not use review-round count alone.

Track at least:

- first-pass implementation defects after `DELIVERY_FROZEN`;
- `I / P / R / D` finding counts;
- severe semantic implementation defects;
- experience-gate failures discovered after implementation began;
- blocking-human gates incorrectly bypassed;
- fix-induced regressions;
- re-reviews required for closure.

Repeated `I` findings indicate execution problems. Repeated `P` findings indicate premature freeze. Repeated late experience failures indicate the Experience Gate is too weak or was bypassed. Repeated `R` findings indicate review convergence problems. `D` findings indicate genuine implementation-time discovery.
