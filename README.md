# Workflow OS v2 — Draft

A plugin-based agentic layer for Codex. Core plugin set: `onboarding`, `jira`, `wos-documentation`, plus optional `memory-lite`, `project`, and `task`. The repo IS the marketplace. For team installs, register it as a Git marketplace so `/plugins` can upgrade after changes are pushed.

The mandatory baseline after onboarding is `wos-jira`, `wos-documentation`, and `wos-dr`: Jira standardizes active work in Jira, Documentation standardizes Confluence-ready drafts/reviews/publishing, and DR provides OneDrive-backed WOS restore points. On a new Codex install, install `wos-onboarding` first and run `$welcome`; onboarding requires `$jira-setup`, `$documentation-setup`, and `$dr-setup` before it can finish. Memory/project/task/orchestration modules are optional for users who want deeper Workflow OS structure.

This is a clean-slate draft, staged for review before moving to the real `workflow-os` repo on the new machine.

## Layout

```
v2/
├── AGENTS.md                            global agent manual (→ ~/.codex/AGENTS.md)
├── bootstrap.ps1                        one-shot installer for new machines
├── scripts/install/                     preflight, prerequisite, and Codex setup helpers
├── templates/codex/                     deployable WOS Codex config template
├── docs/                                pilot install and Codex setup prompts
├── TRANSFER.md                          new-machine setup checklist
├── .agents/plugins/marketplace.json     lists the Workflow OS plugins for Codex's marketplace
├── .agent/
│   ├── system.md                        core engine manual
│   └── boundaries.md                    safety rails (→ ~/.codex/AGENTS.override.md)
└── plugins/
    ├── onboarding/                      first-run setup
    │   └── .codex-plugin/, skills/, hooks/, scripts/
    ├── memory-lite/                     native-memory companion; explicit orientation and handoffs
    │   └── .codex-plugin/, skills/, references/
    ├── jira/                            mandatory Athens IT Jira standard + Rovo/ACLI wrapper + emoji format
    │   └── .codex-plugin/, skills/, references/
    ├── wos-documentation/               mandatory Confluence documentation standard
    │   └── .codex-plugin/, skills/, references/
    ├── dr/                              mandatory OneDrive-backed disaster recovery snapshots
    │   └── .codex-plugin/, skills/, scripts/
    ├── project/                         project lifecycle + orchestration + selective import
        └── .codex-plugin/, skills/, scripts/
    └── task/                            one-off ticket task lifecycle
        └── .codex-plugin/, skills/, scripts/
```

## Design summary

- **Codex-native.** Manifests at `.codex-plugin/plugin.json`. Skills with `$<name>` invocation. Hooks at `hooks/hooks.json` using Codex's event names (`SessionStart`, `Stop`, etc.). MCP via `.mcp.json`.
- **Two repos.** `workflow-os` (framework + plugins, shareable) and `workflow-os-data` (local setup, active pointers, and backups, private). OneDrive is an optional backup/export target, not the primary data root.
- **Memory Lite.** Native Codex memory remains primary for preferences and conversational continuity. `wos-memory-lite` supplies explicit WOS context orientation and optional handoff guidance; it has no database, MCP server, dependency install, or automatic hooks.
- **Jira.** Jira is the active-work source of truth and the team-facing satellite: projects, tasks, phases, dependencies, status, assignment, and current action state live where the team already works. Workflow OS uses the Atlassian Rovo Codex app connector first, with Atlassian CLI (`acli`) as a deterministic fallback/companion for gaps such as comments. The `jira` plugin is standalone and layers the Athens IT Jira standard, Workflow OS policy, and the mandatory emoji format on top of both tool paths; deletes/archive stay manual.
- **Runtimes.** PowerShell is used for install and small local-pointer helpers. Memory Lite requires no background runtime.
- **Onboarding.** `$welcome` is role-tailored for Athens IT users, validates foundation tools, defaults Jira to ASD/TPM, requires `wos-jira`, `wos-documentation`, and `wos-dr` setup, lets users pick optional Memory Lite/project/task plugins, and records preferences.
- **Role-based tools.** Missing optional tools such as Azure DevOps/Azure Boards, AWS CLI/MCP, Microsoft Learn MCP/CLI, and Superpowers are not required on every machine. `$welcome` recommends them only when the selected teammate role or director focus needs them.
- **Platform discovery.** After minimum tools are satisfied, `$welcome` asks what other platforms the teammate uses, searches for matching CLIs and Codex MCP/app connectors, and records those as teammate-specific additions rather than global requirements.
- **Projects and tasks.** `$project-new` starts scoped project work, uploads the completed plan to Jira as phases, then `$project-orchestrate` can analyze Jira and propose dependency-aware execution before implementation. `$project-import` selectively imports one existing workspace folder and writes an optional `WOS.md` locator only there. `$task-agenda` manages a task table in the current Codex conversation from manual entries, meeting actions, and available email/ticket/calendar/Zoom sources, with optional user-configured Jira board sync. `$task-new` handles one-off tasks or Jira tickets without creating a project, and `$task-orchestrate` offers lightweight orchestration only when a task has independent streams. Durable handoffs are explicit, never automatic.
- **DR.** WOS-owned state → scheduled OneDrive-backed DR snapshots. DR v1 captures the WOS sentinel, local setup, active pointers, plugin versions, and project marker inventory. Restore covers WOS continuity, not private Codex chat/sidebar internals.

## Upgrade flow

For maintainers:

1. Commit and push Workflow OS changes to `main`.
2. Team members open `/plugins` and use **Upgrade** on the Workflow OS marketplace.

For machines still registered to a local path, switch once:

```powershell
codex plugin marketplace remove workflow-os
codex plugin marketplace add https://github.com/acasasAA/Workflow-Agentic-OS.git --ref main
```

After that, `/plugins` can upgrade from Git whenever `main` changes.

## Moving to a new machine

See [TRANSFER.md](TRANSFER.md). Short version:
1. Push v2/ contents to a private GitHub repo as `workflow-os`.
2. On the new machine: run `scripts/install/preflight.ps1`, then `scripts/install/setup-codex.ps1`, then open Codex and run `$welcome`.
