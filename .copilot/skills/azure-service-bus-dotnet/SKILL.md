---
name: azure-service-bus-dotnet
description: 'Work with Azure Service Bus in .NET workers: processors, handlers, CloudEvents, retries, dead-lettering, idempotency, and observability.'
---

# Azure Service Bus for .NET

Use this skill for Azure Service Bus listeners, publishers, message handlers, CloudEvents, retry/dead-letter behavior, and event-driven .NET services.

## Guidance

- Use `ServiceBusProcessor` and `ServiceBusSender` patterns already present in the repo.
- Flow `CancellationToken` through message handling and shutdown paths.
- Treat message handlers as idempotent; check duplicate detection, event IDs, and business keys.
- Prefer structured logging with message IDs, correlation IDs, subject/event type, and delivery count.
- Dead-letter only with actionable reason/description.
- Preserve CloudEvents and organization-specific message property conventions.
