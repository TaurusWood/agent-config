# Development Flow Protocol v0.2

This protocol governs engineering and experience-driven product work. Project-specific contracts remain in the target repository.

## 1. Task packet

Recommended packet:

```text
.agent/tasks/<task-id>/
├── state.yaml
├── requirement.md
├── experience-contract.md   # required for experience/hybrid tasks
├── implementation-plan.md
├── test-contract.md
└── review.md
```

`state.yaml` routes work; the contracts hold the actual decisions.

## 2. Task kinds

Classify every non-trivial task before planning:

### engineering

User-visible behavior is already sufficiently defined. Work may include logic, infrastructure, API/data, performance, refactor, or implementation of frozen visual/interaction behavior.

### experience

The task creates or materially changes visual composition, UX, routes/navigation, interaction feel/discoverability, animation/effect language, visual assets, or product copy.

### hybrid

Both engineering and experience decisions are material.

If experience impact is uncertain, treat it as `hybrid` until the uncertainty is resolved.

## 3. State machine

Engineering path:

```text
DRAFT
  → REQUIREMENT_READY
  → PLAN_READY
  → TEST_READY
  → IMPLEMENTING
  → IMPLEMENTATION_READY
  → REVIEWING
  → ACCEPTANCE
  → DONE
```

Experience/hybrid path:

```text
DRAFT
  → REQUIREMENT_READY
  → EXPERIENCE_DRAFT
  → EXPERIENCE_REVIEW
  → EXPERIENCE_READY
  → PLAN_READY
  → TEST_READY
  → IMPLEMENTING
  → IMPLEMENTATION_READY
  → REVIEWING
  → ACCEPTANCE
  → DONE
```

Any active phase may move to `BLOCKED`.

Do not skip the Experience Gate because a model can infer or generate something plausible.

## 4. Requirement gate

Advance to `REQUIREMENT_READY` only when:

- user-observable goal is explicit;
- current and target behavior are distinguished;
- acceptance criteria are externally verifiable;
- non-goals/invariants are explicit;
- material product decisions already known are recorded;
- task kind is classified;
- unresolved experience decisions are explicitly listed rather than delegated implicitly to implementation.

For experience/hybrid tasks, requirement readiness does **not** authorize implementation planning. It authorizes experience design.

## 5. Experience Gate

### 5.1 EXPERIENCE_DRAFT

Use cheap artifacts to reduce uncertainty:

- visual references;
- generated/static keyframes;
- wireframes;
- interaction storyboards;
- motion mockups;
- route/IA diagrams;
- throwaway technical spikes clearly marked as non-production.

Do not write production experience merely to see what it looks like when a cheaper artifact can answer the design question.

### 5.2 EXPERIENCE_REVIEW

A concrete proposal must exist. Review should answer, where relevant:

- first screen / product entry;
- route/navigation model;
- composition/framing;
- visual hierarchy/style;
- key desktop/mobile framing;
- interaction states and discoverability;
- asset strategy;
- responsive behavior;
- entry/exit behavior;
- fallback behavior;
- code-vs-asset responsibility.

### 5.3 EXPERIENCE_READY

Advance only after explicit human approval.

Experience FREEZE is a **blocking human gate**. The agent cannot self-approve it.

The artifact must be detailed enough that an implementation agent can reproduce the target without inventing material product/art decisions.

If not, remain in `EXPERIENCE_DRAFT`/`REVIEW` or `BLOCKED`.

## 6. Planning gate

Advance to `PLAN_READY` only when:

- relevant architecture/state/data path is inspected;
- experience prerequisites are `EXPERIENCE_READY` when applicable;
- source of truth is explicit;
- changes are minimal and project-consistent;
- new abstractions/dependencies have demonstrated need;
- work is split into independently verifiable slices;
- each slice declares `kind: engineering | experience | hybrid`;
- each slice has goal, scope, invariants, acceptance, tests, verification, dependencies, and hard-stop conditions;
- experience slices explicitly identify their blocking human gates;
- plan does not defer a known product decision to the coding agent.

A slice is behavioral, not a file-count target.

## 7. Test gate

Advance to `TEST_READY` only when every critical acceptance criterion maps to convincing evidence.

Evidence hierarchy:

1. static checks;
2. unit tests;
3. integration/contract tests;
4. production-facing automated journey/smoke;
5. manual/computer-use acceptance where human/environment judgment is authoritative.

For every critical automated test ask:

> If the behavior were deliberately broken, would this test reliably fail?

For visual/UX work also ask:

> Does this test prove fidelity to an approved target, or only that something renders?

Manual gates must be classified:

- `blocking-human`;
- `nonblocking-human`.

If a blocking gate is required before dependent implementation, it must already be PASS before that dependency begins.

## 8. Implementation gate

During `IMPLEMENTING`, execute slices in dependency order.

After every slice:

1. inspect diff;
2. run targeted tests;
3. run relevant integration/journey tests;
4. verify acceptance criteria/invariants/non-goals;
5. confirm tests were not weakened;
6. evaluate manual gates;
7. record evidence/status.

Automatic continuation is allowed only when:

- next slice is dependency-ready;
- no material product/architecture decision is missing;
- all blocking human gates for dependent work are PASS.

A pending blocking human gate is a hard stop even when all automated tests are green.

## 9. Goal Mode

Goal Mode is a scheduler over already-authorized work, not a substitute for product design.

It may chain engineering slices.

When the next work item requires visual/UX/route/interaction/copy/asset decisions that are not frozen, stop with:

```text
HARD STOP — EXPERIENCE GATE REQUIRED
Current phase/slice:
Pending gate:
Required human decision/evidence:
Dependent work that must not start:
```

Do not use production code as the default medium for exploring unresolved experience design.

## 10. Review gate

Review against a trusted pre-change baseline.

Review order:

1. requirement/experience fidelity;
2. correctness/invariants/lifecycle;
3. data/recovery/security/compatibility;
4. false-green test risk;
5. architecture consistency/complexity;
6. maintainability.

For experience work, compare against approved keyframes/storyboards/IA rather than against the previous implementation.

Outcomes:

- `PASS`;
- `PASS_WITH_NON_BLOCKING_FINDINGS`;
- `BLOCK`.

A visual implementation that is technically correct but fails the approved Experience Contract is `BLOCK`.

## 11. Acceptance gate

Advance to `DONE` only when:

- all acceptance criteria are satisfied/explicitly waived;
- required automated checks are green;
- required blocking human gates are PASS;
- review blockers are resolved;
- residual risks/unverified areas are recorded;
- final verified commit/evidence is durable.

## 12. Cross-chat handoff

Persist:

- task kind;
- current phase;
- completed/pending slices;
- experience approval status and artifact version;
- contract decisions;
- verification results;
- commit/diff baseline;
- blocking human gates;
- exact next action.

Persist decisions/evidence, not transcript.

## 13. State reconciliation

On resume:

1. compare recorded branch/commit with repository;
2. inspect relevant diff/worktree;
3. validate persisted experience artifacts still match implementation target;
4. re-run only checks needed for trustworthy baseline;
5. update stale state before advancing.

Explicit new user instructions override stale task state and must be persisted.
