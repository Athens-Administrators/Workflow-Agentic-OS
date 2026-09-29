---
name: project-complete
description: Close out an active Workflow OS project with an explicit chat summary, optional Jira closeout draft, and active-pointer clearing. It does not write a separate memory history.
---

# `$project-complete` — Close Out a Project

Resolve the active project and confirm that the user intends to close it. Use `WOS.md`, current conversation context, and a live Jira read where available; do not search a memory database.

Prepare a concise closeout summary: delivered outcome, final decision/deferred work, links, and recommendation. If a Jira key exists, offer a Jira-ready ✅ closeout comment and any available transition. Show the exact write manifest and obtain explicit current-turn confirmation before posting or transitioning.

After the user confirms closeout, clear `active_project` with `${plugin_root}/scripts/active-project.ps1 -Set ""`. Leave `WOS.md` in place unless the user explicitly asks to change it. Offer an optional compact handoff only if there is active follow-up work.

Never create automatic memory records or delete Jira items.
