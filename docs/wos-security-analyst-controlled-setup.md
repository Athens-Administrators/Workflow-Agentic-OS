# WOS Controlled Setup for a Security Analyst

Use this guide for a supervised first-time Workflow OS setup with a security analyst or security-focused IT teammate.

This setup is different from the DEV/DBA path. It should prioritize secure handling of tickets, documentation, evidence, reviews, policies, vendor/security questionnaires, and local files. Do not assume the teammate writes code, uses Azure Boards, or needs a developer workflow.

## What This Setup Gives Them

After setup, the teammate should be able to:

1. Use Jira as the active-work source for tickets, reviews, follow-ups, and evidence tracking.
2. Use Confluence as the system of record for published documentation.
3. Draft security-facing notes, KB updates, vendor questionnaire responses, policy summaries, and review write-ups.
4. Work with local files in Codex when they choose a local workspace.
5. Use optional WOS project or task workflows if they want stronger tracking.
6. Use optional Zoom Chat Pull or Zoom Clips Pull if those plugins are available and approved.
7. Keep write actions approval-based and easy to review.

## Human Prep

Before starting, confirm:

1. The teammate has Codex installed and signed in.
2. They can open the Workflow OS repository:
   `https://github.com/Athens-Administrators/Workflow-Agentic-OS`
3. They have Git installed.
4. They have Node.js LTS installed.
5. They have PowerShell 7 installed or available as `pwsh`.
6. They have access to the work systems they normally use, such as Jira, Confluence, SharePoint, Outlook, Teams, Zoom, or security tools.
7. Other / In Addition - an admin may need to enable access first.

Do not copy another person's Windows username, local path, role, team, Jira projects, security tools, or preferences into this setup.

## Prompt To Paste Into Codex

Paste this into a fresh Codex chat on the teammate's machine:

```text
Please install Workflow OS for the first time on this machine using controlled setup for a security analyst or security-focused IT teammate.

Repository:
https://github.com/Athens-Administrators/Workflow-Agentic-OS.git

Goal:
- Set up Codex for Workflow OS.
- Install and run WOS Onboarding.
- Prioritize the mandatory WOS baseline: wos-jira, wos-documentation, and wos-dr.
- Keep the setup role/user agnostic.
- Do not assume I am a developer or DBA.
- Do not install optional plugins unless I choose them.

Controlled setup mode:
- You may automatically run read-only checks, discover or clone the repository, run preflight, add or refresh the Workflow OS marketplace, and continue through non-destructive setup steps.
- You may use safe machine-derived defaults, such as $env:USERPROFILE.
- You may propose Athens-wide defaults, such as the Jira tenant, ASD, TPM, and known Confluence route defaults.
- You must pause before answering personal, role-based, access-based, optional, security-sensitive, or confirmation-gated questions.
- If a command prompts for an explicit confirmation word such as SETUP or INSTALL, stop and ask me to type it.

Question style:
- Ask one setup question at a time.
- Every setup question must be numbered multiple choice.
- Use plain language a non-technical teammate can understand.
- Keep explanations short.
- Add "Other / In Addition" as the last choice when the listed answers may not cover my situation.
- Let me answer with a number, a short phrase, or both.
- If I choose "Other / In Addition," ask one short follow-up question before deciding what to save.

Must ask me. Do not auto-answer these:
- Display name.
- Workflow OS username/profile name if it differs from my Windows username.
- Role or position.
- Team.
- Main security work areas.
- Codex Work mode preference.
- Other platforms, apps, security tools, ticketing systems, dashboards, or internal tools I use.
- Optional Workflow OS plugin selection.
- Jira project keys beyond ASD and TPM.
- Main Jira use.
- Whether sensitive, admin-only, confidential, or occasional Jira projects should be included.
- Documentation route, audience, template, and parent/root placement.
- DR backup cadence if I do not accept the weekly default.
- DR project root. Use a narrow projects folder, not the whole OneDrive folder, if the backup folder is also inside OneDrive.
- Any authentication/login step.
- Any external write, including Jira writes, Confluence creates/updates, Git pushes, email sends, or destructive operations.

Suggested role or position choices:
1. Security Analyst - I review security items, evidence, risks, alerts, questionnaires, or policies.
2. Governance / Risk / Compliance - I work with controls, evidence, audits, vendors, or policy reviews.
3. IT Operations - I help keep systems and daily IT work running.
4. System Administration - I manage servers, accounts, systems, or technical settings.
5. Help Desk - I mainly help users with tickets and support requests.
6. IT Leadership - I review work, decisions, priorities, staffing, or status.
7. Other / In Addition - my role is different or covers more than one area.

Suggested team choices:
1. Security.
2. Infrastructure / Operations.
3. System Administration.
4. Help Desk.
5. Project Management.
6. IT Leadership.
7. Other / In Addition - I am on another team or split between teams.

Security work area choices:
1. Security tickets and follow-ups.
2. Vendor security questionnaires and evidence.
3. Policy, procedure, and control documentation.
4. Access reviews or user/account reviews.
5. Incident notes, alerts, or investigation summaries.
6. Risk, audit, or compliance tracking.
7. Other / In Addition - my work covers something else too.

Codex Work mode:
1. For everyday work - less technical detail unless I ask for it.
2. For coding - more technical detail and more direct code/tool work.
3. Other / In Addition - I want a different style.

Other apps and platforms:
1. Jira and Confluence only.
2. Jira, Confluence, SharePoint, and OneDrive.
3. Jira, Confluence, Outlook Email, and Outlook Calendar.
4. Jira, Confluence, Teams, and Zoom.
5. Jira, Confluence, SharePoint, OneDrive, Outlook, Teams, Zoom, and security tools.
6. Other / In Addition - I use another tool or I am not sure.

Optional Workflow OS plugins:
1. Jira, Documentation, and DR only for now.
2. Add Memory Engine - keeps local receipt notes for decisions and outcomes.
3. Add Project - helps manage larger review, audit, or documentation projects. Also adds Memory Engine.
4. Add Task - helps manage to-do lists, meeting actions, follow-ups, and ticket-sized work. Also adds Memory Engine.
5. Add Zoom Chat Pull - only if available, approved, and needed for work-visible Zoom chats.
6. Add Zoom Clips Pull - only if available, approved, and needed for meeting clips or training/documentation source material.
7. Add Codex Security - only if available, approved, and useful for code or repository security review.
8. Other / In Addition - I want help choosing.

Optional plugin dependency rules:
- `wos-project` and `wos-task` are independent optional plugins; recommend Jira for shared work but do not require it.
- Do not install wos-azure-boards unless I say I use Azure Boards or I am on a Development / DBA team.
- Do not install Zoom Chat Pull, Zoom Clips Pull, or Codex Security unless they are available in the plugin directory and I approve them.
- If a plugin is not available on this machine, say so clearly and continue with the rest of setup.

Jira setup:
- Jira reads are allowed when I have access.
- Jira writes require my explicit approval in the current turn.
- Jira delete/archive operations are blocked for agents.
- Do not store secrets, passwords, keys, tokens, or confidential evidence in setup notes.
- Default Jira tenant: https://athensadmin.atlassian.net
- Common baseline projects:
  - ASD - main IT ticketing system.
  - TPM - IT project management board.
- Ask before adding any extra Jira project.
- Include a Jira project key only when I regularly create, update, review, report on, or search work in that project.
- If I am not sure, ask me for an example issue key, such as ABC-123, and help infer the project key.
- For ASD ticket creation, ask whether it is AI Gen Issue or AI Gen Request and verify the available type before writing.
- For project boards such as TPM, AJD, GPT, HMB, or infrastructure boards, use Epic, Task, and Subtask logic rather than ASD service-desk ticket rules.

Documentation setup:
- Confluence is the system of record for published documentation.
- Route first:
  1. Help Desk - user support or support-team documentation.
  2. Infrastructure - systems, servers, access, or operations documentation.
  3. DEV/DBA - development, database, application, or technical delivery documentation.
  4. Security / Compliance - security reviews, evidence notes, control support, audit notes, or security process docs.
  5. Public-facing for Athens employees - instructions meant for general Athens employees.
  6. Other / In Addition - I am not sure where this belongs.
- If Security / Compliance does not have a dedicated Confluence route yet, ask whether it should use Infrastructure, Help Desk internal process, DEV/DBA, or a one-time route.
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

Security documentation rules:
- Answer security attestations only from real supporting evidence.
- Do not claim SSDLC, SAST, DAST, penetration testing, encryption, monitoring, or audit controls unless real evidence is available.
- If evidence is missing, say what is missing and draft a truthful gap statement.
- Keep customer-facing or vendor-facing security answers concise and evidence-based.
- Do not include secrets or sensitive internal details in published documentation.

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
   pwsh -NoProfile -File .\scripts\install\preflight.ps1
5. If preflight reports missing required prerequisites or tracked local changes, stop and show only the blocker and fix.
6. If preflight is ready, run:
   pwsh -NoProfile -File .\scripts\install\setup-codex.ps1
   If the script asks for SETUP, ask me to type SETUP before continuing.
7. Fully close and reopen Codex.
8. Open /plugins.
9. Install only wos-onboarding from the workflow-os marketplace first.
10. Start a fresh Codex chat and run:
    $welcome
11. During onboarding, install the mandatory plugins:
    - wos-jira
    - wos-documentation
    - wos-dr
12. Finish mandatory setup flows before continuing:
    - $jira-setup
    - $documentation-setup
    - $dr-setup
13. Create a first DR snapshot:
    $dr-snapshot
14. Ask me which optional plugins I want using the numbered optional plugin question above.

Final verification:
- /plugins shows Workflow OS.
- wos-onboarding is installed.
- wos-jira, wos-documentation, and wos-dr are installed and setup-complete.
- WOS DR has a backup root and latest snapshot.
- WOS DR is not scanning its own backup folder. If the backup root is inside OneDrive, the project root should be a narrower project folder, or the backup root must be excluded from project marker and structure scans.
- Optional plugins were installed only if I selected them.
- Local paths use my Windows user profile, not someone else's.
- Security-specific notes are evidence-based and do not contain secrets.
```

## ChatGPT Work Option

If the teammate may also use **ChatGPT Work** in the desktop app, give them this setup choice:

1. Codex only - full local Workflow OS install.
2. ChatGPT Work Local only - lighter setup for local files, apps, and connected tools.
3. Both Codex and ChatGPT Work Local.
4. Other / In Addition - help me choose.

For ChatGPT Work, they should have a similar plugin choice experience when the workspace supports it:

1. WOS Jira / Documentation style only.
2. WOS Project-style workflow, if available for ChatGPT Work.
3. WOS Task-style workflow, if available for ChatGPT Work.
4. Zoom Chat Pull, if available and approved.
5. Zoom Clips Pull, if available and approved.
6. Codex Security or security-review tooling, if available and approved.
7. Other / In Addition - help me choose.

If a Workflow OS plugin is Codex-only or does not work in ChatGPT Work yet, say that clearly and use the WOS rules as instructions instead of pretending the plugin is installed.

## Minimum Setup Outcome

For a security analyst who is setting up Codex, the minimum baseline is:

1. `wos-onboarding`
2. `wos-jira`
3. `wos-documentation`
4. `wos-dr`

Optional additions should be chosen by the teammate, not assumed.

## Best Fit For Security Work

Recommended optional plugins to consider:

1. `wos-task` - best for follow-ups, meeting actions, review items, and ticket-sized security work.
2. `wos-project` - best for larger audits, rollout reviews, policy updates, or multi-step evidence projects.
3. `zoom-chat-pull` - best when security context is spread across approved Zoom chats.
4. `zoom-clips-pull` - best when meeting clips or recordings need to become notes, evidence summaries, or documentation.
5. Codex Security - best when the teammate reviews code, repositories, or security findings and the plugin is available.
6. Other / In Addition - add role-specific tools only after the teammate confirms they use them.

Keep the setup simple first. Add optional tools after the teammate understands the baseline.
