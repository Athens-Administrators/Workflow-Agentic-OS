# Workflow OS Azure Boards Work Item Format

This format mirrors the Workflow OS Jira emoji structure so development work stays predictable across both destination systems.

## 1. Title Conventions

Use exactly one lead emoji at the beginning of the title. Do not stack multiple emojis.

- Epic: `🚀 [Epic] <Name>`
- Feature: `🧩 [Feature] <Name>`
- User Story: `📖 <user or outcome statement>`
- Task: `🛠️ <Verb> <object>`
- Bug: `🐞 <area>: <symptom>`

## 2. Description Structure

When Workflow OS creates or repairs an Azure Boards work item, the description follows this skeleton. Keep headings predictable. Use `TBD` when a section is known to be needed but the user has not supplied the content yet.

```text
## 🎯 Objective
<one to three sentences>

## 📦 Scope
- In scope:
- Out of scope:

## ✅ Acceptance criteria
- <Given/When/Then or bullet criteria>

## 🔗 Links
- Parent: <work item id or url>
- Related: <work item id or url>
- External: <url>

## 📝 Notes
<free-form context>
```

## 3. Comment / Update Structure

Every Workflow OS Azure Boards update starts with one status marker and a one-line summary, followed by structured sections. Omit empty sections.

```text
🟢 STATUS · <one-line summary of the update>

📋 What's done
- <bullet>

🚧 In progress
- <bullet>

⛔ Blockers
- <bullet>

🔜 Next
- <bullet>

🔗 Refs
- <work item id, PR, commit, doc, or url>
```

Status markers:

| Marker | Use when |
|---|---|
| 🟢 | On track, normal progress |
| 🟡 | Caution: risk surfaced, needs attention but not blocked |
| 🔴 | Blocked: external dependency or decision required |
| 🔵 | Informational update, no state change |
| ✅ | Completion / done / closing comment |
| 🛠️ | Technical / implementation detail |

## 4. Closure Comment

For done/closure updates, use:

```text
✅ DONE · <what was delivered>

📋 Delivered
- <bullet>

🔗 Refs
- PR: <url>
- Commit: <url>
- Work item: <id or url>
```

## 5. Hard Rules

- One lead emoji per title.
- One status marker per comment.
- Descriptions are the canonical work item summary.
- Comments are continuity updates, not a substitute for repairing a stale description.
- No secrets in any work item field.

