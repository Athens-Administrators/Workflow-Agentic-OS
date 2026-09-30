# WOS Suite 2.0 Beta — First-Time Install

Use this only when the machine has no usable Workflow OS profile. Existing users must use the [Suite 2 migration guide](workflow-os-update-existing-install-instructions.md), not `$welcome` again.

## Suite 2 baseline

- Required: `wos-jira`, `wos-documentation`
- Recommended context companion: `wos-memory-lite`
- Optional: `wos-project`, `wos-task`
- Retired: `wos-memory-engine`, `wos-dr`
- Not included in this beta: `wos-azure-boards`

## First-time flow

1. Confirm access to `https://github.com/Athens-Administrators/Workflow-Agentic-OS.git`.
2. Run `pwsh -NoProfile -File .\scripts\install\preflight.ps1` from the approved checkout.
3. If preflight is ready, run `pwsh -NoProfile -File .\scripts\install\setup-codex.ps1`, confirm its prompt, then restart Codex.
4. In `/plugins`, install `wos-onboarding` from `workflow-os`.
5. In a fresh chat, run `$welcome`.
6. Complete `$jira-setup` and `$documentation-setup` only. Choose Memory Lite, Project, and Task only if wanted.

Do not install retired Engine/DR plugins, create DR schedules, or create a second local memory store. WOS Memory Lite is read-only orientation and explicit handoff guidance; native Codex memory remains primary.

The component versions for release are governed by [wos-suite-2-beta.json](../release/wos-suite-2-beta.json). Memory Lite is approved as `2.0.0-beta`; sync the beta lane for testing before publishing to the production marketplace.
