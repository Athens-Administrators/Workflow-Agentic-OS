# WOS Documentation Update

## Version

`wos-documentation` v0.1.13

## What changed

This update tightens the documentation workflow so WOS Documentation follows the same process no matter how a user asks for a KB article, draft, refresh, review, or Confluence publish.

### Duplicate and similar KB preflight

Every new Confluence page create now checks the resolved target space for an existing exact, overlapping, or
related KB before the create confirmation.

When a candidate is found, WOS Documentation compares the proposed and existing
articles by purpose, audience, prerequisites, procedure, validation/outcome,
and ownership. It then shows the candidate link and material differences for the
user to decide whether to:

- Skip the submission and use the existing article.
- Create a new page with a different title, then rerun the target-space check.

The user must still explicitly confirm the Confluence create after making that
choice. Every new page also receives a `Related to:` slug directly below the H1.
It links to the similar article when one exists; otherwise it records that no
similar article was identified in the target space. WOS Documentation never
invents a related-article link.

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

- All Help Desk and public-facing Athens employee content: `HelpDesk Knowledge` / `HK`
- Infrastructure internal documentation: `Internal Infrastructure KB` / `IIK`
- DEV/DBA internal documentation: `Dev Team KB` / `DTK`

Users can still provide a one-request Confluence space override, but that does not change the saved route default.

`JSM Optimization Advisory` is intentionally out of scope for WOS Documentation route defaults.

### Help Desk routing rules

Help Desk documentation now uses one space. Article purpose selects the template:

- Public-facing employee help article, troubleshooting article, system process, internal process, and internal how-to: `HelpDesk Knowledge` / `HK`

### Infrastructure and DEV/DBA routing rules

Infrastructure and DEV/DBA do not share spaces.

- Infrastructure internal docs go to `Internal Infrastructure KB` / `IIK`.
- DEV/DBA internal docs go to `Dev Team KB` / `DTK`.
- Employee-facing Infrastructure or DEV/DBA content uses the Public-facing route in `HelpDesk Knowledge` / `HK`, with the owning team recorded.

For Infrastructure requests, the plugin asks whether the article is:

- Runbook KB article: break/fix, operational steps, commands, validation, rollback, or technical task execution.
- Business Process KB article: workflow, handoff, approval path, team procedure, or how work moves from start to finish.

DEV/DBA uses its configured route template and records `Owning team: DEV/DBA`; its document-type model is pending team confirmation. The redundant internal/public follow-up is removed: use the Public-facing route for employee-facing content.

### Existing long-document behavior remains

The v0.1.8 long-document behavior still applies:

- Treat long, unstructured, OneNote-derived, or PDF-like material as raw source.
- Prefer one continuous Confluence article whenever practical.
- Split into multiple Confluence pages only when separate reader workflows genuinely justify it.
- Do not exceed five pages when a split is truly required, and prefer fewer.

## What users need to do

After the Workflow OS marketplace is updated from GitHub, users should update or reinstall `wos-documentation` from `/plugins` so Codex loads v0.1.13.

Expected plugin version:

- `wos-documentation` v0.1.13

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
- The target space should be `HelpDesk Knowledge` / `HK` for this example.

## Duplicate-check test prompt

```text
Create a new Help Desk troubleshooting KB in HK titled "Fix Intune enrollment after Entra ID rejoin." Check for duplicate or similar articles before you publish it.
```

Expected behavior:

- WOS Documentation searches only the resolved target space before requesting a create confirmation.
- A similar candidate is shown with a comparison and link.
- The user is offered skip submission or create with a different title.
- The final proposed document includes a `Related to:` slug directly below its H1.
