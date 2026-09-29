# Workflow OS Task Agenda Standard

`wos-task` is a universal, source-neutral task inbox. It captures action items, deliverables, follow-ups, and commitments from any user-supplied material or available approved connector, then presents the work in a concise agenda.

## Source boundary

Supported sources include:

- `manual` — typed chat input or a stated commitment.
- `meeting` — supplied notes, transcript, recording summary, or approved meeting connector.
- `jira` — a Jira issue or search read through the available approved Jira tool.
- `email` — an approved email connector or user-supplied email content.
- `calendar` — an approved calendar connector or user-supplied event.
- `zoom` — an approved Zoom source or supplied meeting content.
- `document` — an uploaded or supplied document, spreadsheet, slide deck, or policy.
- `other-approved` — any other source the user has authorized and the active surface can read.

Never claim to pull a source that is not available. State the gap briefly, then accept pasted text, an upload, or a manual item instead. Source pulls are read-only unless the user separately asks for and confirms an external write.

## Normalize every item

For each actionable item, preserve:

| Field | Rule |
| --- | --- |
| ID | Stable short ID, for example `T-001`. |
| Task | Concrete action or deliverable; begin with a verb where practical. |
| Source | One supported source label. |
| Owner | `me` by default; retain another explicit owner. |
| Status | `new`, `active`, `waiting`, `blocked`, `done`, or `cancelled`. |
| Due | Absolute date/time when the source makes it clear; otherwise `none`. |
| Next action | The next concrete move. |
| Link | Source link, Jira key, document name, meeting name, or `none`. |

Prioritize actions assigned to the current user. Exclude tasks clearly assigned to someone else unless the user asks for a team agenda. If ownership is ambiguous, use `me?` or `unassigned?` and ask only if a decision is needed.

## Default delivery: agenda brief

When the user asks to show, refresh, or summarize an agenda, return an in-chat brief, not HTML or a file. Surface at most seven open items:

```text
TODAY — <count>
• <task> — <due or priority cue>
  Next: <next action>

NEXT — <count>
• <task>

WAITING / BLOCKED — <count>
• <task> — waiting on <owner or dependency>

FOCUS
<one highest-value next action>
```

Order Today by overdue and due time, Next by due date and impact, and Waiting/Blocked separately. Do not add decorative metrics or a dashboard. If there are no items in a section, omit it.

## Detail on request

- **Full agenda**: show the complete table using the fields above.
- **Source view**: filter by source, for example Jira, meeting, email, or document.
- **Time view**: show today, this week, overdue, or a user-named date range.
- **Task card**: show one item with its full provenance, status, blocker, and next action.
- **Prioritization**: recommend the top three with one concise reason each.

## Continuity and Jira

Keep the working agenda in the current conversation and native memory already available on the active surface. Do not create a database, local agenda file, memory receipt, or automatic summary.

In Codex-local mode only, a user may choose to set an `active_task` pointer. It is never required and is unavailable in ChatGPT Work.

For durable shared work, prepare a Jira-ready draft and route the actual create, update, comment, or transition through `wos-jira`. All Jira writes require the current-turn confirmation and WOS emoji format; deletes and archives are blocked.
