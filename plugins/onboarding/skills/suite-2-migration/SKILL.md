---
name: suite-2-migration
description: Perform the one-action, profile-preserving WOS Suite 2.0 Beta migration. Use for an existing Workflow OS install that must retire WOS Memory Engine and WOS DR without rerunning onboarding.
---

# WOS 2 Beta Migration Assistant

Use this skill only for an existing Workflow OS profile. It is an **upgrade**, never a reinstall.

## Required sequence

1. Run `${plugin_root}/scripts/migrate/Invoke-WosSuite2BetaMigration.ps1 -Mode Inventory` and read its JSON. The inventory first checks the normal sentinel, then the legacy `WOS_DATA_ROOT` and default `%USERPROFILE%\\workflow-os-data` locations for an existing `.agent\\local.json`.
2. If a valid legacy profile is found without a sentinel, treat it as an upgrade: preserve its profile and create only the missing sentinel pointer during Apply. If `profile.usable` is false after those checks, do not modify anything. Offer first-time onboarding only when no usable profile exists.
3. If Jira is incomplete, tell the user to run only `$jira-setup`. If Documentation is incomplete, tell the user to run only `$documentation-setup`. A missing DR marker is never an incomplete-profile condition.
4. Treat the user's explicit Upgrade or Install action as the one migration confirmation. Before applying it, show one concise inventory that names only the present retired artifacts: `wos-memory-engine`, `wos-dr`, the Memory Engine MCP/hook registration, and the exact `Workflow OS DR Snapshot` task when present. State that local profile fields, WOS.md markers, legacy SQLite data, plugin caches, and OneDrive snapshots will remain untouched.
5. Run `${plugin_root}/scripts/migrate/Invoke-WosSuite2BetaMigration.ps1 -Mode Apply -ConfirmRetirement` as part of that confirmed upgrade/install action. Do not ask for a second confirmation.
6. In the same confirmed action, use the Codex Plugins Directory/plugin-management capability to uninstall `wos-memory-engine` and `wos-dr`. Do not remove any other plugin. If the host does not expose an uninstall action, say so plainly and give the exact two plugin names for the user to remove in `/plugins`; do not delete cache folders as a workaround.
7. Refresh the `workflow-os` marketplace through the supported marketplace flow, then update only Suite 2 plugins that were already installed. Do not auto-install Memory Lite, Project, or Task; preserve those choices. Memory Lite is the recommended context companion if the user asks to add a context component.
8. Ask the user to restart Codex and validate in one fresh chat. Check that the retired Memory Engine startup hook no longer runs, the DR task is gone, Jira/Documentation setup markers remain intact, and no legacy data or OneDrive snapshots were changed.

## Boundaries

- Never run `$welcome` for a complete profile.
- Never delete legacy SQLite data, WOS.md markers, existing OneDrive backups, unrelated Codex configuration, or cache folders.
- Never require DR as part of Suite 2 completeness.
- Component versions come from `${plugin_root}/release/wos-suite-2-beta.json`. Memory Lite is approved as `2.0.0-beta`; the suite may be synced to a beta marketplace lane but is not automatically published to the production marketplace.
