---
name: documentation-publish
description: Publish or update Confluence documentation after selecting the required route, applying its assigned template and space, resolving page placement, and getting explicit confirmation.
---

# `$documentation-publish` - Publish To Confluence

Use when the user asks to create or update a Confluence documentation page.

## Required References

Load these before publishing:

- `${plugin_root}/../references/setup-gate.md`
- `${plugin_root}/../references/documentation-standard.md`
- `${plugin_root}/../references/confluence-workflow.md`
- `${plugin_root}/../references/templates.md`
- `${plugin_root}/../references/visual-assets.md`
- `${plugin_root}/../references/duplicate-submission-check.md`

Apply `setup-gate.md` before any publish preflight or Confluence read/write. If persistent Documentation setup is not complete, run the per-document walkthrough for the current document before publishing.

## Preflight

Before any Confluence write:

1. Ask which route this is for unless already explicit: Help Desk, Infrastructure, DEV/DBA team, or Public-facing for Athens employees.
2. For Infrastructure, confirm whether this is a Runbook KB article or Business Process KB article. DEV/DBA uses its configured route template while its document-type model is pending team confirmation.
3. Identify the owning team when the document is DEV/DBA or employee-facing content originated with Infrastructure or DEV/DBA.
4. Identify the route-assigned Confluence space and template, or collect them through the per-document walkthrough. Help Desk and public-facing documentation use `HelpDesk Knowledge` / `HK`; Infrastructure uses `Internal Infrastructure KB` / `IIK`; DEV/DBA uses `Dev Team KB` / `DTK`.
5. Identify whether the space is the route default or a one-request override.
6. Ask where the page should be placed: root of the space, route default parent, existing parent page/folder, or a new parent page.
7. Resolve and confirm the parent page when not publishing at the root.
8. Identify page title and whether this is a create or update.
9. Review the draft against the standard and selected route template.
10. Confirm the selected built-in template's section emojis are present and in order when a built-in template is used, including Help Desk templates.
11. For a new page create, run `duplicate-submission-check.md` in the resolved target space. Show any exact, overlapping, or related article comparison and obtain the user's skip-or-create-with-a-different-title decision before the create confirmation. Ensure the required `Related to:` header slug is in the final document body.
12. Apply `visual-assets.md`: confirm required screenshots, extracted frames, diagrams, captions, alt text, placeholders, and redaction status.
13. Show the proposed title, route, space, placement, duplicate-check result, related-article slug, visual asset status, and concise change summary.
14. Ask for explicit user confirmation to create or update Confluence.

Do not proceed on ambiguous approval. Draft approval is not publish approval.

## Tooling

- Use Atlassian Rovo first for Confluence write operations.
- If Rovo cannot perform the operation in the current session, stop at a final draft and explain what is missing.
- Do not delete, archive, move, restrict, or materially restructure Confluence pages through this skill.

## After Publishing

Return:

- Confluence page title.
- Documentation route.
- Space used.
- Placement used: root or parent page.
- Link to the page, if the tool provides one.
- Short summary of what was created or updated.
- Any follow-up review or ownership notes.
- Duplicate-check result and the related-article slug used.
- Visual assets included, placeholders left, or screenshots still needed.

If a temporary space override was used, state that the saved default remains unchanged.
