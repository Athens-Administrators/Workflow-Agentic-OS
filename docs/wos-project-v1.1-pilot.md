# WOS Project v1.1 — Athens Admin Workspace Plugins Marketplace Pilot

## Purpose

Validate that WOS Project provides a lightweight, Codex-local project layer without forcing Jira, a database, background hooks, or multi-agent orchestration.

## Marketplace distribution

The Athens Admin Workspace Plugins Marketplace syncs this repository from GitHub. Publish only after the `main` branch contains the reviewed v1.1.0 release. In Codex, colleagues open `/plugins`, refresh or update the `workflow-os` marketplace, and install **wos-project** as an optional plugin.

Project is currently **Codex-local**. It uses `WOS.md` and the optional local `active_project` pointer, so it is not part of the ChatGPT Work pilot until a separate Work adapter exists.

## First-use choice

`$project-new` offers three tracking modes:

1. **Local (default)** — current chat/native memory and an optional compact `WOS.md`; no tracker call.
2. **Jira-linked (recommended)** — Jira becomes the shared view for phases, status, ownership, blockers, and dependencies. Reads are optional; writes still require a current-turn manifest and confirmation.
3. **External** — WOS uses a user-provided label or safe link and supplies copy-ready tracker updates without assuming an integration.

## Pilot scenarios

| Scenario | Expected result |
| --- | --- |
| Start a local project | A compact `WOS.md` is proposed only after confirmation. No Jira read/write, database activity, hook, or automatic summary occurs. |
| Start a Jira-linked project | Jira is recommended and used only after the user selects it. Each write is displayed in a current-turn manifest and confirmed. |
| Start an external-tracker project | The project stores only a safe label/link and offers copy-ready updates; it does not call an unconfigured external service. |
| Resume or checkpoint | Orientation is read-only; a handoff is chat-only, tracker-ready, or a confirmed `WOS.md` update. |
| Ask for orchestration | Work remains linear unless the user explicitly asks for a dependency review and then explicitly approves parallel implementation. |

## Pilot exit criteria

- `wos-project` v1.1.0 is visible from the synced marketplace and installs without a Memory Engine dependency.
- Local, Jira-linked, and external modes are understandable and remain opt-in.
- Jira safeguards are unchanged: reads are safe; writes need current-turn confirmation; delete/archive remains blocked.
- `$project-new`, `$project-resume`, `$project-checkpoint`, `$project-orchestrate`, and `$project-complete` work without lifecycle hooks or automatic records.
- `scripts/validate/Test-WosProject.ps1` and `scripts/validate/Test-WosMemoryLite.ps1` pass from the release checkout.
