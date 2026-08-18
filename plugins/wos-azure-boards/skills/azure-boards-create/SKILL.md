---
name: azure-boards-create
description: Create an Azure Boards work item in Sandbox using the Workflow OS emoji-formatted title and description. Requires explicit confirmation before writing.
---

# `$azure-boards-create` - Manual Azure Boards Work Item Creation

You are creating an Azure Boards work item on the user's explicit request.

## Required References

Load these before drafting:

- `${plugin_root}/../references/setup-gate.md`
- `${plugin_root}/../references/access-policy.md`
- `${plugin_root}/../references/azure-boards-standard.md`
- `${plugin_root}/../references/work-item-format.md`
- `${plugin_root}/../references/azure-boards-tooling.md`

## Steps

1. Apply the setup gate.
2. Ask for or infer:
   - Target project. Default to `Sandbox`.
   - Work item type: Epic, Feature, User Story, Task, or Bug.
   - Parent work item ID or URL, if applicable.
   - Title following `work-item-format.md`.
   - Objective.
   - Scope.
   - Acceptance criteria.
   - Links/references.
3. Enforce the access policy:
   - If target project is `ClaimImport`, stop. It is read-only.
   - If target project is not `Sandbox`, stop unless the explicit access policy has been changed.
4. Run the creation checklist from `azure-boards-standard.md`.
5. Draft the description using `work-item-format.md`.
6. Show the exact proposed payload:

```text
Project: Sandbox
Type: <type>
Parent: <id/url or none>
Title: <title>
Description:
<full body>
```

Ask: "Create this in Azure Boards Sandbox? (yes/no)"

7. On yes, use the tooling order from `azure-boards-tooling.md`. Prefer the Azure Boards connector when create/update tools are exposed. If not exposed and CLI is authenticated, use `az boards work-item create`. If neither write path is available, stop and give the user the approved draft.
8. On success, return the work item ID and URL if available.

## Hard Rules

- Writes are allowed only in `Sandbox`.
- `ClaimImport` is read-only.
- No deletes or destructive operations.
- No secrets.
- One work item per create action.
- Confirmation is per action and does not carry across turns.

