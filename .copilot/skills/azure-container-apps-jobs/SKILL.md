---
name: azure-container-apps-jobs
description: 'Troubleshoot Azure Container Apps and Container Apps Jobs for .NET workers, images, revisions, cancellation, managed identity, and startup failures.'
---

# Azure Container Apps Jobs for .NET

Use this skill for Azure Container Apps, Container Apps Jobs, .NET worker services, revision startup failures, cancellation handling, and container image/runtime issues.

## Checklist

- Verify the target framework, runtime image, SDK image, RID, and published output match.
- For jobs, ensure `BackgroundService` and console app shutdown behavior respects `CancellationToken`.
- Use managed identity and Azure SDK defaults unless the repo explicitly uses a different auth model.
- Prefer read-only diagnostics first: revision list, app/job show, logs, environment variables shape, and container exit code.
- Check `AZURE_TOKEN_CREDENTIALS`, DefaultAzureCredential behavior, VPN/private endpoint dependencies, and SQL authentication mode.
- Do not deploy, restart, or mutate ACA resources without explicit approval.
