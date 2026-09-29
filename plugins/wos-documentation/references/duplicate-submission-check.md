# Duplicate Submission Check

Use this required preflight for every **new Confluence page create**, in every
target space. It applies to the
actual target space, including a one-request space override. It does not apply
to an update of the identified existing page.

## Goal

Prevent duplicate and near-duplicate KB submissions without silently discarding
the user's work. A matching title alone is not enough to reject a submission;
the article purpose, prerequisites, procedure, and expected outcome must be
compared.

## Check Routine

Run this after the target space, proposed title, and draft are known, and
before requesting create confirmation:

1. Search the target Confluence space with the proposed title, important title
   terms, and distinctive procedure or outcome terms. Use the Atlassian Rovo
   connector first and keep the space filter on every search.
2. Inspect the returned page titles, excerpts, and full content for candidates
   that are exact matches, materially overlapping, or plausibly related. A
   same-title page is always a candidate. Do not infer that search results from
   a different space are duplicates.
3. For each plausible candidate, compare the proposed and existing page by
   purpose/scope, audience, prerequisites or inputs, procedure, validation or
   expected result, and ownership/support path.
4. If there is no exact, overlapping, or related candidate, record that the
   target-space check found no similar article and continue with the normal
   publish preflight.

## Match Decision

When a candidate is found, show the user a concise comparison before any
create confirmation. Include the proposed title, candidate title and link,
space, why it matched, the material differences, and a clear classification:
`duplicate`, `overlapping`, or `related`.

Then ask the user to choose one of these actions:

- **Skip submission** — do not create a new page; provide the existing article
  link.
- **Create with a different title** — ask for and use the replacement title,
  then rerun the target-space check with that title before requesting create
  confirmation.

Do not publish based on an ambiguous choice. The user's choice to create is not
the Confluence write confirmation; obtain the existing explicit current-turn
create confirmation afterward.

## Required Related-Article Header Slug

Every newly created document must include a slug immediately below its H1
title, before the template's first section:

```md
> Related to: [<similar article title>](<Confluence page URL>)
```

When the duplicate check found a candidate and the user elects to create, that
candidate's canonical Confluence link is required in the slug. When no related
article was found, use this explicit no-match form instead:

```md
> Related to: No similar article identified in <SPACEKEY> at publication preflight.
```

Do not invent a link. If a candidate was found but no stable page URL is
available, resolve the page URL before creating the document. Keep the slug
when formatting the final Confluence body; do not replace it with a generic
template related-links section.

## Output Record

Before the confirmation prompt, report the target space, searches performed,
candidate links considered, classification, selected user action when a match
exists, and the exact related-article slug that will be placed in the page.
