# Workflow OS Azure Boards Access Policy

Azure Boards is a development-team destination in Workflow OS. It is a sibling to Jira, not a replacement for Jira. Jira remains the shared Athens IT team-space platform; Azure Boards tracks development delivery when the development team uses it.

## Known Organization

- Organization: `AthensTest`
- URL: `https://dev.azure.com/AthensTest`
- Connector identity: `Admin Anthony Casas <Admin-Acasas@athensinsurancesvc1.onmicrosoft.com>`
- Blocked alternate identity: `acasas@athensadmin.com` may be blocked by Conditional Access for Azure CLI/plugin sync.

## Project Boundaries

These rules are mandatory:

- `ClaimImport` is reference-only. Agents may read it to understand how the development team is working and to derive user-agnostic workflow patterns. Agents must not create, update, comment, transition, delete, link, tag, assign, or otherwise modify anything in `ClaimImport`.
- `Sandbox` is the testing ground. Confirmed writes may target `Sandbox` only.

If a user asks for a write outside `Sandbox`, stop before drafting the write payload and explain that Workflow OS Azure Boards writes are currently limited to `Sandbox`.

If a user asks for any modification to `ClaimImport`, refuse the write path and offer a read-only inspection or draft text they can manually apply outside Workflow OS.

## Discovery Boundary

Read-only discovery may summarize `ClaimImport` structure, such as work item types, states, common fields, tags, description patterns, and completion evidence. Discovery must not export raw board data, copy sensitive card content, or store unnecessary personal/customer information.

## Write Safety

- Reads are allowed when the connector, browser, CLI, or REST path is authenticated.
- Writes require explicit confirmation in the current turn.
- Deletes and destructive operations are blocked for agents.
- Never store credentials, PATs, tokens, or tokenized URLs.
- Never use CLI or REST as a way to bypass connector or Workflow OS policy.
