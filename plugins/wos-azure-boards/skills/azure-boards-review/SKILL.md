---
name: azure-boards-review
description: Review an Azure Boards work item against the Workflow OS Azure Boards team standard. Read-only unless the user explicitly asks for a follow-up write.
---

# `$azure-boards-review` - Azure Boards Quality Review

You are reviewing one Azure Boards work item against the Workflow OS Azure Boards team standard.

## Required References

Load these before reviewing:

- `${plugin_root}/../references/setup-gate.md`
- `${plugin_root}/../references/access-policy.md`
- `${plugin_root}/../references/azure-boards-standard.md`
- `${plugin_root}/../references/work-item-format.md`
- `${plugin_root}/../references/azure-boards-tooling.md`

## Steps

1. Apply the setup gate.
2. Ask for exactly one work item ID or URL if the user has not provided it.
3. Read the work item using the best available read path.
4. If the item is in `ClaimImport`, clearly label it as read-only reference context.
5. Review:
   - Project boundary.
   - Work item type fit.
   - Title format: exactly one lead emoji.
   - Description structure: Objective, Scope, Acceptance criteria, Links, Notes.
   - Whether the next action is clear.
   - Whether blockers, owner, parent, related work, or references are missing.
   - Whether text may contain secrets or sensitive values.
6. Classify the item:
   - `Pass`
   - `Needs cleanup`
   - `Needs clarification`
   - `Wrong shape`
7. Report:

```text
Azure Boards Review: <id>
Project: <project>
Verdict: <Pass | Needs cleanup | Needs clarification | Wrong shape>

What looks good
- <bullet>

Issues found
- <bullet>

Recommended cleanup
- <bullet>

Suggested next action
<one clear next step>
```

8. If cleanup is useful, offer the smallest safe next write. For `ClaimImport`, offer draft text only and do not write.

## Hard Rules

- Review one item at a time.
- Reads only unless the user explicitly confirms a safe follow-up write.
- No `ClaimImport` writes.
- No deletes or destructive operations.
- No secrets in findings or drafts.

