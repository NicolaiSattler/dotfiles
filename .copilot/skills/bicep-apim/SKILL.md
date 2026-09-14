---
name: bicep-apim
description: 'Validate and improve Azure Bicep templates, especially API Management operations, URL templates, named values, policies, and deployment what-if workflows.'
---

# Bicep and API Management

Use this skill for Azure Bicep, ARM deployment validation, API Management APIs/operations/policies, and URL template troubleshooting.

## Checklist

- Run or recommend `az bicep build` before reasoning about deployment behavior.
- Prefer `az deployment group what-if` or `az deployment sub what-if` before any real deployment.
- For APIM operations, verify `urlTemplate`, `templateParameters`, method, path segments, and policy references are consistent.
- Keep environment-specific values in parameters, named values, or Key Vault references.
- Avoid hardcoded host names, subscription IDs, tenant IDs, and credentials.
- Explain whether failures are compile-time Bicep errors, ARM validation errors, or APIM runtime behavior.
