# WOS Memory Lite v1.1

## Purpose

WOS Memory Lite gives Workflow OS projects and tasks a small amount of explicit structure while keeping the active surface's built-in memory primary. It is not a replacement memory system.

## Boundaries

| Concern | Authority |
|---|---|
| Preferences and conversation continuity in Codex | Native Codex memory and the active chat |
| Preferences and conversation continuity in ChatGPT Work | Workspace/account memory and the current chat or Project |
| Shared active work | Jira |
| Workspace identity | Optional `WOS.md` marker in Codex; an explicitly supplied file/source in ChatGPT Work |
| Current local selection | `active_project` / `active_task` pointers in Codex `local.json`; unavailable unless supplied in ChatGPT Work |
| Cross-chat or cross-person handoff | User-requested recap, Jira update, or compact `WOS.md` handoff |

## Non-goals

- No SQLite database, FTS index, MCP server, background service, or dependency installer.
- No automatic session summary, checkpoint, or context restoration.
- No hidden replica of Codex memory.
- No automatic Jira or filesystem writes.
- No assumption that a Codex-local file, CLI, or connector exists in ChatGPT Work.

## Hook standard

v1.1 has no hooks. ChatGPT Work does not support plugin script hooks in cloud-orchestrated Work, so hooks cannot be the cross-surface mechanism. A future Codex-only hook may only surface an optional read-only workspace hint. It must be silent without a `WOS.md` marker, must not call external services or install dependencies, and must always leave workflow actions to an explicit skill or user request.
