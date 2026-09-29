# Workflow OS Azure Boards Team Standard

This standard defines how Workflow OS agents should inspect, create, update, maintain, and close Azure Boards work items for the development team.

## 1. Core Principle

Azure Boards is the development team's delivery tracking destination. A work item should make the next action clear to a teammate who was not in the original conversation.

Use `work-item-format.md` for titles, descriptions, comments, transition notes, and closure notes. Use `access-policy.md` before any project-specific action. Use `dev-workflow-model.md` when translating a real board or user-provided reference observations into reusable Workflow OS behavior.

## 2. Work Item Type Decision Rules

Choose the smallest work item type that accurately represents the work.

### Epic

Use an Epic when the work spans multiple features, releases, systems, or reporting periods.

### Feature

Use a Feature when the work is a visible capability or deliverable that may contain multiple stories, bugs, or tasks.

### User Story

Use a User Story when the work describes a user-facing or stakeholder-facing outcome.

### Task

Use a Task when the work is a concrete implementation, database, configuration, testing, or follow-up deliverable.

### Bug

Use a Bug when the work is a defect, regression, failed behavior, data issue, or investigation of broken behavior.

## 3. Project Rules

- `Sandbox`: testing ground; confirmed writes may be performed here.
- `ClaimImport`: reference point for how the team works; read-only forever unless the explicit policy changes.

Before any write, verify the target project. If the project is `ClaimImport`, stop.

## 3.1 Reference Board Discovery

Use `$azure-boards-discover` to inspect `ClaimImport` read-only and identify reusable workflow patterns. If direct inspection is unavailable, use `$azure-boards-intake` with user-provided screenshots, copied fields, or summaries. Discovery and intake may inform:

- Work item templates.
- Review criteria.
- Drafting defaults.
- Status update sections.
- Completion evidence.
- Candidate child-item splitting.

Discovery and intake must not create a hardcoded `ClaimImport` workflow. Treat observed values as configurable examples unless setup confirms them for the user's target project.

## 4. Creation Quality Checklist

Before creating a work item, verify:

- Target project is `Sandbox`.
- Work item type is correct.
- Title has exactly one lead emoji.
- Objective explains why the work exists.
- Scope says what is in and out where useful.
- Acceptance criteria or desired outcome is clear.
- Parent/related links are included when known.
- No secrets are present.
- The user approved the exact write payload in the current turn.

## 5. Maintenance / Comment Standard

Use comments to maintain continuity. A useful comment answers:

- What changed?
- What is happening now?
- What is blocked?
- What happens next?
- What references matter?

Do not post vague comments such as "working on this" unless paired with useful context.

## 6. Description Maintenance

Use `$azure-boards-mod` when:

- The description is missing the Workflow OS structure.
- Scope or acceptance criteria changed.
- The item was created without enough context.
- The work item evolved and the description is stale.

Do not use comments as a substitute for fixing a bad description when the description is causing confusion.

## 7. Review Standard

Use `$azure-boards-review` to classify an existing item as:

- `Pass`
- `Needs cleanup`
- `Needs clarification`
- `Wrong shape`

The review should recommend the smallest safe improvement and must not write unless the user explicitly confirms the proposed write.

## 8. User-Agnostic Function Standard

Azure Boards functions should be reusable for any development-team project:

- Ask for or infer the target project from setup.
- Use configured work item types and fields.
- Use the user's selected area path and iteration path when available.
- Avoid named-person defaults.
- Avoid `ClaimImport` as a write target.
- Keep `Sandbox` as the default test target until another read/write project is explicitly configured.
