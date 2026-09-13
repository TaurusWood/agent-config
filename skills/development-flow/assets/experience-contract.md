# Experience Contract — <TASK-ID>

Status: DRAFT

Use this artifact for `experience` or `hybrid` tasks. Delete/mark not required only when the Requirement Contract demonstrates that no material user-visible experience decision is open.

## Experience goal

State what the user should understand, feel, or be able to do.

## First screen / entry

What does a normal user see first? How did they get here? What action is obvious next?

## Route / navigation IA

Define product routes and distinguish them from debug, operator, research, or test entry points.

## Visual references

List/attach approved references and what each reference contributes. References guide direction; they are not copied assets.

## Approved keyframes / mockups

Record the artifacts that implementation must reproduce, including desktop and narrow/mobile where applicable.

## Composition / visual hierarchy

Define framing, focal hierarchy, density, major regions, palette/lighting direction, and explicit exclusions.

## Asset strategy

Choose image / video / 2D / 3D / hybrid / other.

**Authored assets own:**

**Runtime code owns:**

**Runtime code must not invent:**

## Interaction storyboard

For each relevant state define observable behavior:

- entry:
- idle:
- first interaction:
- continued interaction:
- release:
- repeated/frantic interaction:
- settling/completion:
- exit:

## Discoverability

How does a first-time user discover the intended interaction without unapproved tutorial/UI?

## Responsive behavior

Define viewport/device behavior and allowed reframing/cropping.

## Failure / fallback behavior

What should the user see if a required asset/effect/capability fails? Identify fallbacks that require re-approval.

## Explicit prohibitions

List visual/UX/product decisions the implementation agent must not make.

## Human approval gate

Experience FREEZE is blocking.

```text
Status: DRAFT | REVIEW | FROZEN | REJECTED | BLOCKED
Reviewed artifact/version:
Decision:
Caveats:
Reviewer:
Date:
```

Only `FROZEN` authorizes dependent implementation.
