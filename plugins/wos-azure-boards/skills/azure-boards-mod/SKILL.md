---
name: azure-boards-mod
description: Modify an Azure Boards work item description into the Workflow OS emoji-section format. Writes are limited to Sandbox and require explicit confirmation.
---

# `$azure-boards-mod` - Azure Boards Description Edit

You are modifying the description field of an Azure Boards work item. Comments use `$azure-boards-update`; this skill is for descriptions only.

## Required References

Load these before drafting:

- `${plugin_root}/../references/setup-gate.md`
- `${plugin_root}/../references/access-policy.md`
- `${plugin_root}/../references/azure-boards-standard.md`
- `${plugin_root}/../references/work-item-format.md`
- `${plugin_root}/../references/azure-boards-tooling.md`

## Steps

1. Apply the setup gate.
2. Ask for the work item ID or URL.
3. Fetch or inspect the current item read-only.
4. If the item is in `ClaimImport`, stop. It may be reviewed, but not modified.
5. If the item is not in `Sandbox`, stop unless the access policy has been explicitly changed.
6. Show the current description and ask what should change:
   - Reformat to Workflow OS structure.
   - Update Objective / Scope / Acceptance / Links / Notes.
   - Add a missing section.
7. Draft the new description using `work-item-format.md`, preserving useful existing content.
8. Show a before/after diff and ask for explicit confirmation.
9. On yes, use the tooling order from `azure-boards-tooling.md`. If no write-capable tool is available, stop and give the approved draft.

## Hard Rules

- Never blank out a description without explicit confirmation.
- Preserve links and attachment references unless the user says to drop them.
- No `ClaimImport` writes.
- No secrets.
- No bulk edits.

