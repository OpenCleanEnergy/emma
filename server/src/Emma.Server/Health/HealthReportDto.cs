using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace Emma.Server.Health;

public record HealthReportDto(
    string Name,
    string Version,
    HealthStatus Status,
    TimeSpan TotalDuration
);
