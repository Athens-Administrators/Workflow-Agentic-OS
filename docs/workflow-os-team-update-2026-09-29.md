# Workflow OS Team Update — September 29, 2026

Use this guide to refresh an existing Workflow OS installation. It covers the
current mandatory baseline and the optional Development / DBA Azure Boards
capability without changing a teammate's local Workflow OS data or optional
plugin choices.

## Released plugin set

- `wos-jira` v0.2.9 or newer — previewed concise or structured updates; Rovo-first access with ACLI fallback.
- `wos-documentation` v0.1.13 — HelpDesk Knowledge routing, simpler intake, visual-asset handling, and duplicate/similar-KB preflight.
- `wos-dr` v0.1.2 — OneDrive snapshot recursion and path-length safeguards.

The mandatory baseline remains `wos-jira`, `wos-documentation`, and `wos-dr`.

## What changed

### Documentation

- All Help Desk and public-facing employee documentation now uses `HelpDesk Knowledge` / `HK`; article purpose selects the template rather than a separate space.
- Infrastructure keeps the Runbook-versus-Business-Process selection. DEV/DBA records its owning team and uses its configured template while its document-type model is pending team confirmation.
- Every new Confluence page create checks the resolved target space for exact,
  overlapping, or related KB articles before the create confirmation.
- When a candidate is found, the user chooses either **skip submission** or
  **create with a different title**; the check is rerun for the new title.
- The final proposed page puts `Related to:` directly below the H1. It uses a
  verified canonical link when a related page exists, or explicitly says that
  no similar article was identified in the target space.
- Screenshots, frames, diagrams, and visual callouts now use a compact asset
  register, exact placeholders, captions/alt text where needed, and a
  sensitivity check before publishing.

### Jira

- Updates can be previewed in a concise or structured form before the user
  confirms the Jira write.
- Jira remains Rovo-first with ACLI as a deterministic fallback. Every write
  still needs explicit current-turn confirmation, uses the WOS emoji format,
  and never deletes or archives Jira content.

### Disaster Recovery

- Snapshot scanning excludes the backup root and uses compact names to avoid
  recursion and Windows path-length failures.
- Existing schedules and backups are preserved; verify the current state with
  `$dr-status` after updating.

## Teammate update steps

1. Confirm the teammate can open the private repository while signed into
   GitHub: <https://github.com/Athens-Administrators/Workflow-Agentic-OS>.
2. In a PowerShell terminal, refresh the Git-backed marketplace:

   ```powershell
   codex plugin marketplace upgrade workflow-os
   ```

   If the marketplace is not registered, add it instead:

   ```powershell
   codex plugin marketplace add https://github.com/Athens-Administrators/Workflow-Agentic-OS.git --ref main
   ```

3. Fully restart Codex, open `/plugins`, and update/reinstall only the Workflow
   OS plugins already installed.
4. Confirm the mandatory plugins are installed at the versions above. If one is
   missing, install it and complete its setup: `$jira-setup`,
   `$documentation-setup`, or `$dr-setup`.
5. Run `$dr-status`. If DR has never been configured, run `$dr-setup`, then
   `$dr-snapshot`, followed by `$dr-status` again.

## Post-update checks

- `/plugins` shows the expected versions for installed Workflow OS plugins.
- Jira setup, Documentation setup, and DR setup are complete.
- `$dr-status` shows a valid backup root, schedule, and latest snapshot.
- A Documentation draft requests its route/template inputs before drafting and
  runs the duplicate check only for a new Confluence page create.
- A Jira update shows the proposed comment before requesting write confirmation.

## Safety carried into this release

- Do not delete, move, or rename teammate data during the update.
- Do not overwrite local tracked changes.
- Do not install optional plugins automatically.
- Jira and Confluence writes require explicit current-turn confirmation.
- Jira delete/archive operations remain unavailable to agents.
- Git commits and pushes require separate explicit confirmation.
