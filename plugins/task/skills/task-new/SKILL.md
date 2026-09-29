---
name: task-new
description: Start a small Workflow OS task from chat, a meeting action, or an existing Jira ticket. Uses the current conversation and an optional active-task pointer; it does not require a database or automatic memory.
---

# `$task-new` — Start a Task

Use this for one-off work, support items, meeting actions, or a Jira ticket that does not need project phases or a workspace marker. Route multi-item capture to `$task-agenda`.

1. Identify the source. For an existing Jira key, verify it read-only with Rovo first and `acli` as fallback. Do not create Jira issues here.
2. Capture only missing details: task title, status, due date if relevant, concrete next action, and blockers.
3. Derive and confirm a stable slug from the Jira key or title.
4. Ask whether to make it active. If yes, call `${plugin_root}/scripts/active-task.ps1 -Set <slug>`.
5. Return a concise in-chat task card.

The task card lives in the conversation and native Codex memory. For durable shared work, use Jira. For a cross-chat handoff, offer a chat recap or Jira-ready draft; do not create a local memory record automatically.

No `WOS.md` marker for tasks. No Jira write without explicit current-turn confirmation.
