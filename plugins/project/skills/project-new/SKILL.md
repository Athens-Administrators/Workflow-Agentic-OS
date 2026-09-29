---
name: project-new
description: Start or link a scoped Codex workspace with local-first continuity and optional Jira or external tracking. Use when the user wants a lightweight project layer without a separate memory system.
---

# `$project-new` — Start a Workflow OS Project

Use project mode for a scoped initiative with a workspace or an ongoing delivery outcome. It works for a new initiative or an existing user-named workspace. Route one-off work to `$task-new`.

## 1. Define the project

Ask for the workspace path, a short name, and a one-to-three-sentence description. If a nearby `WOS.md` already exists, read it and ask whether to reuse its slug; never overwrite it without confirmation. Derive a lowercase hyphenated slug (30 characters or fewer where practical) and confirm it before writing.

## 2. Choose tracking deliberately

Offer these choices, with **Local** as the default and **Jira-linked** as the recommended shared-work option:

1. **Local (default)** — use the current conversation, native memory, and an optional `WOS.md` locator. No tracker read or write.
2. **Jira-linked (recommended)** — use Jira for shared phases, status, ownership, blockers, and dependencies. Ask for an existing key, verify it read-only with Rovo first and `acli` as fallback, and draft any new item for current-turn approval.
3. **External** — keep the shared tracker outside WOS. Record only a user-supplied label or safe link in the locator; WOS produces copy-ready drafts and does not assume an integration.

Never create or update a Jira item merely because Jira was recommended.

## 3. Create the optional workspace locator

With confirmation, write `WOS.md` only in the chosen project workspace:

```markdown
---
project_slug: <slug>
tracking: <local|jira|external>
jira_key: <key-or-null>
tracking_link: <optional-safe-link-or-null>
workspace_path: <absolute path>
created: <ISO timestamp>
---

# <Project name>

<Short description>
```

Keep this file compact. It identifies the workspace and selected tracking approach; it is not a project log, transcript, or replacement memory store.

## 4. Set the local pointer

Ask whether to make the project active. If yes, call `${plugin_root}/scripts/active-project.ps1 -Set <slug>`. This only records the current local selection; it does not save project history.

## 5. Plan and execute

Invite the user to use `/plan` only when planning is useful. Offer `$project-orchestrate` only when the user wants an explicit collaboration or dependency review. For Jira-linked projects, show a Jira write manifest for any phase items or dependencies and execute only after explicit current-turn confirmation.

## Continuity rule

Use the current conversation and native Codex memory for continuity. For a cross-chat or cross-person handoff, offer a chat recap, tracker-ready draft that matches the selected mode, or a compact `WOS.md` handoff only when the user explicitly asks.

## Hard rules

- No automatic hooks, session summaries, databases, or MCP memory calls.
- No Jira write without explicit current-turn confirmation.
- No secrets in `WOS.md` or Jira.
- No deletes.
