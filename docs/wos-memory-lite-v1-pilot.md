# WOS Memory Lite v1.1 — Team Pilot

## Purpose

Validate that WOS Memory Lite complements native memory in Codex and ChatGPT Work without creating a second memory system or running background lifecycle hooks.

## Install scope

Install from the `workflow-os` marketplace through `/plugins`:

- `wos-memory-lite` v1.1.0
- `wos-project` v1.1.0 (optional)
- `wos-task` v1.1.0 (optional)

Do not install `wos-memory-engine` for this pilot. It is retired from the marketplace and is not required by any Memory Lite v1.1 workflow.

If an existing machine already has `wos-memory-engine` installed, have its user remove that retired plugin in `/plugins`, then fully restart Codex before testing. Do not delete its legacy data folder during the pilot.

For ChatGPT Work, a workspace administrator must import or sync the Workflow OS marketplace from GitHub and grant the pilot users access to the plugin. Test in a new ChatGPT Work chat or Project after installation.

## Pilot scenarios

| Scenario | Codex expected result | ChatGPT Work expected result |
|---|---|---|
| Open a normal workspace or chat | No WOS dependency install, database activity, automatic resume, or hook error. | No WOS dependency install, database activity, automatic resume, or hook error. |
| Invoke WOS Memory Lite | A short read-only orientation based on the current chat/native memory and a nearby `WOS.md`, if present. | A short read-only orientation based on workspace/account memory and the current chat or Project; it does not assume a local workspace. |
| Run `$project-new` | The project starts Local by default, with Jira offered as an optional recommended shared-work mode; a confirmed `WOS.md` locator and active-project pointer remain optional. | Not in scope for this Memory Lite pilot. |
| Run `$project-resume` | The user names a workspace; WOS reads the locator and only offers Jira for a Jira-linked project, then gives a compact orientation. | Not in scope for this Memory Lite pilot. |
| Run `$task-agenda` | A concise agenda brief appears in chat; no hidden local task database is created. | A concise agenda brief appears in chat; no local pointer is required. |
| Run `$project-checkpoint` or `$task-handoff` | A handoff draft appears in chat first. Jira or `WOS.md` is changed only after the user explicitly chooses and confirms that destination. | A handoff draft appears in chat first. Jira is changed only after the user explicitly chooses and confirms that destination. |
| Use a Jira-linked workflow | Jira reads remain available; every Jira write still requires a current-turn confirmation and the WOS emoji format. | Use only the workspace-approved Jira app or connector. Every Jira write still requires a current-turn confirmation and the WOS emoji format. |

## What to report

Capture only actionable pilot feedback:

- Whether explicit orientation was enough to resume work.
- Whether a requested handoff had the right amount of detail.
- Missing context that should be available through a live Jira read or the project locator.
- Any background action, database expectation, or automatic-write behavior observed (all are defects).
- Any install, version, or hook error shown by either app.

Do not include secrets, copied ticket content, customer data, or full chat transcripts in pilot feedback.

## Pilot exit criteria

- No Memory Engine dependency is required for Project or Task.
- No WOS Memory Lite lifecycle hook runs in either surface.
- All pilot scenarios produce the expected result.
- At least one pilot participant can complete a project and task handoff without losing meaningful operational context.
- Jira write safeguards remain intact.
