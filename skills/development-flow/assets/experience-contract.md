# Experience Contract — <TASK-ID>

Status: `DRAFT | REVIEW | FROZEN | BLOCKED`

Use this artifact only when `task_type: experience-sensitive`.

Its purpose is to define user-visible experience before a coding agent is allowed to implement it.

## Experience scope

State which user-visible surfaces are controlled here:

- product entry/home;
- routes/navigation;
- visual composition/framing;
- UI/UX;
- user-facing copy;
- interaction feel/discoverability;
- animation/effect language;
- scene/asset strategy;
- responsive behavior;
- entry/exit states.

## User intent and first impression

- Why does the user arrive here?
- What must they understand within the first few seconds?
- What should they feel or be able to do without explanation?
- What must they not have to infer from hidden routes or developer knowledge?

## Approved visual / UX references

Record the small reference set used to communicate the target. References are directional evidence, not permission to copy protected work.

## Approved key states / keyframes

Define the minimum states needed for implementation review, such as:

- first screen / entry;
- idle;
- primary interaction;
- repeated/extreme interaction;
- completion/exit;
- desktop framing;
- mobile/narrow framing.

Attach or link approved keyframes/mockups/storyboards where applicable.

## Composition / information architecture

Specify the intentional hierarchy:

- primary/secondary regions;
- route and navigation structure;
- framing/camera when relevant;
- focal hierarchy;
- content/visual density;
- what must remain absent.

## Asset strategy

Choose deliberately: authored image/video/3D assets, Canvas/WebGL, DOM/CSS, hybrid, or another reviewed approach.

**Authored assets own:**

**Runtime code owns:**

**Runtime code must not invent:**

Do not assume interactive experience means the whole surface must be procedurally generated in code.

## Interaction storyboard

For each important state specify observable behavior rather than implementation math:

- entry;
- idle;
- first contact/action;
- continued action;
- release;
- repeated/frantic/edge-case action;
- completion/settling;
- exit.

For each state record:

- visible response;
- approximate spatial/temporal scope;
- response hierarchy;
- prohibited behavior.

## Discoverability

Explain why a first-time user would know what can be done.

Do not let the implementation agent invent tutorials, tooltips, affordances, or hidden gestures unless approved here.

## Route / entry / exit IA

Define when applicable:

- root behavior;
- normal product entry;
- first-run vs returning behavior;
- navigation/scene selection;
- exit control and destination;
- research/operator/debug routes and how they are isolated from normal product UX.

## Responsive behavior

Define what changes and what remains invariant across target viewport/device classes.

## Failure / fallback experience

State what the user sees when required assets, capabilities, or integrations fail.

A materially different fallback requires explicit approval.

## Explicit non-goals

List product/visual/interaction behaviors that must not appear.

## Blocking human gate

Experience FREEZE is a blocking-human gate.

Approval record:

- Reviewed artifact/version:
- Reviewer:
- Date:
- Verdict: `PENDING | PASS | FAIL`
- Approved decisions:
- Caveats:

Only `Status: FROZEN` with `Verdict: PASS` authorizes dependent production implementation.

If this gate is not passed, report:

```text
HARD STOP — EXPERIENCE GATE REQUIRED
Missing decision/artifact:
Why dependent implementation cannot safely continue:
Evidence ready for human review:
```
