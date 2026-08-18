# Workflow OS Azure Boards Setup Gate

Before running any Azure Boards operational skill other than `$azure-boards-setup`, confirm setup is complete.

Check in this order:

1. The current conversation already completed `$azure-boards-setup` and produced an Azure Boards profile.
2. Workflow OS local state exists at `~/.codex/workflow-os.json -> data_root -> .agent/local.json`, and `plugin_state.wos-azure-boards.setup_completed_at` is present.
3. A saved Workflow OS preference exists with Azure Boards organization, identity, project boundaries, and default testing project.

If none of those are true, stop and tell the user:

```text
Workflow OS Azure Boards setup is required before I can continue. Please run `$azure-boards-setup`; I will continue this request after setup is complete.
```

Setup must record at least:

- Connector identity.
- Azure DevOps organization.
- Default read/write project: `Sandbox`.
- Read-only reference project: `ClaimImport`.
- Workflow discovery source: `ClaimImport`.
- Workflow discovery status: `not_run`, `completed`, or `skipped`.
- Access policy acknowledgement.
- Tooling status: connector available, CLI authenticated or not, browser available or not.

Setup never writes to Azure Boards.
