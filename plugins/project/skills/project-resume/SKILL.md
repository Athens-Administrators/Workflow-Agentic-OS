---
name: project-resume
description: Explicitly orient to or switch a Workflow OS project using a user-named workspace, WOS.md locator, native Codex memory, and a live Jira read when linked. No automatic resume or separate memory store is used.
---

# `$project-resume` — Resume a Project Deliberately

Ask for the workspace path or project slug if it is not already clear. Prefer a nearby `WOS.md`; when there is no marker, ask the user for the Jira key or enough context to proceed. Do not enumerate old projects from a database.

Read the marker and current conversation/native memory already available. If a Jira key exists, offer a live read using Rovo first and `acli` as fallback. Then, if the user approves the local selection, set `active_project` through `${plugin_root}/scripts/active-project.ps1 -Set <slug>`.

Report at most five bullets: project, workspace, Jira status if read, known blocker, and recommended next action. Do not take action beyond orientation.

For durable continuity, offer an explicit chat recap, Jira-ready update draft, or compact `WOS.md` handoff. Do not create any record automatically.
