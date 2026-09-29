---
name: task-update
description: Make a short, explicit status update for the active Workflow OS task or agenda in the current conversation, with an optional Jira-ready draft when a linked ticket exists.
---

# `$task-update` — Lightweight Task Update

Resolve the active task with `${plugin_root}/scripts/active-task.ps1`, or ask for a task slug/Jira key. Ask only what changed: status, next action, blocker, and due date if relevant.

Return the updated task card in chat. If a Jira key exists, offer a Jira-ready comment draft; write it only with explicit current-turn confirmation under the Jira emoji standard.

Do not use a database, create an automatic summary, or write a local substitute. Use `$task-agenda` for a multi-item table and `$task-checkpoint` for a handoff.
