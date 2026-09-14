---
name: dotnet-testing-stack
description: 'Write and update tests in .NET repositories that use MSTest, Shouldly, NSubstitute, AutoFixture, Reqnroll, and WebApplicationFactory.'
---

# .NET Testing Stack

Use this skill for test updates in .NET solutions using MSTest, Shouldly, NSubstitute, AutoFixture, Reqnroll, and ASP.NET Core integration testing.

## Defaults

- Use MSTest attributes: `[TestClass]`, `[TestMethod]`, `[DataRow]`, and `[DynamicData]`.
- Prefer Shouldly assertions when already present.
- Prefer NSubstitute for mocks when already present.
- Prefer AutoFixture for complex test data when the target project already uses it.
- Structure new unit tests with clear Arrange/Act/Assert sections when the repo follows that style.
- Use Reqnroll only in specification test projects with `.feature` files.
- Flow `CancellationToken` through async calls and avoid `.Result`/`.Wait()`.
- Preserve Dutch domain naming in test data and method names where relevant.
