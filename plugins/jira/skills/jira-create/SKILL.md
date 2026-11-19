---
name: jira-create
description: Create a Jira work item (epic, task, subtask, or ticket) outside of a project flow. Use this when the user wants to manually create a Jira item without starting a project. Requires explicit confirmation before the write executes. Applies the mandatory Workflow OS emoji-formatted description.
---

# `$jira-create` — Manual Jira Work-Item Creation

You are creating a Jira work item on the user's explicit request.

## Required reference

Use known Jira tenant and project context, or resolve the missing details through the connector and user. Do not require a setup completion marker or `$jira-setup` before carrying out work.
Load `${plugin_root}/../references/jira-standard.md` before asking for fields. Use it to choose the smallest correct issue type and project default.
Load `${plugin_root}/../references/emoji-format.md` before drafting any text. The description **must** follow that format (Objective / Scope / Acceptance / Links / Notes).
Load `${plugin_root}/../references/jira-tooling.md` before choosing Jira tooling.

## Steps

1. **Identify the project and creation route from the request.** For ASD support tickets, use the four preliminary questions in `jira-standard.md` in this exact order: requester, reporter's department, urgency acknowledgement, then task or issue. Do not start by asking for a title, Summary, or task/issue classification. Generate the title as Summary from the user's context after intake. For non-ASD work, collect missing details as appropriate:
   - **Type**: epic, task, subtask, or helpdesk/support ticket. Use `jira-standard.md` if the user is unsure.
   - **Project key** (e.g. `ASD`, `TPM`). If unknown, use the Athens defaults in `jira-standard.md` and ask the user to confirm.
   - **Parent key**, if applicable (task under an epic, subtask under a task).
   - **Title**: one-line summary following §3 conventions in `emoji-format.md`; use exactly one lead emoji.
   - **Objective**: one to three sentences.
   - **Scope**: in-scope / out-of-scope bullets if available.
   - **Acceptance criteria**: bullet list or Given/When/Then.

2. **Apply project-specific safeguards** from `jira-standard.md`:

   - **For project boards such as `TPM`, `AJD`, `GPT`, `HMB`, or infrastructure boards**: if the project supports Epics and Tasks, prioritize Epic / Task / Subtask creation. Before drafting a create payload, search/list relevant existing Epics in that project using the user's context. Show likely matching Epics and ask whether this work belongs under one of them. Prefer creating a Task under an existing Epic. Do not create a new Epic unless the user explicitly confirms there is no existing project/Epic and they are authorized to create a new project container. Do not use ASD-style AI issue/request types for these project boards unless the user explicitly says the target project is configured that way.
   - **For `ASD`**: finish the ordered preliminary questions in `jira-standard.md`, ending with "Is this a task, or is this an issue?" Resolve the exact work type, linked request type, required fields and available choices from live metadata when possible. Collect every required answer before formulating the ticket, reusing explicit answers already supplied. Never guess a category, urgency acknowledgement, reporter or required choice. If metadata or the creation path cannot verify and set the required request type and fields, explain the limitation and stop before writing.

3. **Complete intake before drafting.** Ask the preliminary questions in `jira-standard.md`, including the intended reporter and all required request-form fields. Use the user's existing explicit answers; ask only for missing or ambiguous information. Run the creation quality checklist. Do not formulate the ticket or request approval until intake is complete.

4. **Draft the description** using the §2 skeleton from `emoji-format.md`. Show the user the draft.

5. **Confirm before writing.** Display the proposed payload:
   ```
   Type: <type>
   Project: <key>
   Jira issue type: <exact issue type to send>
   Service/request type: <exact request type to send, or n/a for non-service work>
   Reporter/requester: <resolved person when applicable>
   Required request fields: <field names and exact selected values, when applicable>
   Parent: <key or none>
   Title: <title>
   Description:
   <full body>
   ```
   Ask: "Create this in Jira? (yes/no)"

6. **On yes**: use the Jira tooling order from `jira-tooling.md`. Prefer the current Rovo `createJiraIssue` operation (or its client-exposed wrapper); if it is deferred, discover it and execute through `executeWrite`. If Rovo is unavailable, use the matching `acli jira workitem create` flow after confirming required fields. Capture the returned key and read it back with `getJiraIssue` or `acli`.

7. **On success**, tell the user the key + URL. Keep the result in the current conversation; Jira is the durable work reference. Do not write a second WOS memory record.

8. **On no**, ask what to change. Loop on step 4.

## Hard rules

- **No deletes/archive ever** — do not use Jira delete or archive operations through Rovo, `acli`, or any other path.
- **No secrets** in titles, descriptions, or comments.
- **Authorization is per-action**: each create gets its own confirmation. Don't batch.
- **If the project is wrong**, abort and ask. Don't guess.
- **Project-board safeguard**: for project boards such as `TPM`, `AJD`, `GPT`, `HMB`, or infrastructure boards, do not create a new Epic/project container without first checking relevant existing Epics and getting explicit user confirmation. Prefer Epic / Task / Subtask shapes over ASD-style AI issue/request types.
- **ASD safeguard**: do not create until issue vs request/task is clarified, required intake is complete, and the actual work type, request type, reporter, and required field payload are verified. If the tool cannot verify or set them, stop.
- **Standalone behavior**: this skill must work with only `wos-jira` installed. Do not require Memory Lite, project, or task plugins.
