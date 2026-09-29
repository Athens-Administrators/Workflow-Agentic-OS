# Workflow OS Azure Boards Tooling Policy

Workflow OS can use the Azure Boards connector, Azure DevOps CLI, browser inspection, and Azure DevOps REST APIs for Azure Boards work.

## Tool Order

1. Use the Azure Boards Codex connector first when it exposes the needed operation. Current verified connector operations include account/profile and organization discovery.
2. Use Azure DevOps CLI (`az devops`, `az boards`) only when it is separately authenticated for the Azure DevOps organization.
3. Use the authenticated browser session for read-only inspection when connector and CLI reads are not sufficient.
4. Use Azure DevOps REST / Work Item Tracking APIs last, only when connector and CLI cannot express the needed operation cleanly.
5. Use `$azure-boards-intake` when direct inspection is blocked but the user can provide screenshots, copied fields, or small card summaries.

## Verified Connector Context

The connector has been verified for:

- Identity: `Admin Anthony Casas <Admin-Acasas@athensinsurancesvc1.onmicrosoft.com>`
- Organization: `AthensTest`
- Organization URI: `https://vssps.dev.azure.com:443/AthensTest/`

## CLI Commands

Check Azure CLI account:

```powershell
az account show --query "{user:user.name, tenantId:tenantId, subscription:name}" -o json
```

Set default organization:

```powershell
az devops configure --defaults organization=https://dev.azure.com/AthensTest
```

List projects:

```powershell
az devops project list --organization https://dev.azure.com/AthensTest -o table
```

Create a work item in `Sandbox` only after explicit confirmation:

```powershell
az boards work-item create --org https://dev.azure.com/AthensTest --project Sandbox --type "<type>" --title "<title>" --description "<description>"
```

Add a discussion update in `Sandbox` only after explicit confirmation:

```powershell
az boards work-item update --org https://dev.azure.com/AthensTest --id "<id>" --discussion "<comment>"
```

## Hard Boundaries

- Do not write to `ClaimImport` through connector, CLI, browser, REST, or any future tool path.
- Do not use Azure DevOps CLI if `az devops` reports it is not logged in.
- Do not pass secrets through command arguments.
- Prefer temp files for long approved text when a CLI supports file input; remove temp files afterward.
- Do not delete or destroy work items.
