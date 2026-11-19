# Workflow OS Jira 0.4.0

Release date: November 18, 2026

## Changes

- ASD intake asks, in order: self or on behalf (name, email, or both), reporter department, urgent or not urgent, then task or issue.
- Generates the ticket title as Summary; previews the reporter, required values, work type and linked customer request type before submission approval.
- Uses AI Gen Task / AI Generated Request and AI Gen Issue / AI Generated Issue, verified against live configuration.
- Adds `$jira-repair` for read-only historical scans of tickets created by the current user, followed by individually previewed and approved corrections.
- Makes `$jira-setup` optional and removes completion-marker gates from every Jira operational skill. No new completion marker is written.
- Retains per-action write approval, emoji formatting, no bulk repair, and no delete/archive boundaries.

## Distribution

Source: Athens-Administrators/Workflow-Agentic-OS, main branch, marketplace entry wos-jira. Upgrade Workflow OS Jira through the marketplace after its repository source has refreshed. The archive contains the plugin root with its .codex-plugin manifest, skills, references, and assets.

## Validation and limits

Manifest and marketplace source validation, skill frontmatter/reference checks, archive inventory, and git diff checks run before publishing. A scenario review covers intake ordering, ambiguous customer names, stale metadata, missing setup markers, partial historical scans, preview-only repair, and one-ticket approval boundaries.

No Jira writes are used to validate this release. A plugin update does not add an absent connector operation: unsupported request-type writes still stop before creation or repair. Customer portal visibility and email delivery need a separate approved functional test. Existing tickets are not changed by upgrading.
