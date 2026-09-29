# WOS Memory Lite v1 — Team Pilot

## Purpose

Validate that Workflow OS Project and Task complement native Codex memory without creating a second memory system or running background lifecycle hooks.

## Install scope

Install from the `workflow-os` marketplace through `/plugins`:

- `wos-memory-lite` v1.0.0
- `wos-project` v1.0.0 (optional)
- `wos-task` v1.0.0 (optional)

Do not install `wos-memory-engine` for this pilot. It is retired from the marketplace and is not required by any Memory Lite v1 workflow.

If an existing machine already has `wos-memory-engine` installed, have its user remove that retired plugin in `/plugins`, then fully restart Codex before testing. Do not delete its legacy data folder during the pilot.

## Pilot scenarios

| Scenario | Expected result |
|---|---|
| Open Codex in an ordinary folder | No WOS dependency install, database activity, automatic resume, or hook error. |
| Run `$memory-lite` in a project workspace | A short read-only orientation based on the current chat/native memory and a nearby `WOS.md`, if present. |
| Run `$project-new` | The project can be started with a confirmed `WOS.md` locator and optional active-project pointer, without a database receipt. |
| Run `$project-resume` | The user names a workspace or Jira key; WOS reads the locator and optionally Jira, then gives a compact orientation. |
| Run `$task-agenda` | A useful task table appears in chat; no hidden local task database is created. |
| Run `$project-checkpoint` or `$task-checkpoint` | A handoff draft appears in chat first. Jira or `WOS.md` is changed only after the user explicitly chooses and confirms that destination. |
| Use a Jira-linked workflow | Jira reads remain available; every Jira write still requires a current-turn confirmation and the WOS emoji format. |

## What to report

Capture only actionable pilot feedback:

- Whether explicit orientation was enough to resume work.
- Whether a requested handoff had the right amount of detail.
- Missing context that should be available through a live Jira read or the project locator.
- Any background action, database expectation, or automatic-write behavior observed (all are defects).
- Any install, version, or hook error shown by Codex.

Do not include secrets, copied ticket content, customer data, or full chat transcripts in pilot feedback.

## Pilot exit criteria

- No Memory Engine dependency is required for Project or Task.
- No WOS Memory Lite lifecycle hook runs.
- All pilot scenarios produce the expected result.
- At least one pilot participant can complete a project and task handoff without losing meaningful operational context.
- Jira write safeguards remain intact.
