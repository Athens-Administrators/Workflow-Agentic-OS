# Workflow OS — Core Engine Manual

Workflow OS is a Codex-native plugin host that adds workflow structure without replacing Codex memory.

## Architecture

- **Native Codex memory and the active chat** are primary for preferences and conversational continuity.
- **Jira** is the active-work source of truth for shared projects, tasks, status, ownership, and dependencies.
- **`WOS.md`** is an optional compact workspace locator, not a knowledge base or session log.
- **`local.json`** holds setup data and optional `active_project` / `active_task` pointers only.
- **Memory Lite** provides explicit, read-only orientation and handoff guidance. It has no SQLite database, MCP server, runtime dependency, or hooks.

`workflow-os` is the shareable framework repository. `workflow-os-data` is private local setup and pointer state. OneDrive backup is recorded separately as `onedrive_backup`.

## Plugin lifecycle

Plugins use the Codex contract: manifests, skills, optional hooks, and optional MCP servers. The marketplace is `.agents/plugins/marketplace.json`; `/plugins` is authoritative for installed and enabled plugins.

Project and Task are explicit workflows. They do not register SessionStart or Stop hooks, automatically resume work, write session summaries, or create a hidden continuity store.

Use `$memory-lite` when a user asks to orient to WOS context. It may read a nearby `WOS.md`, the current conversation, native memory already available to Codex, and optional local pointers. It never creates a record automatically.

## Project and task continuity

`$project-new` and `$project-import` may write a minimal `WOS.md` after confirmation, then optionally set `active_project`. `$project-resume` uses a user-named workspace or Jira key for deliberate orientation.

`$task-new`, `$task-agenda`, and `$task-resume` use the current conversation, optional Jira reads, and an optional `active_task` pointer. They do not persist a task database.

When durable continuity is needed, provide a user-requested chat recap, Jira-ready draft, or compact `WOS.md` handoff. A Jira write still requires explicit confirmation in the current turn.

## Hooks

Memory Lite v1 has no hooks. Any future hook must be read-only, silent without relevant context, complete quickly, require no external service or runtime installation, and never create a summary, pointer update, Jira write, or filesystem write.

## Disaster recovery

DR snapshots cover the WOS sentinel, local setup/pointers, plugin versions, and WOS project-marker inventory. They intentionally do not attempt to restore private Codex chats, Codex memory, or a retired local memory database.

## Conventions

- Read configured paths from `local.json`; do not hardcode user paths.
- Use PowerShell only for setup and small local-pointer helpers.
- Do not persist secrets, tokens, or copied sensitive records.
- Use Atlassian Rovo first for Jira; use `acli` as the deterministic fallback under the same confirmation and delete/archive policy.
