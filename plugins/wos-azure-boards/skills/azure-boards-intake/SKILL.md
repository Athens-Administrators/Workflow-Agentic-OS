---
name: azure-boards-intake
description: Turn user-provided Azure Boards reference observations, screenshots, copied fields, or card summaries into a user-agnostic Workflow OS Azure Boards workflow profile. Read-only; does not modify Azure Boards.
---

# `$azure-boards-intake` - Azure Boards Reference Intake

You are converting user-provided Azure Boards observations into reusable Workflow OS Azure Boards behavior.

Use this when connector, CLI, API, or browser access cannot reliably inspect the board directly, or when the user has already gathered examples from `ClaimImport`.

## Required References

Load these before analyzing input:

- `${plugin_root}/../references/access-policy.md`
- `${plugin_root}/../references/dev-workflow-model.md`
- `${plugin_root}/../references/work-item-format.md`
- `${plugin_root}/../references/azure-boards-standard.md`

## Accepted Inputs

The user may provide:

- A screenshot of a board, list, query, or work item.
- Copied work item fields.
- A manually summarized card.
- A small sample of titles, states, tags, and descriptions.
- A list of board columns or process states.
- A description of how the development team moves cards.

## Steps

1. Restate that `ClaimImport` is read-only reference context and `Sandbox` is the only testing/write target.
2. Extract only structural workflow patterns:
   - Work item types.
   - States and board columns.
   - Required and commonly used fields.
   - Area and iteration patterns.
   - Title conventions.
   - Description sections.
   - Acceptance criteria style.
   - Tags and link conventions.
   - Completion evidence.
   - Repeated card categories, such as bug, data fix, feature, task, release, or investigation.
3. Redact or generalize sensitive data, names, customers, claim details, secrets, or private identifiers unless the user explicitly asks to preserve a non-sensitive label.
4. Convert the observations into a user-agnostic workflow profile.
5. Propose reusable WOS Azure Boards functions that would help the dev team.
6. If a plugin edit is requested or clearly useful, update `dev-workflow-model.md`, `azure-boards-standard.md`, or a specific skill with configurable patterns. Do not hardcode one person's account or one live ClaimImport card.

## Output Shape

```text
Azure Boards Reference Intake
Source: <ClaimImport screenshot / copied card / user summary>
Mode: read-only pattern intake

Observed workflow patterns
- <pattern>

Reusable WOS behavior
- <behavior>

Candidate functions
- <function>

Configuration values to ask during setup
- <field or default>

Open questions
- <question>
```

## Hard Rules

- Do not write to Azure Boards.
- Do not modify `ClaimImport`.
- Do not store raw card exports.
- Do not preserve secrets, PATs, customer-private details, or unnecessary personal information.
- Keep the resulting behavior user-agnostic and configurable.
