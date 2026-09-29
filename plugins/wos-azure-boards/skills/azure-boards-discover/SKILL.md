---
name: azure-boards-discover
description: Read-only discovery of how a development team uses Azure Boards, using ClaimImport as a reference board by default. Produces a user-agnostic workflow profile and candidate WOS Azure Boards functions without modifying Azure Boards.
---

# `$azure-boards-discover` - Azure Boards Workflow Discovery

You are discovering how a development team uses Azure Boards so Workflow OS can build reusable, user-agnostic Azure Boards functions.

## Required References

Load these before inspecting anything:

- `${plugin_root}/../references/setup-gate.md`
- `${plugin_root}/../references/access-policy.md`
- `${plugin_root}/../references/azure-boards-tooling.md`
- `${plugin_root}/../references/dev-workflow-model.md`
- `${plugin_root}/../references/work-item-format.md`

## Scope

Default reference project:

- `ClaimImport`

Default safe write/testing project for later functions:

- `Sandbox`

This skill is read-only. It must not create, update, comment, transition, assign, tag, link, delete, or otherwise modify any Azure Boards item.

## Steps

1. Apply the setup gate. If setup is incomplete, send the user to `$azure-boards-setup`.
2. Restate the boundary before inspecting:
   - `ClaimImport` is read-only reference context.
   - `Sandbox` is the only testing/write target for later confirmed actions.
3. Use the tooling order from `azure-boards-tooling.md`:
   - Azure Boards connector first when it exposes the needed operation.
   - Azure DevOps CLI only when separately authenticated.
   - Authenticated browser read-only inspection when connector/CLI cannot expose board details.
   - REST/WIT last when authorized and needed for structural reads.
4. Inspect a small, representative sample rather than the entire board. Prefer:
   - Board columns/states.
   - Work item type list.
   - 3-5 recently active cards across different states.
   - 1-2 completed cards if available.
   - 1 bug/investigation card if available.
5. Capture only structural patterns from `dev-workflow-model.md`.
6. Do not copy sensitive business data into the profile. Summarize patterns generically.
7. Produce a workflow profile:

```text
Azure Boards Workflow Discovery
Source: ClaimImport (read-only)
Target write sandbox: Sandbox

Observed structure
- Work item types:
- States / columns:
- Area / iteration patterns:
- Parent-child patterns:

Observed card conventions
- Title patterns:
- Description sections:
- Acceptance criteria style:
- Tags / links:
- Completion evidence:

Reusable WOS functions to build
- <function idea>

Open questions
- <question>
```

8. If direct inspection is blocked or available tools only expose identity/organization metadata, switch to `$azure-boards-intake` and ask the user for a screenshot, copied work item fields, or a small manually summarized card sample.
9. If Workflow OS memory-engine is available and the user asks to persist the result, write a concise `reference` receipt. Do not persist raw card content.

## Hard Rules

- `ClaimImport` is read-only.
- No writes from this skill.
- No bulk export of board content.
- No secrets or sensitive card details in outputs or receipts.
- Discovery findings must be user-agnostic and configurable.
