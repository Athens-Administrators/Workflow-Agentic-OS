---
name: task-resume
description: Deliberately resume or switch an active Workflow OS task from a user-supplied slug, Jira key, or current local pointer. Uses native Codex memory and optional live Jira reads, not a task database.
---

# `$task-resume` — Resume a Task Deliberately

Ask for a Jira key or task slug unless the task is already named or the local active pointer is sufficient. Do not list historical tasks from a separate store.

Read the current conversation/native memory already available. If a Jira key exists, offer a live read using Rovo first and `acli` as fallback. With the user's approval, set the local selection through `${plugin_root}/scripts/active-task.ps1 -Set <slug>`.

Summarize the task, current status, blocker, next action, and whether a Jira read was performed. Do not write a checkpoint automatically.
