---
name: project-complete
description: Close out an active Workflow OS project with an explicit chat summary, an optional selected-tracker closeout draft, and active-pointer clearing. It does not write a separate memory history.
---

# `$project-complete` — Close Out a Project

Resolve the active project and confirm that the user intends to close it. Use `WOS.md` and current conversation context; read Jira only when the project is Jira-linked and useful. Do not search a memory database.

Prepare a concise closeout summary: delivered outcome, final decision/deferred work, links, and recommendation. For a Jira-linked project, offer a Jira-ready ✅ closeout comment and any available transition; for an external project, offer copy-ready closeout text. Show the exact Jira write manifest and obtain explicit current-turn confirmation before posting or transitioning.

After the user confirms closeout, clear `active_project` with `${plugin_root}/scripts/active-project.ps1 -Set ""`. Leave `WOS.md` in place unless the user explicitly asks to change it. Offer an optional compact handoff only if there is active follow-up work.

Never create automatic memory records or delete Jira items.
