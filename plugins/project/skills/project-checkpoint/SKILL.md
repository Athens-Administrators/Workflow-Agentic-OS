---
name: project-checkpoint
description: Prepare a deliberate project handoff from the current conversation and selected tracking mode. It creates no automatic memory receipt; the user chooses chat, a tracker-ready draft, or WOS.md.
---

# `$project-checkpoint` — Create a Deliberate Project Handoff

Resolve the active project with `${plugin_root}/scripts/active-project.ps1` or ask for a workspace. Read a nearby `WOS.md`; read Jira only when the project is Jira-linked and it is useful.

Gather: current objective, phase/status, concrete blockers, next action, and relevant dated links. Produce a concise handoff in chat first.

Ask the user where it should live:

1. **Chat only** — no write.
2. **Tracker-ready update draft** — for Jira-linked projects, use the Jira emoji standard and post only after explicit current-turn confirmation; for external tracking, provide copy-ready text and do not assume a connector.
3. **Compact `WOS.md` handoff** — show the exact proposed text and update only after explicit confirmation. Replace no existing handoff section without confirmation.

Do not use a memory database, automatic summary, or background hook. Do not create a local substitute without the user's selected destination.
