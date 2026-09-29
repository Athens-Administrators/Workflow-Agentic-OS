---
name: project-resume
description: Explicitly orient to or switch a Workflow OS project using a user-named workspace, WOS.md locator, and native Codex memory. Jira is read only when the project is Jira-linked and the user wants it.
---

# `$project-resume` — Resume a Project Deliberately

Ask for the workspace path or project slug if it is not already clear. Prefer a nearby `WOS.md`; when there is no marker, ask for enough current context to proceed. Do not enumerate old projects from a database.

Read the marker and current conversation/native memory already available. Treat a missing `tracking` field as Local. Honor its tracking mode: offer a live Jira read only for a Jira-linked project, and offer an external-tracker-ready draft only for an external project. Then, if the user approves the local selection, set `active_project` through `${plugin_root}/scripts/active-project.ps1 -Set <slug>`.

Report at most five bullets: project, workspace, Jira status if read, known blocker, and recommended next action. Do not take action beyond orientation.

For durable continuity, offer an explicit chat recap, a draft for the selected tracker, or a compact `WOS.md` handoff. Do not create any record automatically.
