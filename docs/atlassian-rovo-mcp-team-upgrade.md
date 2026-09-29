# Atlassian Rovo MCP Upgrade — Team Guide

## Purpose

Use this guide to move from the legacy Atlassian integration to the current **Atlassian Rovo** connector in Codex. It connects Jira and Confluence through Atlassian's cloud-hosted MCP service and signs in as each teammate, so every action continues to respect that person's existing Atlassian access.

Workflow OS — Jira v0.2.9 is updated for the new connector. Its safety rules do not change: reads are allowed, every Jira write needs explicit confirmation in the same chat turn, and agents must never delete or archive Jira content.

Simple ticket comments can use one status marker and one factual sentence. For every comment, Workflow OS selects the appropriate depth, previews it, asks whether it should be simpler, and then separately requests permission to post. Progress handoffs, blockers, transitions, and closure retain the structured Workflow OS comment format.

## Before you start

- Remove any `service_tier = ...` line from `%USERPROFILE%\.codex\config.toml`. Service-tier values are validated by the installed Codex runtime; a stale value can prevent a task from starting before the Rovo connector or Workflow OS Jira plugin loads.
- Use Codex Desktop and confirm you can sign in to the intended Atlassian Cloud site.
- Do not share API tokens, passwords, or browser-session data in chat or configuration files.
- Keep Atlassian CLI (`acli`) installed if you use it today. It remains the fallback when the connector lacks an operation or is unavailable.
- Complete this update in a new Codex task after installation, so the new connector's tools are loaded.

## Update steps

1. In Codex Desktop, open **Plugins** or **Connectors**.
2. Find and install **Atlassian Rovo**. It is the official connector backed by `https://mcp.atlassian.com/v2/mcp`.
3. Complete the browser sign-in and OAuth authorization with your normal Atlassian account.
4. If the legacy Atlassian connector is still installed, leave it in place until the test below passes. Then uninstall the legacy connector to prevent an agent selecting obsolete tool paths.
5. Update Workflow OS — Jira to v0.2.9 from the Workflow OS marketplace.
6. Start a **new Codex task** and run `$jira-setup` (or ask it to validate the Rovo connector and your Jira defaults).

## Verify the connector

In the new task, send this read-only prompt:

```text
Use Atlassian Rovo to list my accessible Atlassian resources, then retrieve Jira issue ASD-1 if I have access. Do not write or change anything.
```

Success means Codex can identify an accessible Atlassian site and either retrieve the issue or clearly report that the specific issue is not visible. A sign-in, permission, or unavailable-tool error is not a successful test.

For an additional no-write check, ask Codex to retrieve the issue types available in a Jira project you use. For `ASD`, it must be able to verify the exact AI-related issue type and service/request type before any ticket creation.

## What changes in Workflow OS — Jira

The new Rovo connector exposes a small core set of tools and discovers further capabilities when needed. Workflow OS now uses operation names rather than legacy, client-specific `_search`, `_fetch`, or `_createjiraissue` paths:

| Need | Current Rovo operation |
| --- | --- |
| Read a known ticket | `getJiraIssue` |
| Run a Jira query | `searchJiraIssuesUsingJql` |
| Search a phrase | `search` |
| Create a ticket | `createJiraIssue` |
| Update a ticket | `editJiraIssue` |
| Add a comment | `addOrEditJiraIssueComment` |
| Discover optional tools | `discover`, then `executeRead` or `executeWrite` |

The exact wrappers Codex displays can vary by session. This is expected. Tool availability also depends on your Atlassian access and the permission groups enabled by the organization.

## Safety rules that remain in force

- Jira reads are allowed.
- Every Jira create, edit, comment, transition, or worklog requires clear user confirmation in the current turn after the full payload is shown.
- Workflow OS writes retain the standard emoji-based title, description, and comment format.
- Jira delete and archive operations are prohibited for agents through Rovo, ACLI, and every other route. If deletion is required, the teammate must perform it manually in Jira.
- Never put passwords, API tokens, or secrets in a Jira field, a prompt, a command line, or a temporary file.

## Troubleshooting

| Symptom | What to do |
| --- | --- |
| Codex asks you to sign in | Complete the OAuth browser flow, then retry in a new task. |
| No Jira site appears | Confirm you signed in with the expected Atlassian account and that it has Jira product access. |
| A tool is unavailable | The Rovo catalog is dynamic. Let Workflow OS discover the operation; if it is still unavailable, use the authenticated `acli` fallback. |
| A write operation is unavailable | Do not work around confirmation or permissions. Use `acli` only if it can perform the same approved write safely; otherwise ask the Jira administrator to enable the required Rovo permission group. |
| Rovo call fails unexpectedly | Retry once only when safe, then use `acli` or report the error. Do not create a duplicate ticket. |
| ASD type cannot be verified | Stop before creating the ticket. Workflow OS must not guess an ASD issue or service/request type. |

## Administrator notes

Rovo MCP is authenticated with OAuth 2.1 and honors the user’s existing permissions. Tool availability is controlled by Atlassian permission groups. The Jira read, write, and search groups must be available for the corresponding Workflow OS functions. Atlassian’s delete Jira group is disabled by default and must remain unavailable to Workflow OS agents.

Atlassian’s current setup and supported-tools documentation:

- [Getting started with the Atlassian Rovo MCP Server](https://developer.atlassian.com/cloud/rovo-mcp/guides/getting-started/)
- [Atlassian Rovo MCP supported tools](https://developer.atlassian.com/cloud/rovo-mcp/guides/supported-tools/)
