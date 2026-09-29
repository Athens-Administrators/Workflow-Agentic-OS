---
name: project-import
description: Link one existing workspace to Workflow OS with an optional WOS.md locator and active-project pointer. Uses native Codex memory and Jira; it does not import or create a separate memory history.
---

# `$project-import` — Import One Existing Workspace

Import exactly one user-named workspace. Never scan or bulk-import a parent folder, children, or siblings.

1. Confirm the absolute workspace path exists and is a directory.
2. If `WOS.md` already exists, read it and ask whether to reuse its slug; never overwrite it without confirmation.
3. Gather a short project name, description, and confirmed permanent slug.
4. Optionally link an existing Jira epic/ticket. Verify it read-only with Rovo first and `acli` as fallback. Do not create Jira issues from this skill.
5. With confirmation, write a compact `WOS.md` in that workspace only:

```markdown
---
project_slug: <slug>
jira_key: <key-or-null>
workspace_path: <absolute path>
imported: true
created: <ISO timestamp>
---

# <Project name>

<Short description>
```

6. Ask whether to set it active. If approved, call `${plugin_root}/scripts/active-project.ps1 -Set <slug>`.
7. Summarize the workspace, Jira key, marker path, and pointer result.

`WOS.md` is a locator, not a memory log. Do not create a database record, use an MCP memory tool, or rely on a SessionStart hook.
