# WOS Memory Lite v1

## Purpose

WOS Memory Lite gives Workflow OS projects and tasks a small amount of explicit structure while keeping Codex's built-in memory primary. It is not a replacement memory system.

## Boundaries

| Concern | Authority |
|---|---|
| Preferences and conversation continuity | Native Codex memory and the active chat |
| Shared active work | Jira |
| Workspace identity | Optional `WOS.md` marker |
| Current local selection | `active_project` / `active_task` pointers in `local.json` |
| Cross-chat or cross-person handoff | User-requested recap, Jira update, or compact `WOS.md` handoff |

## Non-goals

- No SQLite database, FTS index, MCP server, background service, or dependency installer.
- No automatic session summary, checkpoint, or context restoration.
- No hidden replica of Codex memory.
- No automatic Jira or filesystem writes.

## Hook standard

v1 has no hooks. A future hook may only surface an optional read-only workspace hint. It must be silent without a `WOS.md` marker, must not call external services or install dependencies, and must always leave workflow actions to an explicit skill or user request.
