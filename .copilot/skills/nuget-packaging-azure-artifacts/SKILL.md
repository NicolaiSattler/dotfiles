---
name: nuget-packaging-azure-artifacts
description: 'Handle .NET NuGet package versioning, packing, publishing, Azure Artifacts feeds, immutable versions, and Central Package Management.'
---

# NuGet Packaging and Azure Artifacts

Use this skill for NuGet package creation, publishing, Azure Artifacts feeds, version conflicts, unlisting, and dependency version changes.

## Guidance

- NuGet package versions are immutable in Azure Artifacts; unlisting does not permit republishing the same version.
- Prefer a new SemVer version or CI metadata strategy instead of trying to overwrite an existing package.
- Respect Central Package Management: update `Directory.Packages.props`, not individual `.csproj` versions.
- Use `dotnet pack --no-build` after a validated build when possible.
- Keep feed credentials in NuGet config, credential provider, service connection, or pipeline auth task; never inline tokens.
- Check package ID, version, source, API key/auth mode, and push target before publishing.
