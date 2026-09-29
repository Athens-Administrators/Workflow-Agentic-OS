# Workflow OS — Jira Tooling Policy

Workflow OS uses the current Atlassian Rovo MCP connector first and the official Atlassian CLI (`acli`) as a deterministic fallback. The connector is cloud-hosted at `https://mcp.atlassian.com/v2/mcp`, authenticates as the current user through OAuth 2.1, and respects that user's Atlassian permissions.

## Connector contract

Do not depend on legacy `mcp__codex_apps__atlassian_rovo._...` tool paths. The current connector exposes a small primary tool set and discovers the rest on demand. Tool wrappers may have a client-specific prefix, so select tools by their operation name and purpose rather than a hard-coded wrapper name.

1. Confirm the connector is authenticated and call `getAccessibleAtlassianResources` when a site or `cloudId` is required.
2. Use primary Jira tools when available: `getJiraIssue`, `searchJiraIssuesUsingJql`, `createJiraIssue`, `editJiraIssue`, `transitionJiraIssue`, and `addOrEditJiraIssueComment`.
3. Before a deferred operation, call `discover` with a precise natural-language request. Invoke the returned tool through `executeRead` or `executeWrite` as its risk tier requires.
4. Tool availability is dynamic: it depends on the authenticated user, enabled permission groups, and available app access. If the necessary Rovo operation is not available or fails for a reason other than a missing issue, use `acli` as the fallback.

## Tool order

1. **Exact Jira-key read:** use `getJiraIssue` with the key. Use `searchJiraIssuesUsingJql` with `key = <KEY>` when a filtered result or selected fields are needed.
2. **Semantic lookup:** use Rovo `search` only when the user supplied a phrase rather than a key. It may consume Rovo credits. Retrieve the chosen work item with `getJiraIssue` or Teamwork Graph context when more detail is required.
3. **Metadata before writing:** use `listJiraProjectIssueTypesMetadata` and `getJiraIssueTypeMetaWithFields` (via `discover` when deferred) to verify issue type and fields. For ASD, do not create until the AI-related issue/request type can be verified and set.
4. **Writes:** draft the full payload, show it, and wait for the user's explicit confirmation in the current turn. Use `createJiraIssue`, `editJiraIssue`, `transitionJiraIssue`, or `addOrEditJiraIssueComment` only after that confirmation.
5. **Fallback:** use `acli` only when Rovo is unavailable, lacks the required operation, or returns a non-not-found operational failure.

## Example exact-key query

```text
Operation: searchJiraIssuesUsingJql
Site: selected accessible Jira cloud resource
JQL: key = TPM-123
Fields: summary, issuetype, status, project, parent
Max results: 1
```

If one result returns, capture at least the key, summary, issue type, status, project, and web URL when available.

## Chat usage

When the user asks for Jira work directly in chat, the agent may use this tooling without invoking a Workflow OS skill, provided that the same safety rules apply:

- Jira reads are allowed.
- Jira writes require explicit user confirmation in the current turn.
- Jira comments, descriptions, transitions, and worklogs must follow `emoji-format.md` when the write originates from Workflow OS.
- No secrets may be included in Jira text, command arguments, logs, memory notes, or temporary files.

## `acli` commands

Check installation:

```powershell
acli --version
```

Check auth:

```powershell
acli auth status
acli jira auth status
```

Authenticate interactively:

```powershell
acli jira auth login --web
```

Read an issue:

```powershell
acli jira workitem view "<KEY>" --json
```

Post an approved comment from a temporary file:

```powershell
acli jira workitem comment create --key "<KEY>" --body-file "<TEMPFILE>"
```

## Hard boundaries

- **Never use Rovo or `acli` delete/archive operations.** This includes `executeDestructive`, `deleteJiraIssue`, `deleteJiraComment`, `acli jira workitem delete`, `acli jira workitem archive`, comment deletes, link deletes, and equivalent destructive operations. These remain manual for the user.
- Do not use `acli` to bypass Rovo or Workflow OS safety boundaries.
- Do not pass secrets through command-line arguments.
- For writes, draft first, show the payload, and wait for explicit confirmation.
