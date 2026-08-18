---
name: azure-boards-setup
description: Configure Workflow OS Azure Boards defaults for a development-team user. Verifies connector identity and organization, records Sandbox as the only write target, and records ClaimImport as read-only reference.
---

# `$azure-boards-setup` - Azure Boards Setup

You are configuring the standalone `wos-azure-boards` plugin.

## Required References

Load these before asking questions:

- `${plugin_root}/../references/access-policy.md`
- `${plugin_root}/../references/azure-boards-tooling.md`
- `${plugin_root}/../references/azure-boards-standard.md`
- `${plugin_root}/../references/dev-workflow-model.md`

## Steps

1. Verify the user is setting up a Development / DBA team profile or explicitly says this is for development-team Azure Boards work.
2. Use the Azure Boards connector first:
   - Call `mcp__codex_apps__azure_boards._get_me`.
   - Call `mcp__codex_apps__azure_boards._get_organizations`.
3. Confirm the expected organization is `AthensTest`.
4. Record the effective connector identity. The currently verified identity is `Admin Anthony Casas <Admin-Acasas@athensinsurancesvc1.onmicrosoft.com>`.
5. Ask whether Azure DevOps CLI should be used as a fallback only if `az devops` is separately authenticated. Do not require CLI auth for connector-backed setup.
6. Confirm project boundaries with the user:
   - `Sandbox` is the only confirmed write/testing project.
   - `ClaimImport` is read-only and used only as a reference point for how the team works.
7. If available through connector, CLI, or browser, inspect projects and work item types read-only. Do not write.
8. Ask whether the user wants to run `$azure-boards-discover` after setup to learn the development team's real board conventions from `ClaimImport`. Discovery remains read-only and should produce user-agnostic patterns, not raw card exports.
9. Produce the Azure Boards profile:

```json
{
  "organization": "AthensTest",
  "organization_url": "https://dev.azure.com/AthensTest",
  "connector_identity": "Admin Anthony Casas <Admin-Acasas@athensinsurancesvc1.onmicrosoft.com>",
  "read_write_projects": ["Sandbox"],
  "read_only_projects": ["ClaimImport"],
  "default_write_project": "Sandbox",
  "reference_project": "ClaimImport",
  "workflow_discovery_source": "ClaimImport",
  "workflow_discovery_status": "not_run|completed|skipped",
  "cli_fallback": "available|not_authenticated|not_installed",
  "setup_completed_at": "<ISO timestamp>"
}
```

10. If Workflow OS local state is available, persist the setup profile under `plugin_state.wos-azure-boards`. If local state is unavailable, keep the profile in the conversation and do not fail setup.

## Hard Rules

- Setup performs reads only.
- Do not write to Azure Boards during setup.
- Do not modify `ClaimImport`.
- Do not store credentials, PATs, tokens, or tokenized URLs.
