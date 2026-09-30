# WOS Suite 2.0 Beta Pilot

Use this supervised pilot with a participant who has explicitly approved the migration. The first participant is the user’s manager once that permission is recorded.

## Existing-profile pilot

1. Before changing anything, capture the `$suite-2-migration` inventory.
2. Confirm it finds a usable profile and that Jira and Documentation are complete. If either is incomplete, prompt only for its corresponding setup flow.
3. Give one concise confirmation naming any installed `wos-memory-engine`, `wos-dr`, Engine runtime/hook entries, and the exact WOS DR scheduled task.
4. After confirmation, run the assistant’s apply action and uninstall only the two retired plugins in `/plugins`.
5. Refresh the marketplace and update only already-installed Suite 2 components.
6. Restart Codex. In a fresh chat, check the outcomes below.

## Exit criteria

- No 45–50 minute repeat onboarding.
- Existing onboarding profile, Jira setup, and Documentation setup are intact.
- WOS Memory Engine startup does not run.
- The `Workflow OS DR Snapshot` scheduled task is absent and no OneDrive loop resumes.
- Jira, Documentation, Memory Lite, Project, and Task show their approved beta versions when installed.
- WOS.md markers, active pointers, legacy SQLite data, user preferences, and OneDrive snapshots are unchanged.

The participant must not have caches, data, backups, or unrelated settings deleted. Memory Lite is approved as `2.0.0-beta`; use [wos-suite-2-beta.json](../release/wos-suite-2-beta.json) for the full beta compatibility matrix before publishing.
