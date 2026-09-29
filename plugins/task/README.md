# WOS Task

`wos-task` manages explicit Codex-conversation task agendas, meeting action capture, one-off task lifecycle, deliberate handoffs, completion, and optional Jira personal task-board sync.

## Continuity

The current chat and native Codex memory are primary for personal continuity. Jira is the durable source for shared active work. The optional local `active_task` value is only a convenience pointer for the current machine; it is not a task database.

Use `$task-checkpoint` when a concise, deliberate handoff is needed. It produces a chat recap or Jira-ready draft only after the user chooses the destination. Task-dashboard export is not part of Memory Lite v1 because it depended on the retired receipt database.
