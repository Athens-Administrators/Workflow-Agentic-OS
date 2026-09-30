# WOS Suite 2.0 Beta Marketplace Lane

The beta lane is the Git branch `codex/wos-suite-2-beta`. Its marketplace identity is `workflow-os-suite-2-beta`, deliberately separate from the production `workflow-os` marketplace on `main`.

## What this isolates

- The beta catalog publishes only the six Suite 2 components.
- Memory Lite is `2.0.0-beta`.
- Retired Engine and DR are absent from the catalog.
- Azure Boards is excluded until separately approved.
- Production marketplace configuration and its installed plugins remain untouched.

## Sync when ready

After this branch is committed and pushed, add the beta marketplace source with its explicit branch reference, then restart Codex and install/test it in a fresh chat:

```powershell
codex plugin marketplace add https://github.com/Athens-Administrators/Workflow-Agentic-OS.git --ref codex/wos-suite-2-beta --sparse .agents/plugins
```

Do not replace or remove the existing production `workflow-os` source. The beta source is a parallel test lane. Syncing this source does not authorize a profile migration; the user’s explicit Upgrade or Install action remains the single confirmation for that migration.
