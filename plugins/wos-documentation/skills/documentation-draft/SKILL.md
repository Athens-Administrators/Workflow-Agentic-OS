---
name: documentation-draft
description: "Draft documentation after selecting the required WOS documentation route: Help Desk, Infrastructure, DEV/DBA team, or public-facing for Athens employees."
---

# `$documentation-draft` - Draft Documentation

Use when the user asks to create, rewrite, or structure documentation before publishing. If the user asks to refresh an existing KB article into the approved standard, use `$kb-refresh`; KB Refresh is the named feature for existing KB cleanup and restructuring.

## Required References

Load these before drafting:

- `${plugin_root}/../references/setup-gate.md`
- `${plugin_root}/../references/documentation-standard.md`
- `${plugin_root}/../references/confluence-workflow.md`
- `${plugin_root}/../references/templates.md`
- `${plugin_root}/../references/visual-assets.md`

Apply `setup-gate.md` before drafting. If persistent Documentation setup is not complete, run the per-document walkthrough for the current document.

## Required Route Question

Any time the user documents something they ran, ask which route this is for unless the route is already explicit in the request:

- Help Desk.
- Infrastructure.
- DEV/DBA team.
- Public-facing for Athens employees.

The selected route determines the default Confluence space and template. If the route has no configured template, offer a built-in template choice from `templates.md`.

For Help Desk, offer:

1. `ahi_how_to` - primary choice for how-to documentation.
2. `ahi_troubleshooting` - internal agent troubleshooting guide.

For Help Desk internal troubleshooting, use `ahi_troubleshooting` with the required emoji section headings from `templates.md`.

For Public-facing for Athens employees, use `ahi_how_to` in `HelpDesk Knowledge` / `HK`.

Use `HelpDesk Knowledge` / `HK` for all Help Desk and public-facing Athens employee content unless the user gives a temporary override. Article purpose selects the template, not a different space.

For Infrastructure, offer:

1. Runbook KB article - use `infra_dev_break_fix_runbook` for break/fix or technical operations.
2. Business Process KB article - use `infra_dev_standard` for repeatable workflows, handoffs, approvals, and team procedures.

If the user is unsure, explain the difference plainly:

- A Runbook KB article is for fixing or operating something technical: symptoms, commands, validation, rollback, or expected system state.
- A Business Process KB article is for explaining how a repeatable business or team workflow should happen from start to finish.

For DEV/DBA, use the configured route template and record `Owning team: DEV/DBA` in the draft preface. Its document-type model is pending team confirmation. Do not ask a separate internal-or-public audience question; employee-facing content uses the Public-facing for Athens employees route.

## Inputs To Determine

Determine from the request or ask only when necessary:

- Route: `help_desk`, `infrastructure`, `dev_dba`, or `public_athens`.
- KB article type for Infrastructure: Runbook KB article or Business Process KB article. DEV/DBA uses its configured template while its document-type model is pending team confirmation.
- Audience: derived from the selected route. `public_athens` is employee-facing; the other routes are internal.
- Owning team: required for DEV/DBA and for public-facing material that originates with Infrastructure or DEV/DBA.
- Topic and goal.
- Target Confluence space: route-assigned space unless the user gives a temporary override. Help Desk and public-facing documentation use `HelpDesk Knowledge` / `HK`; Infrastructure uses `Internal Infrastructure KB` / `IIK`; DEV/DBA uses `Dev Team KB` / `DTK`.
- Template source: route-assigned Confluence template, supplied Confluence URL, `ahi_how_to`, `ahi_troubleshooting`, `infra_dev_standard`, or `infra_dev_break_fix_runbook`.
- Intended placement, if the user already knows it: root, route default parent, existing parent page, or new parent page.
- Source material: pasted notes, files, Jira tickets, Confluence pages, or user explanation.
- Whether the user wants a draft only or wants to publish after review.
- Whether the article needs screenshots, extracted video frames, diagrams, or visual callouts.

## Required Question Gate

Before drafting, check whether required information is missing. If it is missing, ask direct questions and stop. Do not output a completed draft after listing gaps.

The phrase "let me know if there are gaps" means ask the missing questions first. It does not authorize a publish-ready draft with unresolved gaps.

For Help Desk troubleshooting articles, ask direct questions when any of these are unclear:

- Exact problem, symptom, error, or requested support action.
- Known user/device/ticket/reference values and which should be placeholders.
- Approved resolution path, including whether commands, Windows Settings, or admin actions are allowed.
- Required access level or role.
- Validation checks.
- Escalation owner.
- Confluence placement if publishing is requested.

## Drafting Rules

- Use the configured route template or supplied Confluence template first when available.
- Use `ahi_how_to` for public-facing how-tos and Help Desk how-to documentation.
- Use `ahi_troubleshooting` for internal agent troubleshooting guides.
- Preserve the exact emoji section headings for all built-in templates, including Help Desk templates.
- Infrastructure and DEV/DBA may use the shared templates, but do not share Confluence spaces. DEV/DBA uses the configured route template until its document-type model is confirmed.
- For Infrastructure, use `infra_dev_break_fix_runbook` for Runbook KB articles and `infra_dev_standard` for Business Process KB articles.
- For employee-facing material owned by Infrastructure or DEV/DBA, use the Public-facing for Athens employees route and keep it employee-safe: concise, no internal-only commands, no privileged access steps, and no internal escalation detail that employees should not act on directly.
- Use the exact section emojis defined in `templates.md`.
- Keep public-facing docs simple, concise, and action-oriented.
- Keep internal docs practical and complete, but usually one page.
- For long or PDF-like source material, draft one continuous Confluence article whenever practical.
- Split into multiple Confluence pages only when separate reader workflows justify it; keep the set to five pages maximum and prefer fewer.
- Include validation or expected result.
- Include support path or ownership.
- Link to sources rather than copying long source content.
- Do not include secrets or sensitive values.
- Apply `visual-assets.md` when visuals are mentioned or useful. If screenshots, video frames, or diagrams are needed, include a compact visual asset register before the draft unless the visuals are already available and obvious.
- If a visual is not available, include an exact placeholder such as `[Screenshot needed: <exact screen or state>]`.
- Use available screenshot/image files when provided. Use optional video-frame extraction only when a compatible helper is installed and usable; otherwise create timestamped screenshot capture targets.

## Output

Return a Confluence-ready draft in Markdown or Atlassian-document-friendly structure.

Include a short preface with:

- Audience.
- Route.
- Owning team, when applicable.
- Target space.
- Template used, if any.
- Intended placement, if known.
- Any source gaps or assumptions.
- Visual assets, placeholders, or capture targets when visuals are needed.

Do not include a "Gaps To Confirm" section followed by a completed draft. If gaps are blocking, output only the questions to answer next.

Do not publish unless the user explicitly asks and confirms the Confluence write in the current turn.
