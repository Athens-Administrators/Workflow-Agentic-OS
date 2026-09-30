# WOS Suite 2.0 Beta — Existing Install Migration

Use this guide for an existing Workflow OS profile. It is an upgrade, not a reinstall.

## What it preserves

- `~/.codex/workflow-os.json` and `<data_root>/.agent/local.json`
- User role, work style, Jira defaults, Documentation routes, plugin choices, WOS.md markers, active pointers, legacy SQLite data, and OneDrive snapshots
- Unrelated Codex configuration and local repositories

## One-action migration

1. Sync the `workflow-os` marketplace from `https://github.com/Athens-Administrators/Workflow-Agentic-OS.git`.
2. Start a fresh chat and run `$suite-2-migration`.
3. Review its inventory. It will not rerun `$welcome` for a usable profile.
4. Confirm the one retirement action only if the inventory is correct. It removes WOS Memory Engine/DR configuration, deregisters the Memory Engine runtime and hook, and removes the exact `Workflow OS DR Snapshot` scheduled task when present.
5. In the same confirmed action, uninstall only `wos-memory-engine` and `wos-dr` in `/plugins` if the host exposes an uninstall control. Do not delete their caches, legacy SQLite data, or OneDrive snapshots.
6. Update only the Suite 2 plugins the user already has installed. Preserve optional Memory Lite, Project, and Task choices; Memory Lite is the recommended context companion if the user asks to add one.
7. Restart Codex and validate in a fresh chat.

## Completeness rules

- A complete profile continues silently.
- An incomplete Jira profile prompts only for `$jira-setup`.
- An incomplete Documentation profile prompts only for `$documentation-setup`.
- DR is never a Suite 2 completeness requirement.
- Offer `$welcome` only when there is no usable profile.

## Compatibility matrix

The source compatibility matrix is [wos-suite-2-beta.json](../release/wos-suite-2-beta.json). `wos-memory-lite` is approved as `2.0.0-beta`; the remaining component versions stay as recorded in the matrix. Sync this beta lane for testing before any production marketplace release.

## Pilot exit checks

- No repeat onboarding.
- Jira and Documentation setup markers remain intact.
- No Memory Engine startup hook runs.
- No `Workflow OS DR Snapshot` task remains.
- Legacy data, WOS.md markers, user preferences, and OneDrive snapshots are unchanged.
- The fresh chat shows the approved Suite 2 component versions.
