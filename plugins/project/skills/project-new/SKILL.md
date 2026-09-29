---
name: project-new
description: Start a scoped Workflow OS project using an optional WOS.md locator, a local active-project pointer, native Codex memory, and Jira for shared active work. No separate memory engine is required.
---

# `$project-new` — Start a Workflow OS Project

Use project mode only for a scoped initiative with phases, a workspace, or an ongoing delivery outcome. Route one-off work to `$task-new`; route an existing workspace to `$project-import`.

## 1. Define the project

Ask for a short name and one-to-three-sentence description. Derive a lowercase hyphenated slug (30 characters or fewer where practical) and confirm it before writing.

## 2. Link Jira deliberately

Ask for an existing Jira epic or project-level ticket. Verify an existing key with Rovo first and `acli` as fallback. If a new Jira item is needed, draft it in the WOS Jira format and obtain explicit current-turn confirmation before creating it.

Jira is the shared active-work source of truth. Record its key in the project marker when one exists.

## 3. Create the optional workspace locator

With confirmation, write `WOS.md` only in the chosen project workspace:

```markdown
---
project_slug: <slug>
jira_key: <key-or-null>
created: <ISO timestamp>
---

# <Project name>

<Short description>
```

Keep this file compact. It identifies the workspace and Jira link; it is not a project log, transcript, or replacement memory store.

## 4. Set the local pointer

Ask whether to make the project active. If yes, call `${plugin_root}/scripts/active-project.ps1 -Set <slug>`. This only records the current local selection; it does not save project history.

## 5. Plan and execute

Invite the user to use `/plan`. After a plan is visible, show a Jira write manifest for phase items and dependencies, then execute only after explicit current-turn confirmation. `$project-orchestrate` is available only after Jira reflects the approved phase structure.

## Continuity rule

Use the current conversation and native Codex memory for continuity. For a cross-chat or cross-person handoff, offer a chat recap, Jira-ready draft, or a compact `WOS.md` handoff only when the user explicitly asks.

## Hard rules

- No automatic hooks, session summaries, databases, or MCP memory calls.
- No Jira write without explicit current-turn confirmation.
- No secrets in `WOS.md` or Jira.
- No deletes.
