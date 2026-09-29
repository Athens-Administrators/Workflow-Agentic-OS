# Workflow OS Setup for ChatGPT Work Local

Use this guide for teammates who will use **ChatGPT Work in the ChatGPT desktop app** instead of Codex.

This is not the full Codex Workflow OS install. It does not use the Codex CLI, PowerShell setup scripts, local Workflow OS plugins, local SQLite receipts, or WOS DR snapshots.

The goal is simpler: help the teammate use ChatGPT Work Local with local files, approved plugins, Jira, Confluence, and the Workflow OS way of working.

## When To Use This

Use this path when the teammate says:

1. I use ChatGPT, not Codex.
2. I need ChatGPT to work with files on my computer.
3. I need help with Jira, Confluence, SharePoint, Outlook, Teams, Zoom, or local documents.
4. I want simple guided setup, not developer setup.
5. Other / In Addition - I may use both ChatGPT Work and Codex.

If they use Codex, use `docs/wos-colleague-controlled-auto-install.md` instead.

## Human Prep

Before starting, confirm:

1. The teammate has the ChatGPT desktop app installed.
2. They are signed into the correct work account.
3. Their workspace allows ChatGPT Work.
4. Their workspace allows **Work locally** in the desktop app.
5. Their workspace allows plugins/connectors needed for their role.
6. Other / In Addition - an admin may need to enable something first.

## What This Setup Should Enable

Target capabilities:

1. ChatGPT Work Local for local file work.
2. Computer Use for approved desktop apps.
3. Browser access for websites and web apps.
4. Jira or Atlassian access.
5. Confluence access, or Company Knowledge if Confluence is available there.
6. SharePoint and OneDrive access.
7. Outlook Email and Outlook Calendar access.
8. Teams access, if available.
9. Zoom access, if available.
10. Other / In Addition - role-specific tools the teammate uses.

Actual availability depends on the ChatGPT workspace, workspace admin settings, the teammate's account permissions, and each app's connection flow.

## Plugin Choice In ChatGPT Work

ChatGPT Work should give the teammate a plugin-style choice when the workspace supports it:

1. WOS Jira / Documentation style only.
2. WOS Project-style workflow, if available for ChatGPT Work.
3. WOS Task-style workflow, if available for ChatGPT Work.
4. Zoom Chat Pull, if available and approved.
5. Zoom Clips Pull, if available and approved.
6. Security-review tooling, if available and approved.
7. Other / In Addition - help me choose.

If a plugin is Codex-only or is not available in ChatGPT Work yet, say that clearly and use the Workflow OS rules as instructions instead of pretending the plugin is installed.

## Can This Be A Plugin?

Yes, the long-term Workflow OS pattern can be a **ChatGPT Work plugin** or a plugin-bundled skill, because ChatGPT and Codex can both use plugins and skills on supported surfaces.

Recommended rollout order:

1. Start with this Markdown guide and prompt.
2. Turn the stable instructions into a Workflow OS ChatGPT Work skill.
3. Package the skill as a plugin if teammates should install it from the plugin directory.
4. Create a shared Workspace Agent if you want a managed assistant with approved apps, shared instructions, scheduled runs, and a simple teammate-facing entry point.
5. Other / In Addition - use both a plugin and a Workspace Agent if the workflow grows.

For right now, the best practical path is this guide. The best managed path later is a Workspace Agent.

## Question Style

ChatGPT should ask setup questions this way:

1. Ask one question at a time.
2. Use numbered multiple choice.
3. Use plain language.
4. Keep wording at a late high school to early college reading level.
5. Put `Other / In Addition` last when the answer may not fit the choices.
6. Let the teammate answer with a number, short phrase, or both.
7. If the teammate chooses `Other / In Addition`, ask one short follow-up question.

## Prompt To Paste Into ChatGPT Work Local

Paste this into a new ChatGPT Work task in the ChatGPT desktop app:

```text
Please help me set up Workflow OS habits for ChatGPT Work Local.

Use ChatGPT Work in the desktop app. Keep Work locally selected because I may need you to work with files, apps, or browser pages on this computer.

Goal:
- Help me use ChatGPT Work for Jira, Confluence documentation, local files, and approved work tools.
- Use Workflow OS rules for Jira and documentation.
- Ask simple numbered questions when you need my input.
- Do not do developer setup unless I specifically ask for Codex.

This is not Codex setup:
- Do not install Codex CLI.
- Do not clone the Workflow OS repo unless I ask for Codex setup.
- Do not run PowerShell setup scripts.
- Do not set up local Workflow OS SQLite memory.
- Do not set up WOS DR snapshots.

Question style:
- Ask one setup question at a time.
- Every setup question must be numbered multiple choice.
- Use plain, non-technical language.
- Add "Other / In Addition" as the last choice when the listed answers may not cover my situation.
- Let me answer with a number, short phrase, or both.
- If I choose "Other / In Addition," ask one short follow-up question.

First question:
Which setup path should we use?
1. ChatGPT Work Local only - I do not plan to use Codex right now.
2. ChatGPT Work Local first, Codex later.
3. Both ChatGPT Work Local and Codex.
4. Other / In Addition - I need help choosing.

Ask me these before saving or assuming anything:
- Display name.
- Role or position.
- Team.
- Leadership level or focus, if relevant.
- Work style preference.
- Apps and platforms I use.
- Jira projects beyond ASD and TPM.
- Main Jira use.
- Documentation route or audience.
- Whether you can connect to an app.
- Whether you can read or edit a local file.
- Any external write or send action.

Suggested role choices:
1. Help Desk - I mainly help users with tickets and support requests.
2. IT Operations - I help keep systems and daily IT work running.
3. System Administration - I manage servers, accounts, systems, or technical settings.
4. Project Management - I track projects, timelines, handoffs, and status.
5. Development / DBA - I work on code, databases, applications, or Azure Boards work.
6. IT Leadership - I review work, decisions, priorities, staffing, or status.
7. Other / In Addition - my role is different or covers more than one area.

Suggested app/platform choices:
1. Jira and Confluence only.
2. Jira, Confluence, SharePoint, and OneDrive.
3. Jira, Confluence, Outlook Email, and Outlook Calendar.
4. Jira, Confluence, Teams, and Zoom.
5. All of these if available: Jira, Confluence, SharePoint, OneDrive, Outlook Email, Outlook Calendar, Teams, Zoom, Browser, and Computer Use.
6. Other / In Addition - I use another tool or I am not sure.

Suggested plugin choices:
1. WOS Jira / Documentation style only.
2. WOS Project-style workflow, if available for ChatGPT Work.
3. WOS Task-style workflow, if available for ChatGPT Work.
4. Zoom Chat Pull, if available and approved.
5. Zoom Clips Pull, if available and approved.
6. Security-review tooling, if available and approved.
7. Other / In Addition - help me choose.

If a plugin is Codex-only or is not available in ChatGPT Work yet, say that clearly and continue with the Workflow OS rules as instructions.

Setup checks:
1. Confirm ChatGPT Work is available.
2. Confirm Work locally is selected.
3. Confirm Computer Use is available if local app control is needed.
4. Confirm Browser is available if web pages are needed.
5. Confirm plugins/connectors are available for the tools I use.
6. Ask me before connecting or authorizing any app.

Jira rules:
- Jira is the active-work source of truth.
- Jira reads are allowed when I have access.
- Jira writes require my explicit approval in the current turn.
- Jira delete/archive operations are blocked for agents.
- Do not store secrets or sensitive ticket details in memory.
- Default Jira tenant: https://athensadmin.atlassian.net
- Common baseline projects:
  - ASD - main IT ticketing system.
  - TPM - IT project management board.
- Ask before adding any extra Jira project.
- For ASD ticket creation, ask whether it is AI Gen Issue or AI Gen Request and verify the available type before writing.
- For project boards such as TPM, AJD, GPT, HMB, or infrastructure boards, use Epic, Task, and Subtask logic rather than ASD service-desk ticket rules.

Documentation rules:
- Confluence is the system of record for published documentation.
- Route first:
  1. Help Desk - user support or support-team documentation.
  2. Infrastructure - systems, servers, access, or operations documentation.
  3. DEV/DBA - development, database, application, or technical delivery documentation.
  4. Public-facing for Athens employees - instructions meant for general Athens employees.
  5. Other / In Addition - I am not sure where this belongs.
- For Infrastructure docs, ask whether the document is:
  1. Runbook KB article - steps for fixing, checking, or operating something.
  2. Business Process KB article - how a process, handoff, or workflow works.
  3. Other / In Addition - I am not sure.
- For DEV/DBA docs, use the configured route template and record the owning team; its document-type model is pending team confirmation.
- Resolve route, template, Confluence space, and parent/root placement before publishing.
- Confluence reads are allowed when I have access.
- Confluence creates and updates require my explicit approval in the current turn.

Documentation defaults:
- Help Desk and public-facing: HelpDesk Knowledge / HK
- Infrastructure internal: Internal Infrastructure KB / IIK
- DEV/DBA internal: Dev Team KB / DTK
- Employee-facing Infrastructure or DEV/DBA content: HelpDesk Knowledge / HK, with the owning team recorded
- Public how-to template: ahi_how_to
- Help Desk troubleshooting template: ahi_troubleshooting
- Infrastructure Business Process KB template: infra_dev_standard
- Infrastructure Runbook KB template: infra_dev_break_fix_runbook

Memory and continuity:
- Use Jira for active work status.
- Use Confluence for published documentation.
- Use ChatGPT project instructions, shared agent instructions, and ChatGPT memory when available for personal working preferences.
- Do not treat memory as the official record.
- If a fact matters for work, verify it from Jira, Confluence, a connected app, or a file I provide.

Local file rules:
- Ask before reading folders with personal or sensitive content.
- Ask before editing a file.
- Tell me which file you changed.
- Keep changes narrow and easy to review.
- Do not delete files unless I clearly ask and confirm.

Final setup summary:
At the end, summarize:
1. Which setup path we chose.
2. Which apps/plugins/connectors are available.
3. Which apps still need admin help or user sign-in.
4. My Jira defaults.
5. My documentation defaults.
6. Any limits or safety notes I should remember.
```

## Plugin And Agent Direction

The future product shape should be:

1. **ChatGPT Work skill** - the reusable WOS instructions and question style.
2. **ChatGPT Work plugin** - the packaged skill plus any approved connectors or MCP tools.
3. **Workspace Agent** - the shared teammate-facing assistant for repeatable WOS work.
4. **Codex full install** - only for people who need repo work, local scripts, hooks, DR snapshots, or developer workflows.
5. Other / In Addition - mixed setup for power users.

## Practical Recommendation

For the next colleague, start with this Markdown guide in ChatGPT Work Local.

If it works smoothly for two or three teammates, package the stable behavior as either:

1. A ChatGPT Work plugin if the main need is reusable instructions and tools.
2. A Workspace Agent if the main need is a shared assistant with simple access, approved apps, and repeatable setup.
3. Both, if the plugin provides the tools and the Workspace Agent provides the friendly front door.
