# WOS Controlled Setup for a Dev/DBA Director

> **Archived WOS 1.x guide.** Do not use these DR or Memory Engine instructions for a new install or upgrade. Use the Suite 2 Beta first-time or existing-install guide; legacy version references below are historical only.

Use this guide for a supervised first-time Workflow OS setup with a Dev/DBA Director or senior technical leader.

This setup is role/user agnostic. Do not copy another person's name, Windows username, local path, Jira projects, Azure Boards projects, database names, server names, or preferences.

## What This Setup Gives Them

After setup, the teammate should be able to:

1. Use Jira as the active-work source for Dev/DBA requests, project tracking, escalations, reviews, and decisions.
2. Use Confluence as the system of record for Dev/DBA documentation, runbooks, business process notes, and technical handoffs.
3. Use WOS DR with the recursive backup fix so backups do not scan their own backup folder.
4. Use Codex for local files, repo review, scripts, SQL notes, and documentation drafts.
5. Optionally use WOS Project for larger initiatives, phases, dependencies, and delivery checkpoints.
6. Optionally use WOS Task for follow-ups, meeting actions, and ticket-sized work.
7. Optionally use Azure Boards, SQL MCP, SharePoint, OneDrive, Outlook, Teams, Zoom, or other approved connectors when available.

## Human Prep

Before starting, confirm:

1. The teammate has Codex installed and signed in.
2. They can open the Workflow OS repository:
   `https://github.com/Athens-Administrators/Workflow-Agentic-OS`
3. They have Git installed.
4. They have Node.js LTS installed.
5. They have PowerShell 7 installed or available as `pwsh`.
6. They know which Jira projects and Azure Boards projects they regularly use.
7. They know whether they want SQL MCP installed now or later.
8. They have access to the work systems they normally use, such as Jira, Confluence, GitHub, Azure Boards, SQL Server, SharePoint, OneDrive, Outlook, Teams, Zoom, or Fathom.
9. Other / In Addition - an admin may need to enable access first.

## Important DR Note

This guide expects `wos-dr v0.1.2` or newer.

That version addresses the recursive backup issue by excluding the configured DR backup root from project marker and structure scans.

Plain version: if the backup folder is inside OneDrive, DR should not scan its own backup snapshots as if they were normal project folders.

During setup:

1. Prefer a narrow project root, such as a Codex projects folder, Dev/DBA work folder, or repo parent folder.
2. Do not choose the entire OneDrive folder as the project root if the DR backup folder is also inside OneDrive.
3. Confirm `wos-dr v0.1.2` or newer before creating the first real snapshot.
4. Run `$dr-status` after setup and check that the backup root is not also being scanned as a project root.
5. Ask before running `$dr-snapshot`.

## Prompt To Paste Into Codex

Paste this into a fresh Codex chat on the teammate's machine:

```text
Please install Workflow OS for the first time on this machine using controlled setup for a Dev/DBA Director or senior technical leader.

Repository:
https://github.com/Athens-Administrators/Workflow-Agentic-OS.git

Goal:
- Set up Codex for Workflow OS.
- Install and run WOS Onboarding.
- Prioritize the mandatory WOS baseline: wos-jira, wos-documentation, and wos-dr.
- Make sure wos-dr is v0.1.2 or newer so the DR recursive backup and path-length fixes are included.
- Keep the setup role/user agnostic.
- Do not install optional plugins unless I choose them.
- Do not configure database access or SQL MCP unless I choose it.

Controlled setup mode:
- You may automatically run read-only checks, discover or clone the repository, run preflight, add or refresh the Workflow OS marketplace, and continue through non-destructive setup steps.
- You may use safe machine-derived defaults, such as $env:USERPROFILE.
- You may propose Athens-wide defaults, such as the Jira tenant, ASD, TPM, and known Confluence route defaults.
- You must pause before answering personal, role-based, access-based, optional, database-related, leadership-related, or confirmation-gated questions.
- If a command prompts for an explicit confirmation word such as SETUP or INSTALL, stop and ask me to type it.

Question style:
- Ask one setup question at a time.
- Every setup question must be numbered multiple choice.
- Use plain language a non-technical teammate can understand, but include technical choices when they are useful.
- Keep explanations short.
- Add "Other / In Addition" as the last choice when the listed answers may not cover my situation.
- Let me answer with a number, a short phrase, or both.
- If I choose "Other / In Addition," ask one short follow-up question before deciding what to save.
- Do not ask open-ended setup questions unless they also include numbered choices.

Must ask me. Do not auto-answer these:
- Display name.
- Workflow OS username/profile name if it differs from my Windows username.
- Role or position.
- Team.
- Leadership focus.
- Main Dev/DBA work areas.
- Codex Work mode preference.
- Other platforms, apps, repositories, ticketing systems, databases, dashboards, or internal tools I use.
- Optional Workflow OS plugin selection.
- Jira project keys beyond ASD and TPM.
- Azure Boards project usage.
- SQL MCP install choice.
- Main Jira use.
- Whether sensitive, admin-only, confidential, finance, HR, student, database, or occasional Jira projects should be included.
- Documentation route, audience, template, and parent/root placement.
- DR backup cadence if I do not accept the weekly default.
- DR project root. Use a narrow projects or repo folder, not the whole OneDrive folder, if the backup folder is also inside OneDrive.
- Any authentication/login step.
- Any external write, including Jira writes, Confluence creates/updates, Git pushes, GitHub writes, database writes, email sends, or destructive operations.

Suggested role or position choices:
1. Dev/DBA Director - I lead development, database, application, reporting, or delivery work.
2. Development Lead - I guide code, application delivery, reviews, and releases.
3. DBA Lead - I guide database work, SQL Server, data quality, or database operations.
4. Technical Project Lead - I coordinate technical work, tickets, phases, and handoffs.
5. IT Leadership - I review priorities, staffing, status, decisions, and risk.
6. Individual Contributor - I mainly work directly on code, databases, or technical tickets.
7. Other / In Addition - my role is different or covers more than one area.

Suggested team choices:
1. DEV/DBA.
2. Development.
3. DBA / Data.
4. IT Leadership.
5. Infrastructure / Operations.
6. Project Management.
7. Other / In Addition - I am on another team or split between teams.

Leadership focus choices:
1. Delivery tracking - projects, phases, blockers, and status.
2. Technical quality - reviews, design decisions, standards, and risk.
3. Database operations - SQL Server work, data fixes, performance, and access.
4. Documentation - runbooks, process docs, technical notes, and handoffs.
5. Team coordination - follow-ups, meetings, assignments, and cross-team work.
6. A mix of leadership and hands-on technical work.
7. Other / In Addition - my focus is different or broader.

Main Dev/DBA work area choices:
1. Application development and code review.
2. Database support, SQL Server, and data troubleshooting.
3. Azure Boards, GitHub, releases, or deployment tracking.
4. Power BI, reporting, exports, or business data support.
5. Documentation, runbooks, standards, and process cleanup.
6. Project/status leadership and cross-team coordination.
7. Other / In Addition - my work covers something else too.

Codex Work mode:
1. For everyday leadership work - concise updates, tickets, docs, and summaries.
2. For technical review - more detail about code, SQL, repos, and risks.
3. For hands-on implementation - direct file edits, scripts, tests, and verification.
4. Other / In Addition - I want a different style.

Other apps and platforms:
1. Jira and Confluence only.
2. Jira, Confluence, GitHub, and Azure Boards.
3. Jira, Confluence, SQL Server, GitHub, and Azure Boards.
4. Jira, Confluence, SharePoint, OneDrive, Outlook, Teams, Zoom, and Fathom.
5. Jira, Confluence, SQL Server, GitHub, Azure Boards, SharePoint, OneDrive, Outlook, Teams, Zoom, and Fathom.
6. Other / In Addition - I use another tool, platform, or database.

Optional Workflow OS plugins:
1. Jira, Documentation, and DR only for now.
2. Add Memory Engine - keeps local receipt notes for decisions and outcomes.
3. Add Project - helps manage larger initiatives, phases, dependencies, and checkpoints. Also adds Memory Engine.
4. Add Task - helps manage meeting actions, follow-ups, and ticket-sized work. Also adds Memory Engine.
5. Add Azure Boards - only if I use Azure Boards or want Dev/DBA board support.
6. Add Zoom Chat Pull - only if available, approved, and needed for work-visible Zoom chats.
7. Add Zoom Clips Pull - only if available, approved, and needed for meeting clips or documentation source material.
8. Add SQL MCP - install separately after WOS baseline is done using the Data API Builder SQL MCP guide and a least-privilege read-only database identity.
9. Other / In Addition - I want help choosing.

Optional plugin dependency rules:
- `wos-project` and `wos-task` are independent optional plugins; recommend Jira for shared work but do not require it.
- Install wos-azure-boards only if I say I use Azure Boards or want it.
- Do not install Zoom Chat Pull, Zoom Clips Pull, SQL MCP, or other connectors unless they are available and I approve them.
- If a plugin or connector is not available on this machine, say so clearly and continue with the rest of setup.

SQL MCP choice:
1. Skip SQL MCP for now.
2. Install SQL MCP after WOS setup using the separate SQL MCP install guide.
3. Prepare only the checklist, but do not install or connect yet.
4. Other / In Addition - I need a different SQL setup.

Jira setup:
- Jira reads are allowed when I have access.
- Jira writes require my explicit approval in the current turn.
- Jira delete/archive operations are blocked for agents.
- Default Jira tenant: https://athensadmin.atlassian.net
- Common baseline projects:
  - ASD - main IT ticketing system.
  - TPM - IT project management board.
- Ask before adding any extra Jira project.
- Include a Jira project key only when I regularly create, update, review, report on, or search work in that project.
- If I am not sure, ask me for an example issue key, such as ABC-123, and help infer the project key.
- For ASD ticket creation, ask whether it is AI Gen Issue or AI Gen Request and verify the available type before writing.
- For project boards such as TPM, AJD, GPT, HMB, or infrastructure boards, use Epic, Task, and Subtask logic rather than ASD service-desk ticket rules.
- For Dev/DBA leadership work, prefer clear summaries, owner, priority, due date, blocker, risk, acceptance criteria, and next action.

Documentation setup:
- Confluence is the system of record for published documentation.
- Route first:
  1. Help Desk - user support or support-team documentation.
  2. Infrastructure - systems, servers, access, or operations documentation.
  3. DEV/DBA - development, database, application, automation, deployment, reporting, or technical delivery documentation.
  4. Public-facing for Athens employees - instructions meant for general Athens employees.
  5. Other / In Addition - I am not sure where this belongs.
- For DEV/DBA docs, ask whether the document is:
  1. Business Process KB article - repeatable process, ownership, handoff, or standard.
  2. Runbook KB article - break/fix, incident response, support procedure, or operational steps.
  3. Technical note - decision, design context, known limitation, or implementation notes.
  4. Other / In Addition - I am not sure which type fits.
- Use the configured DEV/DBA template and record the owning team; its document-type model is pending team confirmation. Use the Public-facing route for employee-facing content.
- Resolve route, template, Confluence space, and parent/root placement before publishing.
- Confluence reads are allowed when I have access.
- Confluence creates and updates require my explicit approval in the current turn.

Known documentation defaults:
- Help Desk and public-facing: HelpDesk Knowledge / HK
- Infrastructure internal: Internal Infrastructure KB / IIK
- DEV/DBA internal: Dev Team KB / DTK
- Employee-facing Infrastructure or DEV/DBA content: HelpDesk Knowledge / HK, with the owning team recorded
- Public how-to template: ahi_how_to
- Help Desk troubleshooting template: ahi_troubleshooting
- Infrastructure Business Process KB template: infra_dev_standard
- Infrastructure Runbook KB template: infra_dev_break_fix_runbook

Dev/DBA and database safety rules:
- Do not run database queries unless I approve the source, target database, and purpose.
- Do not make database changes unless I explicitly approve the exact operation.
- Do not store secrets, connection strings, passwords, tokens, API keys, or private credentials in notes, Jira, Confluence, memory, or Codex config.
- Treat finance, HR, student, legal, security, personnel, and confidential business data as sensitive.
- Do not claim a system is deployed, secure, backed up, tested, or production-ready unless there is real evidence.
- For security, deployment, SSDLC, SAST, DAST, penetration testing, encryption, monitoring, and audit questions, answer only from evidence.

DR setup rules:
- Install or update wos-dr to v0.1.2 or newer.
- The backup root must not be scanned as a project root.
- If the selected project root contains the backup root, exclude the backup root from marker and structure scans.
- Prefer a narrow project root such as:
  1. C:\Users\<current-user>\workflow-os
  2. C:\Users\<current-user>\Documents\Codex
  3. C:\Users\<current-user>\OneDrive - Athens\Documents\MS DEV
  4. C:\Users\<current-user>\source
  5. Other / In Addition - I will choose the folder.
- Do not choose the entire OneDrive folder as the project root if the backup root is also inside OneDrive.
- Ask me before creating the first snapshot.
- After setup, run $dr-status and tell me:
  - Installed wos-dr version.
  - Backup root.
  - Project root.
  - Whether the backup root overlaps the project root.
  - Whether a snapshot was created.

Install steps:
1. Confirm I can open this repository while signed into GitHub:
   https://github.com/Athens-Administrators/Workflow-Agentic-OS
   If I cannot open it, stop. I need repository access first.
2. Check required tools:
   codex --version
   git --version
   node --version
   pwsh --version
   If any required tool is missing, stop and tell me exactly what is missing.
3. Find or clone Workflow OS under:
   C:\Users\<current-user>\workflow-os\Workflow-Agentic-OS
   If no valid checkout exists, create C:\Users\<current-user>\workflow-os if needed and clone:
   git clone https://github.com/Athens-Administrators/Workflow-Agentic-OS.git C:\Users\<current-user>\workflow-os\Workflow-Agentic-OS
4. From the selected checkout, run:
   git pull --ff-only
5. Register or refresh the Workflow OS marketplace:
   codex plugin marketplace add https://github.com/Athens-Administrators/Workflow-Agentic-OS.git --ref main
   If the marketplace already exists, run:
   codex plugin marketplace upgrade workflow-os
6. From the selected checkout, run:
   pwsh -NoProfile -File .\scripts\install\preflight.ps1
7. If preflight reports missing required prerequisites or tracked local changes, stop and show only the blocker and fix.
8. If preflight is ready, run:
   pwsh -NoProfile -File .\scripts\install\setup-codex.ps1
   If the script asks for SETUP, ask me to type SETUP before continuing.
9. Fully close and reopen Codex.
10. Open /plugins.
11. Install only wos-onboarding from the workflow-os marketplace first.
12. Start a fresh Codex chat and run:
    $welcome
13. During onboarding, install the mandatory plugins:
    - wos-jira
    - wos-documentation
    - wos-dr
14. Confirm wos-dr is v0.1.2 or newer before running DR setup.
15. Finish mandatory setup flows before continuing:
    - $jira-setup
    - $documentation-setup
    - $dr-setup
16. Run:
    $dr-status
17. If DR status shows that the backup root overlaps a project root, stop and fix the project root before creating a snapshot.
18. Ask me before creating the first snapshot:
    $dr-snapshot
19. Ask me which optional plugins I want using the numbered optional plugin question above.
20. If I choose SQL MCP, use the separate SQL MCP install guide after WOS baseline verification is complete.

Expected plugin versions:
- wos-onboarding v0.1.9
- wos-jira v0.2.9 or newer
- wos-documentation v0.1.13
- wos-dr v0.1.2
- wos-project v1.1.0
- wos-task v1.1.0

Final verification:
- /plugins shows Workflow OS.
- wos-onboarding is installed.
- wos-jira, wos-documentation, and wos-dr are installed and setup-complete.
- wos-dr is v0.1.2 or newer.
- WOS DR has a backup root.
- WOS DR is not scanning its own backup folder.
- A first snapshot was created only after I approved it.
- Optional plugins were installed only if I selected them.
- Local paths use my Windows user profile, not someone else's.
- Jira and Confluence writes still require my approval.
- SQL MCP was skipped, prepared only, or installed according to my choice.
```

## Best Fit for a Dev/DBA Director

Recommended optional additions to consider:

1. `wos-project` - best for larger initiatives, phased delivery, dependency tracking, and status checkpoints.
2. `wos-task` - best for follow-ups, meeting actions, quick tickets, and recurring personal/team actions.
3. `wos-azure-boards` - best when Azure Boards is part of the Dev/DBA workflow.
4. SQL MCP - best when the teammate needs controlled SQL Server discovery or read-only data inspection from Codex.
5. SharePoint / OneDrive connector - best when technical docs, exports, or source notes live in Microsoft 365.
6. Outlook / Teams / Zoom / Fathom connectors - best when decisions and action items live in meetings or messages.
7. Other / In Addition - add role-specific tools only after the teammate confirms they use them.

Keep the baseline simple first. Add SQL MCP after WOS is verified and only with a least-privilege read-only database identity.
