---
name: project-orchestrate
description: Review a project's dependencies or collaboration plan when the user explicitly asks. Local work stays linear by default; Jira, external tracking, and parallel delegation are optional.
---

# `$project-orchestrate` — Plan Collaboration Deliberately

Use this skill only when the user wants a dependency review, collaboration plan, or deliberate parallel-work decision. It is not required for normal project work and does not replace `$project-new`.

Load `${plugin_root}/references/orchestration-policy.md` and follow it. For a Jira-linked project, load `${plugin_root}/../jira/references/emoji-format.md` before drafting Jira descriptions or comments and `${plugin_root}/../jira/references/jira-tooling.md` before choosing Jira tooling.

## 1. Confirm the visible plan and tracking mode

Resolve the active project with `${plugin_root}/scripts/active-project.ps1`. If no project is active, ask for the workspace or route the user to `$project-new` or `$project-resume`.

Read the nearby `WOS.md` when present. Treat `tracking: local` as the default. For `tracking: jira`, offer a live Jira read using the tooling order in `jira-tooling.md`; for `tracking: external`, use only the user-provided context. Do not require a tracker to continue.

Use the confirmed current-chat plan, plus the selected tracker only when available. Identify phase titles, dependencies and blockers, likely file/system ownership, and any missing information that prevents safe parallel work. Do not infer hidden dependencies optimistically.

## 2. Present a proportionate plan

Default to a concise linear plan. If independent work is plausible, show a compact graph before asking whether the user wants parallel work:

```text
Phase 1: <title>
  -> must run first because <evidence>

Phases 2 and 3: <titles>
  -> can run in parallel only if <separate files/systems and verification>

Integration: <title>
```

For each phase, state only why it is safe or unsafe to parallelize and which files or systems it can affect.

## 3. Prepare the selected tracker only when needed

For a Jira-linked project, if Jira needs updates before implementation, show a current-turn write manifest for creates, description changes, links, transitions, or comments. Use the WOS emoji format and execute only the approved listed writes. For an external tracker, provide copy-ready text only.

Deletes are blocked. If cleanup is needed, tell the user what to remove manually in Jira.

## 4. Proceed or stay linear

Ask whether to proceed with the proposed collaboration plan. If the user approves, wait for a separate explicit implement instruction before dispatching work. If not, continue with normal single-thread work. Do not create a record of this choice unless the user asks for a handoff.

## 5. Optional implementation dispatch and integration

When the user explicitly asks to implement, delegate only approved, independent work. Use isolated worktrees for parallel file-changing work in a Git workspace; use session-only execution for read-only work. Do not delegate unresolved dependencies, conflicting file ownership, manual authorization, unclear boundaries, or production changes without a rollback plan.

Give every delegated stream its scope, allowed tracker action scope, and a concise handoff requirement: outcome, files/systems changed, verification, blockers, and recommended next step. For Jira-linked work, subagents may post comments only on their assigned Jira item after current-turn manifest approval; parent updates, descriptions, links, and transitions remain with the orchestrator.

Review handoffs, inspect diffs where applicable, run verification, and resolve conflicts. Do not declare completion while verification is unresolved. After integration, produce a final synthesis and offer an explicit handoff in the selected destination.

## Hard rules

- No mandatory tracker or automatic implementation.
- No parallel implementation before the user approves the collaboration plan and explicitly asks to implement.
- No delegated deletes.
- No Jira write outside an approved manifest.
- No secrets in tracker drafts, handoff packets, or `WOS.md`.
