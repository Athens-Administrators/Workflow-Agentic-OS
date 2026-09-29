# Workflow OS — Safety Boundaries

These rules are non-negotiable. They apply regardless of plugin, project, user preference, or sandbox mode. Plugins MUST NOT register hooks that bypass them.

## 1. External services

### Jira (Atlassian Rovo app connector + Atlassian CLI)

- **Read**: always allowed through Atlassian Rovo or `acli` (`_search`, `_fetch`, `acli jira workitem view`, comment listing, transition lookup, etc.).
- **Write**: allowed *per-action* with explicit user confirmation in the current turn. Authorization does not carry across turns. The mandatory Workflow OS Jira-emoji format applies to all writes (see `plugins/jira/references/emoji-format.md`). Use Rovo first; use `acli` as the deterministic fallback/companion when Rovo is unavailable or lacks the needed operation.
- **Delete/archive**: **blocked for agents across all Jira tool paths**. Delete and archive operations (`delete_issue`, `delete_comment`, `delete_link`, `archive_issue`, `acli jira workitem delete`, `acli jira workitem archive`, comment deletes, etc.) cannot be called by any skill, hook, or subagent. Deletes stay with the user — they perform them manually in Jira.
- **Agent self-cleanup exception**: the agent may delete an artifact it itself created in error during the current turn (single bad comment, wrong subtask) with explicit user confirmation. No other auto-delete pathway exists.

### GitHub

- No pushes, no force operations, no PR merges without explicit per-action confirmation.

### OneDrive

- Writes only to the designated `onedrive_backup` folder. Never write outside it.

### Email / Slack / Teams

- No automated sends. Drafts only, surfaced to the user.

## 2. Filesystem

- No recursive deletes outside `<data_root>` and `<framework_root>` without confirmation.
- On Windows OneDrive paths, directory removal uses `cmd /c rd /s /q` via subprocess. Never `shutil.rmtree` directly.
- Do not create or update a WOS-owned memory vault, database, or automatic session log. Legacy data remains untouched unless the user explicitly requests a migration or removal plan.

## 3. Secrets

- Never persist credentials, tokens, or API keys to memory notes, logs, or commits.
- Never include secrets in URL parameters.
- If a secret appears in a tool output, redact it before any further processing.

## 4. Memory Lite and handoffs

- Native Codex memory is primary. Workflow OS must not create a second memory store.
- A `WOS.md` handoff is an explicit user-requested filesystem write: show the proposed compact text and receive confirmation before writing.
- Hooks must not create summaries, pointers, Jira updates, or files.

## 5. Codex hooks

- Hooks may not invoke destructive operations without user confirmation in the same turn.
- Hooks may not auto-commit, auto-push, or auto-send messages.
- A hook that fails must not block the session — it logs the failure and yields.

## 6. Sandbox modes do not bypass tool policy

- Tool allow-lists and Workflow OS safety boundaries (e.g. the Jira no-delete/no-archive rule above) apply in **every** sandbox mode, including `danger-full-access`.
- Sandbox mode governs filesystem and command execution. MCP tool access is enforced at the MCP boundary, and CLI usage remains governed by Workflow OS policy.
- Elevating sandbox does not unlock Jira deletes/archive, GitHub force-push, or any other policy-gated action. Those gates only move by deliberately editing the explicit policy — deliberate, auditable.
