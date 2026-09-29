---
name: task-agenda
description: Build or update a Workflow OS task agenda table from manual entries, meeting actions, tickets, calendar, or Zoom when relevant connectors are available. The table is explicit in the current conversation; Jira sync is optional and confirmation-gated.
---

# `$task-agenda` — Task Keeper and Agenda

Load `${plugin_root}/references/task-agenda-standard.md` and follow its filtering and table rules.

Use simple Codex-only mode by default. Build the agenda in the current conversation from user-provided items or requested source reads. Do not create a database record or assume a Jira project key.

For Jira board sync, only proceed when the user asks. Confirm target project, issue type, fields, and exact rows; show a write manifest and obtain explicit current-turn confirmation before writing.

If the user wants the agenda selected for this machine, call `${plugin_root}/scripts/active-task.ps1 -Set <agenda-slug>`. This is a pointer, not durable task history.

Return the table first, then identify unavailable source pulls and whether Jira sync occurred. For cross-chat continuity, offer a copyable recap or Jira-ready draft; do not save automatically.
