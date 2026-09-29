---
name: memory-lite
description: Orient a user to the current Workflow OS context without creating, querying, or updating a separate memory store. Use when the user asks what WOS knows, wants to resume deliberately, or needs an explicit handoff option.
---

# `$memory-lite` — Orient to WOS Context

Workflow OS Memory Lite supplements native Codex memory; it does not replace, duplicate, export, or programmatically manage it.

## Operating model

- **Native Codex memory and the current conversation** hold personal preferences, working style, and conversational continuity.
- **Jira** is the source of truth for active shared work.
- **`WOS.md`** is an optional, small project locator. It identifies a workspace and may link to Jira; it is not a session log or a knowledge base.
- **`local.json` active_project / active_task** are optional local pointers only. They are not task or project histories.
- **Handoffs are explicit.** Do not create a file, comment, or summary unless the user asks for one and confirms its destination when a write is required.

## Step 1 — Orient read-only

Use the current conversation and native memory already available to you. If the current directory or one of its parents contains `WOS.md`, read only that marker. If useful, read the local active pointers through the documented project/task helper scripts.

Report at most five bullets: workspace/project locator, linked Jira key, active project/task pointer, relevant context already available, and the best next step. Do not invent missing context. Do not search a legacy database, start an MCP server, or install dependencies.

## Step 2 — Offer an explicit handoff only when useful

When continuity must survive a chat change, a different person, or a deliberate pause, offer these destinations in order:

1. **Chat-only recap** — no write.
2. **Jira-ready update draft** — show it for review; post only after current-turn confirmation.
3. **Compact `WOS.md` handoff** — only for a workspace project and only after the user confirms the exact text. Keep it to current objective, blocker, next action, and dated links; never add a transcript.

Never write automatically at session start, session end, or task/project completion.

## Hook policy

Memory Lite intentionally registers no hooks. Dependency checks, database startup, automatic summaries, and automatic resumption are outside its scope. If a pilot later needs a hook, it must be read-only, silent when no marker exists, complete in under one second, and never depend on another service.
