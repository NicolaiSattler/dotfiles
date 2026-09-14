---
name: azure-devops-pipelines
description: 'Review, troubleshoot, and improve Azure DevOps YAML pipelines for .NET, NuGet packaging, Bicep, Playwright, and deployment workflows.'
---

# Azure DevOps Pipelines for .NET/Azure

Use this skill for Azure DevOps YAML pipeline analysis, failed job investigation, NuGet publishing, Bicep validation, deployment stages, and test orchestration.

## Guidance

- Preserve existing stage/job/template structure unless a structural change is explicitly needed.
- Prefer deterministic validation commands: `dotnet restore`, `dotnet build --no-restore`, `dotnet test --no-build`, `az bicep build`, and deployment `what-if`.
- Treat publishing, deploying, deleting, purging, and version overwrites as high-risk actions requiring explicit user approval.
- For NuGet packages, respect Central Package Management and do not put package versions in individual `.csproj` files when the repo uses `Directory.Packages.props`.
- For Azure Artifacts, remember that unlisting a package version does not allow republishing the same immutable version.
- Keep secrets in variable groups, Key Vault references, service connections, or managed identity; never inline credentials.
- When explaining pipelines, redact organization-specific domains and sensitive identifiers unless the user explicitly asks otherwise.
