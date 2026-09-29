---
name: project-checkpoint
description: Prepare a deliberate project handoff from the current conversation and live Jira context. It creates no automatic memory receipt; the user chooses whether the result remains in chat, becomes a Jira draft, or is added to WOS.md.
---

# `$project-checkpoint` — Create a Deliberate Project Handoff

Resolve the active project with `${plugin_root}/scripts/active-project.ps1` or ask for a workspace/Jira key. Read a nearby `WOS.md` and Jira only when useful and authorized for read access.

Gather: current objective, phase/status, concrete blockers, next action, and relevant dated links. Produce a concise handoff in chat first.

Ask the user where it should live:

1. **Chat only** — no write.
2. **Jira-ready update draft** — display it; post only after explicit current-turn confirmation under the Jira emoji standard.
3. **Compact `WOS.md` handoff** — show the exact proposed text and update only after explicit confirmation. Replace no existing handoff section without confirmation.

Do not use a memory database, automatic summary, or background hook. Do not create a local substitute without the user's selected destination.
