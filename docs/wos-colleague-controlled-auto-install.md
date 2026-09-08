# Workflow OS Controlled Colleague Setup

Use this guide for a supervised first-time Workflow OS setup on a colleague's Codex environment.

The goal is to let Codex move quickly through safe setup work while pausing for answers that must come from the person being onboarded. Questions should be easy to answer, even for someone who is not technical.

## Human Prep

Before starting, confirm the colleague has:

- Codex installed and signed in.
- Access to the Workflow OS GitHub repository:
  `https://github.com/acasasAA/Workflow-Agentic-OS`
- Git installed.
- Node.js LTS installed.
- PowerShell 7 installed or available as `pwsh`.
- Enough local permission to write under their own user profile.

Do not copy another person's Windows username, local paths, role, team, Jira projects, or preferences into the colleague's setup.

## Prompt To Paste Into Codex

Paste this into a fresh Codex chat on the colleague's machine:

```text
Please install Workflow OS for the first time on this machine using controlled auto-install.

Repository:
https://github.com/acasasAA/Workflow-Agentic-OS.git

Goal:
- Set up Codex for Workflow OS.
- Install and run WOS Onboarding.
- Prioritize the mandatory WOS baseline: wos-jira, wos-documentation, and wos-dr.
- Do not install optional Workflow OS plugins unless I choose them.

Controlled auto-install mode:
- You may automatically run read-only checks, discover or clone the repository, run preflight, add or refresh the Workflow OS marketplace, and proceed through non-destructive setup steps.
- You may use safe defaults listed below when they are machine-derived or Athens-wide defaults.
- You must pause and ask me before answering any personal, role-based, access-based, optional, or confirmation-gated question.
- If a command prompts for an explicit confirmation word such as SETUP or INSTALL, stop and ask me to type it.

Question style:
- Ask one setup question at a time.
- Every setup question must be a numbered multiple-choice list.
- Use plain language that a non-technical teammate can understand.
- Keep explanations short. Aim for late high school to early college reading level.
- Add "Other / In Addition" as the last choice for any question where the listed answers may not cover my situation.
- Let me answer with just a number, a short phrase, or both.
- If I choose "Other / In Addition," ask one short follow-up question before deciding what to save.
- Do not ask open-ended setup questions unless they also include numbered choices.

Must ask me. Do not auto-answer these. Use numbered choices:
- Desired display name.
- Workflow OS username/profile name if it differs from the current Windows username.
- Role or position.
- Team.
- Leadership subrole or director focus, if applicable.
- Codex Work mode preference.
- Role-tailoring questions from WOS Onboarding.
- Other platforms, apps, ticketing systems, databases, dashboards, or internal tools I use.
- Optional Workflow OS plugin selection.
- Jira project keys beyond ASD and TPM.
- Primary Jira usage.
- Whether sensitive, admin-only, or occasional Jira projects should be included.
- Documentation route overrides, unknown Confluence destinations, or default parent pages.
- DR backup cadence if I do not accept the weekly default.
- Any authentication/login step.
- Any external write, including Jira writes, Confluence creates/updates, Git pushes, email sends, or destructive operations.

Question examples to follow:

Display name:
1. Use my full name from this computer or Codex account.
2. Use a shorter preferred name.
3. Other / In Addition - I will type the exact name to use.

Role or position:
1. Help Desk - I mainly help users with tickets and support requests.
2. IT Operations - I help keep systems and daily IT work running.
3. System Administration - I manage servers, accounts, systems, or technical settings.
4. Project Management - I track projects, timelines, handoffs, and status.
5. Development / DBA - I work on code, databases, applications, or Azure Boards work.
6. IT Leadership - I review work, decisions, priorities, staffing, or status.
7. Other / In Addition - my role is different or covers more than one area.

Team:
1. Help Desk.
2. Infrastructure / Operations.
3. System Administration.
4. Project Management.
5. Development / DBA.
6. IT Leadership.
7. Other / In Addition - I am on another team or split between teams.

Codex Work mode:
1. For everyday work - less technical detail unless I ask for it.
2. For coding - more technical detail and more direct code/tool work.
3. Other / In Addition - I want a different style.

Other tools or platforms:
1. No other tools right now.
2. Yes, I also use other tools for my work.
3. Other / In Addition - I am not sure; help me decide.

Optional Workflow OS plugins:
1. Jira, Documentation, and DR only for now.
2. Add Memory Engine - keeps local receipt notes for decisions and outcomes.
3. Add Project - helps manage larger project work. Also adds Memory Engine.
4. Add Task - helps manage to-do lists and meeting actions. Also adds Memory Engine.
5. Add Azure Boards - only if I use Azure Boards or I am on Development / DBA.
6. Other / In Addition - I want help choosing.

Jira projects beyond ASD and TPM:
1. No, only ASD and TPM for now.
2. Yes, I know the extra Jira project keys.
3. I am not sure; I can provide an example ticket like ABC-123.
4. Other / In Addition - I need help deciding what counts.

Documentation route:
1. Help Desk - user support or support-team documentation.
2. Infrastructure - systems, servers, access, or operations documentation.
3. DEV/DBA - development, database, application, or technical delivery documentation.
4. Public-facing for Athens employees - instructions meant for general Athens employees.
5. Other / In Addition - I am not sure where this belongs.

DR backup cadence:
1. Weekly.
2. Every other day.
3. Other / In Addition - I need a different schedule or need help choosing.

Safe defaults you may propose or use when the user does not override them:
- Use $env:USERPROFILE for all user-specific paths.
- Framework path: C:\Users\<current-user>\workflow-os\Workflow-Agentic-OS
- Data path: C:\Users\<current-user>\workflow-os-data
- OneDrive backup root: detected organization OneDrive folder, if available.
- Jira tenant: https://athensadmin.atlassian.net
- Baseline Jira projects:
  - ASD - main IT ticketing system.
  - TPM - IT project management board.
- Documentation route defaults:
  - Help Desk public-facing: HelpDesk Public / AEHT
  - Help Desk troubleshooting: HelpDesk Troubleshooting / AHI
  - Help Desk process or internal how-to: HelpDesk System Processes / AIH
  - Infrastructure internal: Internal Infrastructure KB / IIK
  - DEV/DBA internal: Dev Team KB / DTK
  - Public-facing Infrastructure or DEV/DBA: HelpDesk Public / AEHT
- Documentation template defaults:
  - Public how-to: ahi_how_to
  - Help Desk troubleshooting: ahi_troubleshooting
  - Infrastructure or DEV/DBA Business Process KB: infra_dev_standard
  - Infrastructure or DEV/DBA Runbook KB: infra_dev_break_fix_runbook
- DR cadence: weekly, unless I choose every other day.

Safety:
- Do not delete, move, or rename user folders.
- Do not overwrite tracked local changes.
- Do not hardcode another user's name, username, or path.
- Do not store secrets, tokens, passwords, or copied private credentials.
- Do not put secrets in URLs.
- Do not bypass Jira delete/archive protections.
- Do not auto-commit, auto-push, or auto-send messages.
- Stop at the first real failure and show the exact error plus the recommended next action.

Steps:
1. Confirm I can open this repository in a browser while signed into GitHub:
   https://github.com/acasasAA/Workflow-Agentic-OS
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
   git clone https://github.com/acasasAA/Workflow-Agentic-OS.git C:\Users\<current-user>\workflow-os\Workflow-Agentic-OS
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
14. Ask me which optional plugins I want before installing any of them. Use the numbered optional plugin question above:
    - wos-memory-engine
    - wos-project
    - wos-task
    - wos-azure-boards, only if my team is Development / DBA or I explicitly ask for Azure Boards

Optional plugin dependency rules:
- If I choose wos-project, also install wos-memory-engine.
- If I choose wos-task, also install wos-memory-engine.
- Do not install wos-azure-boards unless my team is Development / DBA or I explicitly ask for it.

Jira rules:
- Jira reads are allowed.
- Jira writes require my explicit confirmation in the current turn.
- Jira delete/archive operations are blocked for agents.
- Use Rovo first when available; use acli as a deterministic fallback when needed.
- For ASD ticket creation, ask whether it is AI Gen Issue or AI Gen Request and verify the available type before writing.
- For project boards such as TPM, AJD, GPT, HMB, or infrastructure boards, use Epic, Task, and Subtask logic rather than ASD service-desk ticket rules.

Documentation rules:
- Route first: Help Desk, Infrastructure, DEV/DBA, or public-facing for Athens employees.
- For Infrastructure or DEV/DBA docs, ask whether the doc is a Runbook KB article or a Business Process KB article.
- Then ask whether it is internal or public-facing.
- Resolve route, template, Confluence space, and parent/root placement before publishing.
- Confluence reads are allowed.
- Confluence creates and updates require my explicit confirmation in the current turn.

Expected plugin versions:
- wos-onboarding v0.1.9
- wos-jira v0.2.5
- wos-documentation v0.1.10
- wos-dr v0.1.1
- wos-memory-engine v0.1.3
- wos-project v0.1.6
- wos-task v0.1.6

Final verification:
- /plugins shows Workflow OS.
- wos-onboarding is installed.
- wos-jira, wos-documentation, and wos-dr are installed and setup-complete.
- WOS DR has a backup root and latest snapshot.
- Optional plugins were installed only if I selected them.
- Local paths use my Windows user profile, not someone else's.
```

## Minimum Setup Outcome

For a colleague who only needs Jira and documentation right now, the correct baseline is still:

- `wos-onboarding`
- `wos-jira`
- `wos-documentation`
- `wos-dr`

Skip optional plugins unless the colleague chooses them.

## Optional Plugins

Offer optional plugins with a numbered choice. Keep the wording simple:

1. Jira, Documentation, and DR only for now.
2. `wos-memory-engine` - keeps local receipt notes for decisions and outcomes.
3. `wos-project` - helps manage larger project work. Also installs `wos-memory-engine`.
4. `wos-task` - helps manage to-do lists and meeting actions. Also installs `wos-memory-engine`.
5. `wos-azure-boards` - for Azure Boards users. Show only for Development / DBA team profiles or when explicitly requested.
6. Other / In Addition - help me choose.

## What Should Stay Human

The setup can automate checks and installs, but the colleague should personally answer identity, role, team, work mode, tailoring, Jira project, documentation placement, optional plugin, authentication, and write-confirmation questions.

When Codex asks those questions, it should use numbered choices and include `Other / In Addition` when the user may need to add context.

That keeps Workflow OS role/user agnostic while still making the install feel smooth.
