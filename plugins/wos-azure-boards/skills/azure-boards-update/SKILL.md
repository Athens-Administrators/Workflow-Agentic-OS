---
name: azure-boards-update
description: Append an emoji-formatted Azure Boards discussion/comment update to a Sandbox work item. Requires explicit confirmation before writing.
---

# `$azure-boards-update` - Manual Azure Boards Update

You are posting an update to an Azure Boards work item.

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
3. Verify the project read-only before drafting.
4. If the item is in `ClaimImport`, stop. Offer a draft comment for manual use only.
5. If the item is not in `Sandbox`, stop unless the access policy has been explicitly changed.
6. Ask for:
   - Status marker: 🟢 / 🟡 / 🔴 / 🔵 / ✅ / 🛠️.
   - One-line summary.
   - What's done, In progress, Blockers, Next, Refs as applicable.
7. Draft the comment using `work-item-format.md`.
8. Show the exact comment and ask for confirmation:

```text
Posting to Azure Boards item <id> in Sandbox:
──────────────────
<full comment>
──────────────────
Post? (yes/no)
```

9. On yes, use the tooling order from `azure-boards-tooling.md`. If no write-capable tool is available, stop and give the approved draft.

## Hard Rules

- One status marker per comment.
- No `ClaimImport` writes.
- No vague updates without useful context.
- No secrets.
- Confirmation is per action.

