# WOS Documentation Update

## Version

`wos-documentation` v0.1.9

## What changed

This update tightens the documentation workflow so WOS Documentation follows the same process no matter how a user asks for a KB article, draft, refresh, review, or Confluence publish.

### Route selection is required

Every documentation request must identify one of these routes before the plugin drafts, refreshes, reviews, or publishes:

- Help Desk
- Infrastructure
- DEV/DBA team
- Public-facing for Athens employees

If the user already states the route clearly in the request, the plugin can use it. If the route is missing or unclear, the plugin must ask before continuing.

### Required question gate

When required information is missing, WOS Documentation must ask direct questions before drafting.

This means:

- "Let me know if there are gaps" means ask the missing questions first.
- The plugin must not provide a completed draft after listing unresolved gaps.
- Blocking gaps should stop the draft until the user answers.
- Non-blocking unknowns can still be marked as `[TBD]` or `<PLACEHOLDER>` after the required intake is complete.

For Help Desk troubleshooting articles, WOS Documentation now asks for missing details such as:

- Exact issue, symptom, error, or requested support action.
- Known user, device, asset, ticket, or reference values.
- Which values should become placeholders.
- Approved resolution path.
- Whether commands, Windows Settings, or admin actions are allowed.
- Required access level or role.
- Validation checks.
- Escalation owner.
- Confluence placement when publishing is requested.

### Emoji section headings are required

All built-in templates now require emoji section headings.

This applies to:

- AHI How-To
- AHI Troubleshooting
- Infrastructure/DEV Standard Page
- Infrastructure/DEV Break/Fix Runbook
- Help Desk Runbook
- Infrastructure Runbook
- DEV/DBA Technical Note
- Public-Facing Guide
- Internal Runbook
- Internal Decision Note

The plugin must preserve the emoji in each section heading even if the source material or the user request does not include emojis.

### Confirmed Confluence spaces

WOS Documentation now uses the confirmed Confluence spaces by default:

- Public-facing Athens employee and Help Desk public content: `HelpDesk Public` / `AEHT`
- Help Desk troubleshooting articles: `HelpDesk Troubleshooting` / `AHI`
- Help Desk system-process and internal how-to documentation: `HelpDesk System Processes` / `AIH`
- Infrastructure internal documentation: `Internal Infrastructure KB` / `IIK`
- DEV/DBA internal documentation: `Dev Team KB` / `DTK`

Users can still provide a one-request Confluence space override, but that does not change the saved route default.

`JSM Optimization Advisory` is intentionally out of scope for WOS Documentation route defaults.

### Help Desk routing rules

Help Desk documentation now routes by article purpose:

- Public-facing employee help article: `HelpDesk Public` / `AEHT`
- Troubleshooting article for agents: `HelpDesk Troubleshooting` / `AHI`
- System process, internal process, or internal how-to: `HelpDesk System Processes` / `AIH`

### Infrastructure and DEV/DBA routing rules

Infrastructure and DEV/DBA share templates, but they do not share spaces.

- Infrastructure internal docs go to `Internal Infrastructure KB` / `IIK`.
- DEV/DBA internal docs go to `Dev Team KB` / `DTK`.
- Public-facing Infrastructure or DEV/DBA docs go to `HelpDesk Public` / `AEHT`.

For Infrastructure or DEV/DBA requests, the plugin must ask whether the article is:

- Runbook KB article: break/fix, operational steps, commands, validation, rollback, or technical task execution.
- Business Process KB article: workflow, handoff, approval path, team procedure, or how work moves from start to finish.

The plugin must also confirm whether the page is internal or public-facing for Athens employees.

### Existing long-document behavior remains

The v0.1.8 long-document behavior still applies:

- Treat long, unstructured, OneNote-derived, or PDF-like material as raw source.
- Prefer one continuous Confluence article whenever practical.
- Split into multiple Confluence pages only when separate reader workflows genuinely justify it.
- Do not exceed five pages when a split is truly required, and prefer fewer.

## What users need to do

After the Workflow OS marketplace is updated from GitHub, users should update or reinstall `wos-documentation` from `/plugins` so Codex loads v0.1.9.

Expected plugin version:

- `wos-documentation` v0.1.9

After updating, teammates do not need to memorize the space keys. The plugin should route to the correct default space after it identifies the route, article purpose, and audience.

## Quick test prompt

Use this prompt after updating to confirm the behavior:

```text
Use WOS Documentation to make a Help Desk internal troubleshooting KB from this short note. Let me know if there are gaps.

Note:
Device needs to leave and rejoin Entra ID before Intune enrollment works. User was told to reboot and sign back into Office.
```

Expected behavior:

- WOS Documentation should ask direct questions first.
- It should not provide a completed draft with unresolved gaps.
- When the draft is created later, the sections should use emoji headings.
- The target space should be `HelpDesk Troubleshooting` / `AHI` for this example.
