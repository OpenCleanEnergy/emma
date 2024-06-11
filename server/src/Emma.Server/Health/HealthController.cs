using System.Reflection;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace Emma.Server.Health;

[ApiController]
[Route("[controller]")]
public class HealthController : ControllerBase
{
    private static readonly Lazy<string> _lazyVersion = new(GetVersion);
    private readonly HealthCheckService _healthCheckService;

    public HealthController(HealthCheckService healthCheckService)
    {
        _healthCheckService = healthCheckService;
    }

    [AllowAnonymous]
    [HttpGet]
    public async Task<HealthReportDto> GetHealthReport()
    {
        var version = _lazyVersion.Value;
        var report = await _healthCheckService.CheckHealthAsync();
        var dto = new HealthReportDto(version, report.Status, report.TotalDuration);
        return dto;
    }

    private static string GetVersion()
    {
        var assembly = typeof(HealthController).Assembly;
        var version = assembly
            .GetCustomAttribute<AssemblyInformationalVersionAttribute>()
            ?.InformationalVersion;
        return version ?? "0.0.0";
    }
}
