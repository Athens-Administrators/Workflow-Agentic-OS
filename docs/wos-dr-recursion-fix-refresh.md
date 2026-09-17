# WOS DR OneDrive Path Fix Refresh

Use this after Workflow OS setup is fully done on a colleague's Codex.

Paste this into a fresh Codex chat:

```text
Please refresh Workflow OS from GitHub and make sure the WOS DR recursion fix is installed.

Goal:
- Pull the latest Workflow OS marketplace from GitHub.
- Make sure wos-dr is updated to v0.1.2 or newer.
- Confirm DR is not scanning its own backup folder.

Safety:
- Do not delete, move, or rename folders.
- Do not overwrite local work.
- Do not commit or push anything.
- Do not run a restore.
- Ask before creating a new snapshot.

Steps:
1. Run:
   codex plugin marketplace upgrade workflow-os
2. If the marketplace is missing, run:
   codex plugin marketplace add https://github.com/acasasAA/Workflow-Agentic-OS.git --ref main
3. Fully close and reopen Codex.
4. Open /plugins.
5. Update or reinstall only:
   wos-dr
6. Start a fresh Codex chat and run:
   $dr-status
7. Confirm the installed wos-dr version is v0.1.2 or newer.
8. Confirm the DR backup root is not also being scanned as a project root.
9. Set the backup root to a short OneDrive path, for example `C:\Users\<user>\OneDrive - Athens\WOS`, instead of nesting it under `Documents\Codex Projects`.
10. If the backup root is inside a project root, use a narrower project root such as a Codex projects folder, or exclude project-root inventory for now.
11. Ask me before running:
    $dr-snapshot

Final answer:
- Tell me the installed wos-dr version.
- Tell me the backup root.
- Tell me whether any project root overlaps the backup root.
- Tell me whether a snapshot was created.
```
