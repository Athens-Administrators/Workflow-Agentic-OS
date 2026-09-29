---
name: task-agenda
description: Build, refresh, filter, or prioritize a concise Workflow OS agenda from chat, meetings, documents, Jira, or any available approved source. Default to an in-chat agenda brief; external writes are never automatic.
---

# `$task-agenda` — Universal Task Inbox

Load `${plugin_root}/references/task-agenda-standard.md` and follow its source, normalization, and delivery rules.

Accept action items and deliverables from user-supplied content first, then read an approved connector only when the user asks or it is clearly needed. Do not invent unseen source data.

Default to the agenda brief. Return the full table only when the user asks for detail, needs to edit rows, or needs a Jira-ready export. Do not create HTML, a dashboard, a database record, a local agenda file, or an automatic handoff.

If the user asks to make an agenda active in Codex-local mode, call `${plugin_root}/scripts/active-task.ps1 -Set <agenda-slug>`. In ChatGPT Work or any surface without local scripts, acknowledge that the agenda remains in the conversation and do not attempt a local write.

For Jira, prepare a draft and route any actual write through `wos-jira` with explicit current-turn confirmation.
