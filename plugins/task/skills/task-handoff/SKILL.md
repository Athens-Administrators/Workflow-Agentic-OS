---
name: task-handoff
description: Produce a concise task handoff, completion recap, or Jira-ready draft from the active or named Workflow OS task. It never writes automatically.
---

# `$task-handoff` — Handoff or Complete a Task

Resolve the named task from the current conversation, native context, or optional Codex-local pointer. Do not search a task database or require a local pointer in ChatGPT Work.

Return a short in-chat handoff with outcome or current status, evidence, blocker, next action, and relevant links. If the user marks the task complete, record that only in the conversation; clear the Codex-local pointer only when it exists and the user asks to clear it.

If the task is linked to Jira, offer a concise Jira-ready completion or checkpoint draft. Route the actual comment or transition through `wos-jira` only after explicit current-turn confirmation. Do not create files, automatic summaries, database records, or Jira writes.
