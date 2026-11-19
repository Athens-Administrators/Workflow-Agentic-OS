# Workflow OS — Jira Team Standard

This standard defines how Athens IT agents should create, review, update, maintain, and close Jira work items. It is intentionally standalone: `wos-jira` must be usable without Workflow OS memory, project, or task plugins.

## 1. Core Principle

Jira is the team source of truth for work. Every Jira item should make the next action clear to a teammate who was not in the original conversation.

Use `emoji-format.md` for all titles, descriptions, comments, transition notes, and worklogs. Use `jira-tooling.md` for the Rovo-first / ACLI-fallback tool order.

## 2. Issue Type Decision Rules

Choose the smallest issue type that accurately represents the work.

### Epic

Use an Epic when the work:

- spans multiple phases or work streams
- needs child tasks or subtasks
- has cross-team visibility or project-management reporting value
- represents a product, service, rollout, migration, platform, or major improvement

Title format:

```text
🚀 [Epic] <Name>
```

### Task

Use a Task when the work:

- is a concrete deliverable
- can be completed by one owner or one small group
- may belong under an Epic
- does not require helpdesk intake behavior

Title format:

```text
🛠️ <Verb> <object>
```

### Subtask

Use a Subtask when the work:

- is a narrow execution step under an existing Task
- should not stand alone as a team-visible deliverable
- depends on the parent task context

Title format:

```text
🔧 <Verb> <object>
```

### Helpdesk / Support Ticket

Use a ticket when the work:

- came from an end user or support request
- has a symptom, request, access need, incident, or service desk workflow
- belongs in the IT ticketing system, usually `ASD`

Title format:

```text
🎫 <area>: <symptom or request>
```

Do not create helpdesk/support work as an Epic unless the user explicitly confirms they are managing a project container in a project-management board. Normal helpdesk intake should use the service desk ticket/request shape for the target board.

## 3. Athens Project Defaults

Use these as the default starting point, unless the user gives a more specific project key.

- `ASD`: main IT ticketing / service desk work.
- `TPM`: IT project management work.

Other projects are role- or user-specific. Do not assume them for general team use.

## 4. Project Board Creation Rules

Project boards such as `TPM`, `AJD`, `GPT`, `HMB`, and infrastructure boards should use their normal project-management shape. When a board supports Epics and Tasks, prioritize Epics, Tasks, and Subtasks instead of ASD-style AI request/issue types.

For project-board work:

- Ask the user to double-check whether an existing Epic/project already exists.
- Use the available context to search/list relevant existing Epics in the target project before drafting a new Jira write.
- Show likely matching Epics and ask whether the new work belongs under one of them.
- Prefer creating a Task under an existing Epic when the work belongs to an existing project.
- Prefer creating a Subtask only when the work is a narrow execution step under an existing Task.
- Do not create a new Epic unless the user explicitly confirms that this is a new project container.

Team default: most users create Tasks or Subtasks in project boards. Epic creation is normally limited to users who own project structure, such as the current rollout owner, a designated project manager, or another explicitly authorized project owner.

## 5. ASD Creation Rules

`ASD` is the IT Team Ticketing System. Treat it as the service-desk path, not as a project board.

For `ASD`, complete the ordered preliminary questions below before drafting. The final intake question selects the work type and its linked request type:

- Issue: use for a problem, symptom, incident, broken behavior, access issue, or investigation. The configured mapping is work type `AI Gen Issue` and request type `AI Generated Issue`.
- Request/task: use for planned work, setup, configuration, fulfillment, follow-up, or a non-incident action. The configured mapping is work type `AI Gen Task` and request type `AI Generated Request`.

Do not ask the task-or-issue question ahead of requester, department, and urgency.

Important: for `ASD`, the Jira work type and customer request type are separate. The mappings above are a known baseline, not a substitute for live verification. Resolve the current matching work type, request type, required request-form fields and allowed values for the selected path before creating. Do not substitute a Jira work type for a customer request type.

### Preliminary questions

Use this same sequence in Codex and ChatGPT. Ask one question at a time, in order, and finish each answer before advancing. Reuse explicit answers already provided rather than asking the user to repeat them. Never fabricate a required answer.

1. **Requester:** "Should this ticket be submitted under your name or on behalf of someone else?" If on behalf of someone else, ask for that person's name, email address, or both, and use the supplied identity to resolve the exact Jira account. If a name matches multiple people, ask for their email address before continuing. For self-submission resolve the authenticated Jira user. The selected person is the **reporter**, not the assignee; verify the actual tool parameter using `jira-tooling.md`.
2. **Department:** For self-submission ask "What department are you a part of?" For submission on behalf of someone else ask "What department is that person a part of?" Map the answer to a currently allowed Department Category choice; clarify ambiguous answers. This is the selected reporter's department.
3. **Urgency:** "Is this urgent, or is this not urgent?" Map urgent to the current **Urgent** choice and not urgent to **Routine Business** in Acknowledgement of Urgency. Select only the matching checkbox option, not both. Preserve any current instructions attached to the urgent choice. Do not substitute the separate Priority or Urgency field for this acknowledgement.
4. **Classification:** "Is this a task, or is this an issue?" Task maps to `AI Gen Task` plus its linked `AI Generated Request` request type; issue maps to `AI Gen Issue` plus its linked `AI Generated Issue` request type. Verify the live mapping before submission.

Workflow OS generates the ticket title from the user's context and sends it as Jira **Summary**. Do not add a separate Summary question. Generate the description from the provided problem or requested outcome using the emoji format. After the four answers are complete, generate the ticket preview and request approval. If essential problem context or a newly required field is missing, ask only the necessary follow-up before drafting; do not invent the content.

The last verified required form fields for both mappings are Summary, Department Category, and Acknowledgement of Urgency. Recheck live requirements and allowed choices; generic issue-create metadata may omit request-form requirements. If current request-form requirements or choices cannot be verified, explain the limitation and do not claim completeness or request final submission approval. The known baseline can guide intake, but does not prove the create payload is valid.

Before writing, show the user both values the tool will send:

```text
Project: ASD
Jira issue type: <exact issue type that will be sent>
Service/request type: <exact matching request type to send>
Reporter/requester: <resolved Jira account>
Required request fields: <each field and selected value>
```

If the selected Rovo or `acli` create path cannot verify and set the matching request type, reporter, or required fields, stop before writing and explain the limitation. Never create a best-effort ASD ticket without a customer request type. After creation read back the reporter, request type, and required values; report any mismatch or unverified field rather than claiming customer visibility. Customer portal visibility and notification delivery require separate verification.

## 6. Creation Quality Checklist

Before creating a Jira item, verify:

- The project key is correct.
- The issue type is correct.
- For project boards, existing relevant Epics were checked before creating a new Epic or standalone Task.
- For `ASD`, issue vs request/task was clarified, preliminary required answers were collected before drafting, and the exact work type, customer request type, reporter, and required values were shown in the approval preview.
- The title has exactly one lead emoji and is action-oriented.
- The objective explains why the work exists.
- Scope says what is in and out where useful.
- Acceptance criteria or desired outcome is clear.
- Parent/related links are included when known.
- No secrets are present.
- Similar or related work was considered when context is available.

If any required detail is missing, ask for it before drafting.

## 7. Maintenance / Comment Standard

Use comments to maintain continuity. A good comment should answer:

- What changed?
- What is currently happening?
- What is blocked?
- What happens next?

Use the status marker that best fits the update:

- `🟢 SUMMARY` for normal progress
- `🟡 SUMMARY` for risk/caution
- `🔴 SUMMARY` for blocked work
- `🔵 SUMMARY` for informational updates
- `✅ SUMMARY` for completion/closure
- `🛠️ SUMMARY` for implementation detail

Do not post vague comments such as "working on this" unless paired with useful context.

For a simple, self-contained update, use the concise format in `emoji-format.md`: one status marker and one factual sentence. Use the full structured comment when a teammate needs the outcome, in-progress work, blocker, or next action to understand the handoff. In either format, the agent chooses the appropriate depth, previews it, asks whether it should be simpler, and only then seeks separate approval to post. The summary must retain the original intent or original comment, refined only where clarity requires it. Transitions and closure always use their dedicated structured formats.

## 8. Closure Standard

Before closing or recommending closure, verify:

- The requested outcome was delivered or explicitly deferred.
- Any unresolved blocker is documented.
- The final comment uses the `✅ SUMMARY` structure and states what was done and the outcome beneath the summary line.
- The user has explicitly confirmed any Jira transition or write action.

## 9. Description Maintenance

Descriptions should be kept useful as the canonical summary of the work. Use `$jira-mod` when:

- the description is missing structure
- scope or acceptance criteria changed
- the item was created without enough context
- a project/task evolved and the description is stale

Do not use comments as a substitute for fixing a bad description when the description is the source of confusion.

## 10. Review Standard

Use `$jira-review` to evaluate an existing issue before changing it. A review should classify the issue as:

- `Pass`: already follows the standard
- `Needs cleanup`: usable but should be improved
- `Needs clarification`: missing details required for action
- `Wrong shape`: likely wrong issue type, project, parent, or scope

The review should recommend the smallest safe improvement. It must not write to Jira unless the user explicitly confirms the proposed write.

## 11. Hard Boundaries

- Jira reads are allowed.
- Jira writes require explicit confirmation in the current turn.
- Jira deletes and archives are blocked for agents.
- Do not include secrets in Jira text.
- Do not bulk-edit multiple issues through the Jira standard skills.
- If cleanup requires deletion, tell the user to do it manually in Jira.
