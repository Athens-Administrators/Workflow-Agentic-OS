# Workflow OS — Jira Write Format (Emoji Structure)

This format is mandatory for all writes to Jira originating from Workflow OS — comments, descriptions, titles, transitions. Used by the `wos-jira` plugin's skills and by every other plugin (`wos-project`, `wos-task`) that writes to Jira through Atlassian Rovo or Atlassian CLI (`acli`).

## 1. Comment structure

Every Workflow OS structured comment starts with a status marker and a one-line summary, followed by structured sections. Sections are optional; omit if empty. The summary preserves the user's original intent or original comment; refine it only when needed for clarity.

```
🟢 SUMMARY · <original intent or original comment; refine only if needed>

📋 What's done
- <bullet>
- <bullet>

🚧 In progress
- <bullet>

⛔ Blockers
- <bullet>

🔜 Next
- <bullet>

```

### Concise update

Use this one-line format when the user has supplied a single factual update and it does not need a fuller handoff:

```text
<status marker> <plain-language update>
```

Examples:

```text
🔵 Access was added for Jordan; no further action is needed.
🛠️ Updated the timeout value in staging.
```

Use the concise format only when all of the following are true:

- There is one clear, useful fact to record.
- There is no active blocker, decision request, or material next action to explain.
- The update is not a transition, worklog, or completion/closure.
- A teammate can understand the state without a sectioned handoff.

Use the structured format when any of those conditions is not true, when the user asks for detail, or when more than one independent update needs recording. Do not use a bare acknowledgement such as `🟢 Working on it.`

### Agent choice and preview

The agent decides whether a concise or structured comment best fits the user's input. Do not ask the user to choose a format up front.

Before asking to post, show a preview and say which format was selected and why. Ask: **“Is this good, or would you like it simpler?”** If the user asks for a simpler version, revise the preview. A preview is not permission to write: after the content is settled, show the final payload and obtain explicit current-turn confirmation to post it.

Status markers (pick one):

| Marker | Use when |
|---|---|
| 🟢 | On track, normal progress |
| 🟡 | Caution: risk surfaced, needs attention but not blocked |
| 🔴 | Blocked: external dependency or decision required |
| 🔵 | Informational update, no state change |
| ✅ | Completion / done / closing comment |
| 🛠️ | Technical / implementation detail |

## 2. Description structure (epics, tasks, subtasks, tickets)

When Workflow OS creates a Jira work item, the description follows this skeleton. Sections are filled in based on what's known; leave headings even if the body is "TBD" so the structure stays predictable.

```
## 🎯 Objective
<one to three sentences>

## 📦 Scope
- In scope:
- Out of scope:

## ✅ Acceptance criteria
- <Given/When/Then or bullet criteria>

## 🔗 Links
- Parent: <key>
- Related: <key>
- External: <url>

## 📝 Notes
<free-form context>
```

## 3. Title conventions

Use exactly one lead emoji at the beginning of the title, followed by concise action-oriented text. Do not stack multiple emojis.

- **Epic**: `🚀 [Epic] <Name>` (e.g. `🚀 [Epic] Migrate billing to new auth`).
- **Task**: `🛠️ <Verb> <object>` (e.g. `🛠️ Implement webhook handler`).
- **Subtask**: `🔧 <Verb> <object>` — typically scoped narrower (e.g. `🔧 Add retry logic to webhook handler`).
- **Ticket** (helpdesk-style): `🎫 <area>: <symptom>` (e.g. `🎫 Payments: invoice email not sent`).

## 4. Transition comments

When transitioning a Jira item (e.g. To Do → In Progress, In Progress → Done), add a comment using §1's format. For closures, use the ✅ marker and include:

```
✅ SUMMARY · <original intent or original comment; refine only if needed>

- What was done: <completed work>
- Outcome: <result and effect on the original intent>
```

## 5. Worklog entries

Worklog descriptions follow this brief shape — they're terse, machine-parseable, and feed the Workflow OS `worklog` memory type:

```
🛠️ <category> · <one-line summary>
Time: <Xh Ym>
Refs: <pr|commit|comment-link>
```

Categories (pick one): `implementation`, `investigation`, `review`, `meeting`, `documentation`, `support`, `other`.

## 6. Hard rules

- **No deletes/archive via writes.** Workflow OS agents must not use Jira delete or archive operations through any path, including `acli`.
- **No secrets in any field.** Strip tokens, passwords, keys before writing.
- **One status marker per comment.** Don't stack them.
- **Concise comments are complete sentences.** Keep them factual and use the structured format when context, a blocker, or a next action matters.
- **Keep the original intent in the summary.** Do not rewrite it beyond the clarification needed for a teammate to understand it.
- **Preview before confirmation.** The agent chooses the depth, previews the draft, asks whether it should be simpler, then separately requests explicit permission to post.
- **Section headings are required** when their content is present. Skip sections you have nothing to put under.
- **Mention the Jira key only when linking elsewhere**, never as decoration ("for JIRA-123 we did X" — fine; "JIRA-123: did X" — redundant since you're commenting on JIRA-123).
