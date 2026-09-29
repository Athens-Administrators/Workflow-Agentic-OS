---
name: memory-lite
description: Orient a user to the current Workflow OS context in ChatGPT Work or Codex without creating, querying, or updating a separate memory store. Use when the user asks what WOS knows, wants to resume deliberately, or needs an explicit handoff option.
---

# `$memory-lite` — Orient to WOS Context

WOS Memory Lite supplements the native memory of the active surface; it does not replace, duplicate, export, or programmatically manage it. It is available in ChatGPT Work and Codex, but each surface supplies its own native context and tools.

## Operating model

- **Native memory and the current conversation** hold personal preferences, working style, and conversational continuity. In ChatGPT Work, this is the account/workspace memory and the current chat or Project. In Codex, this is Codex's native memory and current conversation.
- **Jira** is the source of truth for active shared work.
- **`WOS.md`** is an optional, small project locator in a Codex workspace. In ChatGPT Work, use it only when the user has supplied it as a file or source.
- **`local.json` active_project / active_task** are optional Codex-local pointers only. They are not task or project histories and must never be assumed to exist in ChatGPT Work.
- **Handoffs are explicit.** Do not create a file, comment, or summary unless the user asks for one and confirms its destination when a write is required.

## Step 1 — Orient read-only

Use the current conversation and native memory already available to you. In Codex, if the current directory or one of its parents contains `WOS.md`, read only that marker; if useful, read local active pointers through the documented project/task helper scripts. In ChatGPT Work, use the current Project's permitted files, instructions, and connected sources; do not assume access to a local workspace, `WOS.md`, or `local.json`.

Report at most five bullets: available workspace/project locator, linked Jira key, available active project/task pointer, relevant context already available, and the best next step. Use only the Jira connector or tool available in the active surface. Do not invent missing context. Do not search a legacy database, start an MCP server, or install dependencies.

## Step 2 — Offer an explicit handoff only when useful

When continuity must survive a chat change, a different person, or a deliberate pause, offer these destinations in order:

1. **Chat-only recap** — no write.
2. **Jira-ready update draft** — show it for review; post only after current-turn confirmation.
3. **Compact `WOS.md` handoff** — only in a writable Codex workspace, and only after the user confirms the exact text. In ChatGPT Work, offer this only when the user has explicitly supplied a writable project file. Keep it to current objective, blocker, next action, and dated links; never add a transcript.

Never write automatically at session start, session end, or task/project completion.

## Hook policy

Memory Lite intentionally registers no hooks. Dependency checks, database startup, automatic summaries, and automatic resumption are outside its scope. If a pilot later needs a hook, it must be read-only, silent when no marker exists, complete in under one second, and never depend on another service.
