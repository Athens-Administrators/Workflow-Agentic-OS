# WOS Task

`wos-task` is Workflow OS's universal task inbox. It turns action items, deliverables, and follow-ups from chat, meeting notes, documents, Jira, and available approved connectors into a clear in-chat agenda.

## Continuity

The default delivery is an **agenda brief**: Today, Next, Waiting/Blocked, and one Focus item. Ask for a full agenda, a source view, a time view, or an individual task card only when more detail is useful.

The current chat and native memory are the personal continuity layer. Jira is the durable source for shared active work. The optional `active_task` local pointer is a Codex-local convenience only, not a task database; ChatGPT Work never depends on it.

Use `$task-handoff` for a concise handoff, completion recap, or Jira-ready draft. External writes remain explicit and confirmation-gated.
