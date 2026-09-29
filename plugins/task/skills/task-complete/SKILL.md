---
name: task-complete
description: Close an active Workflow OS task with an explicit in-chat outcome, optional Jira completion draft, and active-pointer clearing. It does not write a separate task history.
---

# `$task-complete` — Complete a Task

Resolve the active task through `${plugin_root}/scripts/active-task.ps1` and confirm completion. Capture the outcome, validation/evidence, and any follow-up in chat.

If a Jira key exists, offer a concise ✅ completion-comment draft and a separate proposed transition where appropriate. Show the exact Jira write manifest and obtain explicit current-turn confirmation before writing. Never transition automatically.

If the user confirms the task is complete, clear the pointer with `${plugin_root}/scripts/active-task.ps1 -Set ""`, unless it is an agenda with remaining open items and the user wants it retained.

Do not alter `active_project`, create memory records, or delete Jira items.
