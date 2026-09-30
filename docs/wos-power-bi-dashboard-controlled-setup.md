# WOS Controlled Setup for a Power BI Dashboard Owner

> **Archived WOS 1.x guide.** Do not use these DR or Memory Engine instructions for a new install or upgrade. Use the Suite 2 Beta first-time or existing-install guide; legacy version references below are historical only.

Use this guide for a supervised first-time Workflow OS setup with a teammate who owns Power BI dashboards, reporting, metrics, or recurring business data reviews.

This setup is role/user agnostic. It should not copy another person's name, Windows path, Jira projects, report folders, Power BI workspaces, or preferences.

## What This Setup Gives Them

After setup, the teammate should be able to:

1. Use Jira as the active-work source for dashboard requests, report changes, follow-ups, and blockers.
2. Use Confluence as the system of record for dashboard documentation, metric definitions, refresh notes, and handoff guides.
3. Work with local dashboard files, exports, notes, CSVs, Excel files, screenshots, and documentation from Codex.
4. Use WOS DR with the recursive backup fix so backups do not scan their own backup folder.
5. Optionally use WOS Task for recurring dashboard work and meeting follow-ups.
6. Optionally use WOS Project for larger dashboard rebuilds, data cleanup projects, or reporting rollouts.
7. Optionally use approved connectors such as SharePoint, OneDrive, Outlook, Teams, Zoom, or Power Platform tools when available.

## Human Prep

Before starting, confirm:

1. The teammate has Codex installed and signed in.
2. They can open the Workflow OS repository:
   `https://github.com/Athens-Administrators/Workflow-Agentic-OS`
3. They have Git installed.
4. They have Node.js LTS installed.
5. They have PowerShell 7 installed or available as `pwsh`.
6. They know where their main dashboard files or notes live, if they want Codex to work with local files.
7. They have access to the work systems they normally use, such as Jira, Confluence, SharePoint, OneDrive, Outlook, Teams, Zoom, Power BI, Excel, or Power Platform.
8. Other / In Addition - an admin may need to enable access first.

## Important DR Note

This guide expects `wos-dr v0.1.2` or newer.

That version addresses the recursive backup issue by excluding the configured DR backup root from project marker and structure scans.

Plain version: if the backup folder is inside OneDrive, DR should not scan its own backup snapshots as if they were normal project folders.

During setup:

1. Prefer a narrow project root, such as a Codex projects folder or reporting work folder.
2. Do not choose the entire OneDrive folder as the project root if the DR backup folder is also inside OneDrive.
3. Confirm `wos-dr v0.1.2` or newer before creating the first real snapshot.
4. Run `$dr-status` after setup and check that the backup root is not also being scanned as a project root.
5. Ask before running `$dr-snapshot`.

## Prompt To Paste Into Codex

Paste this into a fresh Codex chat on the teammate's machine:

```text
Please install Workflow OS for the first time on this machine using controlled setup for a Power BI dashboard, reporting, or metrics owner.

Repository:
https://github.com/Athens-Administrators/Workflow-Agentic-OS.git

Goal:
- Set up Codex for Workflow OS.
- Install and run WOS Onboarding.
- Prioritize the mandatory WOS baseline: wos-jira, wos-documentation, and wos-dr.
- Make sure wos-dr is v0.1.2 or newer so the DR recursive backup and path-length fixes are included.
- Keep the setup role/user agnostic.
- Do not assume I am a developer, DBA, security analyst, or help desk analyst.
- Do not install optional plugins unless I choose them.

Controlled setup mode:
- You may automatically run read-only checks, discover or clone the repository, run preflight, add or refresh the Workflow OS marketplace, and continue through non-destructive setup steps.
- You may use safe machine-derived defaults, such as $env:USERPROFILE.
- You may propose Athens-wide defaults, such as the Jira tenant, ASD, TPM, and known Confluence route defaults.
- You must pause before answering personal, role-based, access-based, optional, reporting-specific, or confirmation-gated questions.
- If a command prompts for an explicit confirmation word such as SETUP or INSTALL, stop and ask me to type it.

Question style:
- Ask one setup question at a time.
- Every setup question must be numbered multiple choice.
- Use plain language a non-technical teammate can understand.
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
- Main dashboard or reporting work areas.
- Codex Work mode preference.
- Other platforms, apps, reporting systems, data sources, ticketing systems, dashboards, or internal tools I use.
- Optional Workflow OS plugin selection.
- Jira project keys beyond ASD and TPM.
- Main Jira use.
- Whether sensitive, admin-only, confidential, finance, HR, student, or occasional Jira projects should be included.
- Documentation route, audience, template, and parent/root placement.
- DR backup cadence if I do not accept the weekly default.
- DR project root. Use a narrow projects or reporting folder, not the whole OneDrive folder, if the backup folder is also inside OneDrive.
- Any authentication/login step.
- Any external write, including Jira writes, Confluence creates/updates, Git pushes, email sends, or destructive operations.

Suggested role or position choices:
1. Power BI Dashboard Owner - I build, maintain, or review Power BI dashboards.
2. Reporting / Metrics Analyst - I work with reports, data exports, KPIs, or recurring metrics.
3. Business Systems Analyst - I connect business needs to systems, reports, and process changes.
4. Project Management - I track projects, timelines, handoffs, and status.
5. IT Operations - I support systems, users, or daily operational work.
6. IT Leadership - I review priorities, decisions, staffing, status, or reporting outcomes.
7. Other / In Addition - my role is different or covers more than one area.

Suggested team choices:
1. Reporting / Analytics.
2. Power BI / Data.
3. IT Operations.
4. Project Management.
5. Finance / Business Operations.
6. IT Leadership.
7. Other / In Addition - I am on another team or split between teams.

Dashboard and reporting work area choices:
1. Build or update Power BI dashboards.
2. Maintain recurring reports, scorecards, or KPI reviews.
3. Clean up data sources, exports, or Excel workbooks.
4. Document metric definitions, report rules, or dashboard ownership.
5. Track dashboard requests, bugs, and change approvals.
6. Prepare meeting follow-ups, status updates, or leadership readouts.
7. Other / In Addition - my reporting work covers something else too.

Codex Work mode:
1. For everyday work - less technical detail unless I ask for it.
2. For reporting and documentation - focus on clear notes, Jira tickets, and dashboard handoffs.
3. For technical data work - more detail about files, data shape, scripts, and troubleshooting.
4. Other / In Addition - I want a different style.

Other apps and platforms:
1. Jira and Confluence only.
2. Jira, Confluence, SharePoint, and OneDrive.
3. Jira, Confluence, Excel, CSV files, SharePoint, and OneDrive.
4. Jira, Confluence, Outlook Email, Outlook Calendar, Teams, and Zoom.
5. Jira, Confluence, Power BI, Excel, SharePoint, OneDrive, Outlook, Teams, and Zoom.
6. Other / In Addition - I use another tool, data source, or dashboard platform.

Dashboard data source choices:
1. Mostly Excel or CSV files.
2. Mostly SharePoint or OneDrive files.
3. Mostly databases, exports, or application reports.
4. Mostly manually updated dashboards or scorecards.
5. A mix of several sources.
6. Other / In Addition - I am not sure or the source is different.

Documentation focus choices:
1. Dashboard user guides - how people should use a report.
2. Metric definitions - what each measure means and how it is calculated.
3. Refresh and ownership notes - who owns it, when it updates, and what can fail.
4. Change history - what changed, why, and who approved it.
5. Support troubleshooting - common problems and how to fix them.
6. Other / In Addition - I need another kind of documentation.

Optional Workflow OS plugins:
1. Jira, Documentation, and DR only for now.
2. Add Memory Engine - keeps local receipt notes for decisions and outcomes.
3. Add Task - helps manage recurring report updates, meeting actions, and dashboard follow-ups. Also adds Memory Engine.
4. Add Project - helps manage larger dashboard rebuilds, reporting rollouts, or data cleanup projects. Also adds Memory Engine.
5. Add Zoom Chat Pull - only if available, approved, and needed for work-visible Zoom chats.
6. Add Zoom Clips Pull - only if available, approved, and needed for meeting clips or training/documentation source material.
8. Add Power Platform or data tools - only if available, approved, and useful for my reporting work.
9. Other / In Addition - I want help choosing.

Optional plugin dependency rules:
- `wos-project` and `wos-task` are independent optional plugins; recommend Jira for shared work but do not require it.
- Do not install wos-azure-boards unless I say I use Azure Boards or I am on a Development / DBA team.
- Do not install Zoom Chat Pull, Zoom Clips Pull, Power Platform tools, or other connectors unless they are available in the plugin directory and I approve them.
- If a plugin or connector is not available on this machine, say so clearly and continue with the rest of setup.

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
- For dashboard or reporting requests, prefer clear summaries, acceptance criteria, data source notes, owner, due date, and review/approval needs.
- For ASD ticket creation, ask whether it is AI Gen Issue or AI Gen Request and verify the available type before writing.
- For project boards such as TPM, AJD, GPT, HMB, or infrastructure boards, use Epic, Task, and Subtask logic rather than ASD service-desk ticket rules.

Documentation setup:
- Confluence is the system of record for published documentation.
- Route first:
  1. Help Desk - user support or support-team documentation.
  2. Infrastructure - systems, servers, access, or operations documentation.
  3. DEV/DBA - development, database, application, or technical delivery documentation.
  4. Reporting / Analytics - dashboard guides, metric definitions, refresh notes, or report ownership docs.
  5. Public-facing for Athens employees - instructions meant for general Athens employees.
  6. Other / In Addition - I am not sure where this belongs.
- If Reporting / Analytics does not have a dedicated Confluence route yet, ask whether it should use Help Desk public, Help Desk internal process, Infrastructure, DEV/DBA, or a one-time route.
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
- Infrastructure or DEV/DBA Business Process KB template: infra_dev_standard
- Infrastructure or DEV/DBA Runbook KB template: infra_dev_break_fix_runbook

Power BI and reporting rules:
- Do not change reports, datasets, dashboards, data models, Power Query, DAX, source files, or refresh settings without my approval.
- Do not publish or overwrite reports without my approval.
- Do not store secrets, connection strings, passwords, tokens, or private credentials in notes, Jira, Confluence, or memory.
- Treat finance, HR, student, legal, security, and confidential business data as sensitive.
- When drafting dashboard documentation, separate:
  - What the dashboard shows.
  - Who owns it.
  - Where the source data comes from.
  - How often it refreshes.
  - What each metric means.
  - What users should do if the data looks wrong.
- If evidence is missing, say what is missing instead of guessing.

DR setup rules:
- Install or update wos-dr to v0.1.2 or newer.
- The backup root must not be scanned as a project root.
- If the selected project root contains the backup root, exclude the backup root from marker and structure scans.
- Prefer a narrow project root such as:
  1. C:\Users\<current-user>\workflow-os
  2. C:\Users\<current-user>\Documents\Codex
  3. C:\Users\<current-user>\OneDrive - Athens\Documents\Reporting
  4. Other / In Addition - I will choose the folder.
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
- Dashboard/reporting notes do not contain secrets or private credentials.
```

## Best Fit for a Power BI Dashboard Owner

Recommended optional additions to consider:

1. `wos-task` - best for recurring dashboard refreshes, meeting actions, follow-ups, and small report changes.
2. `wos-project` - best for larger dashboard rebuilds, reporting rollouts, metric cleanups, and cross-team handoffs.
3. SharePoint / OneDrive connector - best when dashboard notes, exports, PBIX files, or data dictionaries live in Microsoft 365.
4. Outlook / Calendar / Teams / Zoom connectors - best when requests and decisions live in meetings or messages.
6. Power Platform or data tools - only when available, approved, and useful for their reporting work.
7. Other / In Addition - add role-specific tools only after the teammate confirms they use them.

Keep the baseline simple first. Add optional tools after the teammate understands Jira, Documentation, and DR.
