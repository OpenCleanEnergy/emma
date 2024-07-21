using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace OpenEMS.Server.Health;

public record HealthReportDto(
    string Name,
    string Version,
    HealthStatus Status,
    TimeSpan TotalDuration
);
