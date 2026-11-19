---
name: jira-repair
description: Review past Jira tickets created by the signed-in user for themselves or others, preview errors and proposed corrections, and apply each approved repair individually. Use for missing customer request types, incorrect reporters, required intake fields, or ticket-format errors.
---

# `$jira-repair` — Review and Repair Past Tickets

Read `../../references/jira-standard.md`, `../../references/jira-tooling.md`, and `../../references/emoji-format.md` before choosing tools or proposing changes. Setup completion markers are not required.

## Find the user's tickets

Resolve the authenticated Jira account and target site. If keys were supplied, read those exact issues and verify their creator. Otherwise default to the user's ASD tickets with `project = ASD AND creator = currentUser() ORDER BY created DESC`, retrieving 25 per page. Include both self-reported and on-behalf tickets; do not filter only by reporter or assignee. State the reviewed scope and whether more pages remain, and let the user choose whether to continue scanning. Never describe a partial page as a complete historical audit.

Only repair tickets created by the authenticated user under this skill. If a supplied ticket has another creator, explain the scope and return a read-only finding. Do not guess whether an issue was created through Workflow OS; label its origin unknown unless evidence establishes it.

## Review and preview

Fetch each candidate's current reporter, work type, customer request type, required field values, description, security level, and status. Use relevant history when needed to explain conflicting values. Compare to current Jira configuration and supported edit metadata. Check:

- Whether a service-desk ticket has a valid customer request type linked to its actual work type. Use the current mapping; AI Gen Task maps to AI Generated Request and AI Gen Issue maps to AI Generated Issue when live configuration confirms it.
- Whether the reporter matches the intended customer. A missing request type does not establish an incorrect reporter. Do not overwrite an existing reporter based on creator, assignee, or a name mentioned in the description. Ask for the intended person's name, email, or both and resolve the exact Jira account when correction is needed; clarify ambiguous names with email.
- Whether required fields are missing or invalid. Ask for the intended reporter's Department Category and Urgent versus Routine Business acknowledgement where absent or uncertain. Do not invent historical answers, change valid answers to current defaults, or treat current requirements as proof the original ticket was invalid when created.
- Whether title or description cleanup is needed. Preserve factual content, links, attachments, and history; show exact text diffs using the emoji format. Existing legacy formatting alone does not justify rewriting unrelated fields during a request-type repair.

Present a read-only table: key/link, current values, evidenced problem, proposed values, missing answers or tool limitations. Include tickets needing no changes as a count. Distinguish confirmed errors from questions requiring user input; never diagnose portal access or email delivery solely from reporter/request-type values.

## Approve and repair one ticket at a time

Ask which candidate the user wants to repair first. Once required answers are available, re-read that ticket and show its exact before/after fields and any text diff. Explain that changing reporter or request type can affect customer access and notifications. Obtain explicit current-turn approval for this exact ticket and payload; selecting a candidate or approving the scan is not write approval. If live state differs from the preview, refresh it and obtain approval again.

Use a supported edit operation only after approval. Verify the tool's actual reporter and request-type field contracts; do not guess a payload or create a replacement issue. If the required edit is unavailable, return the precise manual correction and stop that repair. Read back changed fields, report matches/mismatches, and provide the issue link. Check portal visibility and notification delivery separately before claiming success for those outcomes. On an ambiguous write result, read state before retrying; do not duplicate the mutation.

Continue only with separate approval for each next ticket. No bulk writes, deletes, archives, automatic comments, workflow transitions, security changes, or automatic reopening of closed tickets. Closed tickets may be reviewed, but if their repair requires reopening, leave that action to a separate explicitly requested workflow. Preserve status, assignee, resolution, security, and unrelated content. Do not claim that a repair resends the original creation notification.
