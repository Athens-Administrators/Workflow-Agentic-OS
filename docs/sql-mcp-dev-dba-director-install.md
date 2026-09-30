# SQL MCP Install for a Dev/DBA Director

> **Archived prerequisite note.** Its former DR baseline is retired. Establish the Suite 2 Beta baseline with the current first-time or existing-install guide before using any SQL MCP instructions below.

Use this after the Dev/DBA Director's WOS baseline setup is complete.

Source pattern: this is the Dev/DBA Director-ready copy of the earlier colleague setup file at `C:\Users\acasas\Documents\Codex\2026-09-01\https-github-com-bilims-mcp-sqlserver\outputs\sql-mcp-colleague-codex-setup.md`.

Last reviewed from source: 2026-09-01.

Recommended baseline before this guide:

1. Codex is installed and signed in.
2. WOS baseline is complete: `wos-jira`, `wos-documentation`, and `wos-dr`.
3. `wos-dr` is `v0.1.2` or newer.
4. `$dr-status` confirms DR is not scanning its own backup folder.
5. The teammate has a least-privilege SQL identity ready.

## Recommendation

Use Microsoft SQL MCP through Microsoft Data API Builder.

Reason: Data API Builder lets the team expose only approved tables, views, and safe tools. The default should be read-only.

Do not start with a generic raw SQL MCP server for this guide.

## Safety Rules

1. Use a least-privilege SQL identity.
2. Do not use `sa`, `db_owner`, `db_datawriter`, or broad admin credentials.
3. Do not store database passwords or connection strings directly in Codex `config.toml`.
4. Store connection details in a user environment variable or approved secret manager.
5. Expose only the tables, views, and procedures the teammate actually needs.
6. Start read-only.
7. Keep write tools disabled unless there is a documented business need.
8. Keep Codex tool approval set to `prompt`.
9. Do not run live database queries until the teammate approves the target database, purpose, and scope.
10. Treat finance, HR, student, legal, security, personnel, and confidential business data as sensitive.

## Human Prep

Ask these questions before installing. Use numbered choices.

SQL MCP install choice:

1. Install read-only SQL MCP now.
2. Prepare the config folder only, but do not connect yet.
3. Skip SQL MCP for now.
4. Other / In Addition - I need a different SQL setup.

Database target:

1. Azure SQL Database.
2. On-premises SQL Server.
3. Local SQL Server or SQL Server Express.
4. I am not sure yet.
5. Other / In Addition - the target is different.

Credential style:

1. Entra / Active Directory authentication.
2. SQL username and password for a read-only user.
3. Existing approved service identity.
4. I am not sure yet.
5. Other / In Addition - another credential method is required.

Access scope:

1. One approved database and a few approved views.
2. One approved database and a few approved tables.
3. Multiple databases, read-only.
4. Discovery only for now.
5. Other / In Addition - I need a different access scope.

## Prerequisites

Run these checks in PowerShell:

```powershell
codex --version
git --version
node --version
pwsh --version
dotnet --version
```

If `.NET` is missing, install `.NET 8` or later before continuing.

## Install or Update Data API Builder

Install:

```powershell
dotnet tool install --global Microsoft.DataApiBuilder
```

If already installed, update:

```powershell
dotnet tool update --global Microsoft.DataApiBuilder
```

Verify:

```powershell
dab --version
```

## Create a Local SQL MCP Config Folder

Use a local folder that does not contain repo code or private exports.

```powershell
New-Item -ItemType Directory -Force -Path C:\CodexMCP\sql-mcp | Out-Null
Set-Location C:\CodexMCP\sql-mcp
```

## Store the Connection String Outside Codex

Preferred Azure SQL / Entra example:

```powershell
[Environment]::SetEnvironmentVariable(
  "MSSQL_CONNECTION_STRING",
  "Server=tcp:YOURSERVER.database.windows.net,1433;Initial Catalog=YOURDB;Authentication=Active Directory Default;Encrypt=True;TrustServerCertificate=False;",
  "User"
)
```

SQL username/password example, only if required:

```powershell
[Environment]::SetEnvironmentVariable(
  "MSSQL_CONNECTION_STRING",
  "Server=tcp:YOURSERVER.database.windows.net,1433;Initial Catalog=YOURDB;User ID=READONLY_USER;Password=YOUR_PASSWORD;Encrypt=True;TrustServerCertificate=False;",
  "User"
)
```

After setting the environment variable, fully close and reopen Codex and any terminal windows.

Do not paste real passwords, tokens, or connection strings into chat.

## Initialize Data API Builder

```powershell
dab init --database-type mssql --connection-string "@env('MSSQL_CONNECTION_STRING')" --host-mode Development --config dab-config.json
```

## Add Approved Read-Only Entities

Add only approved tables or views.

Example:

```powershell
dab add Products --source dbo.Products --permissions "codex_reader:read" --config dab-config.json
```

Repeat only for approved entities:

```powershell
dab add Customers --source dbo.Customers --permissions "codex_reader:read" --config dab-config.json
dab add Orders --source dbo.Orders --permissions "codex_reader:read" --config dab-config.json
```

Do not use broad permissions such as:

```text
anonymous:*
```

## Configure Read-Only MCP Tools

Open `C:\CodexMCP\sql-mcp\dab-config.json`.

Make sure the MCP runtime section keeps write tools disabled:

```json
{
  "runtime": {
    "mcp": {
      "enabled": true,
      "path": "/mcp",
      "dml-tools": {
        "describe-entities": true,
        "create-record": false,
        "read-records": true,
        "update-record": false,
        "delete-record": false,
        "execute-entity": false,
        "aggregate-records": {
          "enabled": true,
          "query-timeout": 30
        }
      }
    }
  }
}
```

Validate:

```powershell
dab validate --config C:\CodexMCP\sql-mcp\dab-config.json
```

## Add SQL MCP to Codex

Open the user's Codex config:

```powershell
notepad $env:USERPROFILE\.codex\config.toml
```

Add this server entry:

```toml
[mcp_servers.sql_mcp]
command = "dab"
args = [
  "start",
  "--mcp-stdio",
  "role:codex_reader",
  "--config",
  "C:\\CodexMCP\\sql-mcp\\dab-config.json",
  "--LogLevel",
  "Error"
]
env_vars = ["MSSQL_CONNECTION_STRING"]
enabled_tools = [
  "describe_entities",
  "read_records",
  "aggregate_records"
]
disabled_tools = [
  "create_record",
  "update_record",
  "delete_record",
  "execute_entity"
]
default_tools_approval_mode = "prompt"
```

Fully close and reopen Codex after saving.

## Test the Read-Only Setup

In a fresh Codex chat, ask:

```text
Use the SQL MCP server to describe the available entities. Do not run data queries yet.
```

Then, only after the teammate approves a small read:

```text
Use the SQL MCP server to read 5 records from <approved entity>. Keep it read-only.
```

Confirm that write tools are not visible or callable.

## Optional Write-Capable Setup

Do not enable this during first install unless there is a clear business need.

Rules for any write-capable setup:

1. Use a separate SQL identity from the read-only setup.
2. Grant write permission only on specific approved tables or views.
3. Avoid delete permissions.
4. Avoid stored procedure execution unless each procedure is reviewed for side effects.
5. Use a separate MCP server entry, such as `sql_mcp_write`.
6. Keep `default_tools_approval_mode = "prompt"`.
7. Require explicit approval before every database write.

Example create/update-only DAB permission:

```powershell
dab update Products --permissions "codex_writer:create,read,update" --config dab-config.json
```

Keep delete disabled unless the data owner explicitly approves it and there is a documented operational need.

## Final Verification

Confirm:

1. `dab --version` works.
2. `dab validate --config C:\CodexMCP\sql-mcp\dab-config.json` succeeds.
3. Codex lists the SQL MCP server.
4. The SQL MCP server exposes only read-oriented tools by default.
5. Write tools are disabled.
6. The SQL identity has only the needed permissions.
7. No database passwords or connection strings are stored in Codex `config.toml`.
8. The teammate understands that live queries require approval and a clear purpose.

## Good First Prompt

Use this after restarting Codex:

```text
Check the SQL MCP setup in read-only mode.

Do not run data queries yet.
Do not change any database objects or records.
First, list the available SQL MCP tools and describe which ones are read-only.
Then ask me which approved entity to inspect.
```
