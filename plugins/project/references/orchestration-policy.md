# Workflow OS Project Collaboration Policy

Project collaboration is optional, explicit, and proportional to the work. A project starts local-first; Jira is recommended when shared work needs its visibility, but it is never required.

## Tracking modes

| Mode | Default behavior | When to use it |
| --- | --- | --- |
| **Local** | Current chat, native memory, and an optional `WOS.md` locator. No tracker calls. | Personal work, small initiatives, or a user who does not use a shared tracker. |
| **Jira-linked** | Jira can hold shared phases, status, ownership, blockers, and dependencies. | Recommended when several people need a durable shared view. |
| **External** | WOS uses user-provided context and supplies copy-ready updates. It does not assume another tracker integration. | A team using another approved system. |

## Collaboration level

Default to **linear work**. Offer a dependency or parallel-work review only when the user asks for `$project-orchestrate` or clearly asks to coordinate independent streams.

Before parallel work, show a compact graph and identify the evidence behind each dependency:

```text
Phase 1 -> Phases 2 and 3 (only if independent) -> integration
```

Use Jira issue links and descriptions/comments for Jira-linked projects. Otherwise use the confirmed current-chat plan and any user-provided external-tracker context. Do not invent dependencies. If ownership, files, systems, or rollback expectations overlap, keep the work linear.

## Delegation boundaries

- Use one main thread for simple or overlapping work.
- Delegate only clearly bounded, independently verifiable streams after the user explicitly asks to implement the approved plan.
- Use isolated worktrees for parallel file-changing work in a Git workspace.
- Do not delegate user decisions, secrets/credentials, manual UI authorization, unclear scope, or production changes without an agreed rollback path.
- Each delegated stream reports only: outcome, files/systems changed, verification, blockers, and recommended next step.

## Jira safeguards

Jira reads are available only when the project is Jira-linked. Before any Jira create, edit, comment, transition, or link, display a current-turn write manifest. Execute only the approved listed writes and use the WOS Jira emoji format. Deletes and archive actions remain blocked.

## Explicit handoffs

At a pause, checkpoint, or closeout, offer the user a chat recap, a draft for the selected tracker, or a compact confirmed `WOS.md` handoff. Never create a record automatically.
