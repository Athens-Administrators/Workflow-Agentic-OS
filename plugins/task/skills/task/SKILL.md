---
name: task
description: Create, resume, select, or update one Workflow OS task from chat, a meeting action, a document, or an existing Jira issue. Uses a concise in-chat task card and an optional Codex-local pointer.
---

# `$task` — Focus a Single Task

Use this skill for one action item, deliverable, follow-up, or Jira-linked task. Route multi-item capture and prioritization to `$task-agenda`.

Capture or update only the task title, source, owner, status, due date when relevant, concrete next action, blocker, and link. For a Jira key, read it with the active surface's approved Jira tool; do not create or modify Jira work here.

Return a concise task card. If the user asks to make it active and the active surface is Codex-local with the helper available, call `${plugin_root}/scripts/active-task.ps1 -Set <slug>`. Otherwise, keep the selection in the conversation and clearly avoid any local-script assumption.

For a shared-work update, offer a Jira-ready draft. Route any actual Jira write through `wos-jira` with explicit current-turn confirmation.
