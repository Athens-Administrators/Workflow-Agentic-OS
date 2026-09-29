---
name: task-checkpoint
description: Prepare a concise, explicit handoff for the current Workflow OS task. The user chooses chat-only or a Jira-ready draft; no automatic memory receipt is created.
---

# `$task-checkpoint` — Create a Deliberate Task Handoff

Resolve the active task through `${plugin_root}/scripts/active-task.ps1` or ask the user for a slug/Jira key. Gather status, blockers, due date if relevant, next action, and a short narrative from the current conversation and optional Jira read.

Present a concise handoff in chat. Offer:

1. **Chat only** — no write.
2. **Jira-ready checkpoint draft** — display it and post only after explicit current-turn confirmation.

Do not create a file, database record, or automatic session summary. Use `$task-update` for a quick in-chat update.
