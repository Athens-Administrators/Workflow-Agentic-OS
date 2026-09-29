---
name: jira-update
description: Append a comment to a Jira work item using the Workflow OS emoji-formatted comment structure. Use when the user wants to log progress, surface a blocker, or note completion on a specific Jira key outside of a project flow. Requires explicit confirmation before posting.
---

# `$jira-update` — Manual Jira Comment

You are posting a comment to a Jira work item on the user's explicit request.

## Required reference

Load `${plugin_root}/../references/setup-gate.md` first. If Jira setup is not complete, stop and send the user to `$jira-setup` before doing anything else.
Load `${plugin_root}/../references/jira-standard.md` before drafting. Use it to choose the right update type and avoid vague comments.
Load `${plugin_root}/../references/emoji-format.md` before drafting. The comment **must** follow §1 (Comment structure) including the status marker.
Load `${plugin_root}/../references/jira-tooling.md` before choosing Jira tooling.

## Steps

1. **Choose the comment depth before drafting:**
   - Use the **concise** format when the user's input contains one self-contained factual update and has no material blocker, decision request, next action, transition, or closure.
   - Use the **structured** format when a teammate needs a fuller handoff, the user requests detail, or the update contains more than one independent fact.
   - Make this decision yourself; do not ask the user to select a format before you preview it.

2. **Ask the user for:**
   - **Jira key** (e.g. `ASD-42`). Verify exact keys using the Jira tooling order from `jira-tooling.md`; prefer Rovo `getJiraIssue`, then `searchJiraIssuesUsingJql` with `key = <KEY>` when a query is needed, then `acli` fallback if needed.
   - **Status marker**: 🟢 / 🟡 / 🔴 / 🔵 / ✅ / 🛠️ (per §1 table).
   - **For concise comments:** one complete, factual sentence.
   - **For structured comments:** a summary that retains the user's original intent or original comment, refined only where needed for clarity; then **What's done**, **In progress**, **Blockers**, and **Next** — only the sections that have content.

3. **Check usefulness** against `jira-standard.md`. Do not use concise format for a bare acknowledgement or when material context is missing; ask for the details needed for the appropriate format.

4. **Preview the selected comment** using the applicable §1 format. State whether it is concise or structured and why. Then ask: `Is this good, or would you like it simpler?` Do not treat approval of this preview as approval to post.

5. **After the preview is settled, confirm before posting:**
   ```
   Posting to <key>:
   ──────────────────
   <full comment>
   ──────────────────
   Post? (yes/no)
   ```

6. **On yes**: use the current Rovo `addOrEditJiraIssueComment` operation (discover it and invoke with `executeWrite` if deferred). If no comment operation is available, use the `acli` fallback from `${plugin_root}/../references/jira-tooling.md`: write the approved comment to a temp file, run `acli jira workitem comment create --key "<key>" --body-file "<tempfile>"`, then remove the temp file.

7. **On success**, tell the user the comment ID or success result returned. If Workflow OS memory-engine is available and the user indicates time spent, optionally write a `worklog` memory note; if memory is unavailable, do not fail the Jira workflow.

8. **On no**, ask what to change. If the user wants it simpler, revise the preview and return to step 4.

## Hard rules

- **One status marker per comment.** Pick the most accurate one.
- **No edits to other people's comments** — `$jira-update` only adds new ones. To edit our own latest, use `$jira-mod`.
- **No secrets.**
- **Per-action confirmation** — don't reuse authorization across keys.
- **Standalone behavior**: this skill must work with only `wos-jira` installed. Do not require memory-engine, project, or task plugins.
