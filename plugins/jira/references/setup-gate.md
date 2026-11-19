# Workflow OS Jira Context Resolution

Jira setup is optional. No operational Jira skill may require `$jira-setup`, a saved profile, a completion timestamp, or `plugin_state.wos-jira.setup_completed_at` before proceeding.

Use the current conversation, authenticated connector, and existing preferences to resolve the tenant and project. Ask only for missing or ambiguous details. Offer `$jira-setup` only when the user wants to configure reusable defaults. Existing markers do not authorize writes and their absence does not block work.

Jira reads are allowed. Writes still require per-action approval, the Workflow OS emoji format, and verified required fields. Delete/archive restrictions remain in force.
