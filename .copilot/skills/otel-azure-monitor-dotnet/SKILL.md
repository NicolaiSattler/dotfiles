---
name: otel-azure-monitor-dotnet
description: 'Improve OpenTelemetry and Azure Monitor instrumentation in .NET services, workers, Aspire ServiceDefaults, tracing, metrics, and logging.'
---

# OpenTelemetry and Azure Monitor for .NET

Use this skill for observability changes in .NET APIs, workers, Aspire ServiceDefaults, Azure Monitor exporter, tracing, metrics, and structured logs.

## Guidance

- Prefer central instrumentation in Aspire `ServiceDefaults` when the solution uses Aspire.
- Use `ActivitySource` for custom spans in worker services and long-running jobs.
- Include useful tags: message ID, correlation ID, participant/domain identifiers when non-sensitive, operation name, and dependency name.
- Avoid high-cardinality tags and sensitive payloads in traces/logs.
- Keep health checks split between liveness and readiness.
- Ensure telemetry changes are safe for local development and production.
