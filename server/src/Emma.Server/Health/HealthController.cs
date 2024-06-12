using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace Emma.Server.Health;

[ApiController]
[Route("[controller]")]
public class HealthController : ControllerBase
{
    private readonly HealthCheckService _healthCheckService;

    public HealthController(HealthCheckService healthCheckService)
    {
        _healthCheckService = healthCheckService;
    }

    [AllowAnonymous]
    [HttpGet]
    public async Task<HealthReportDto> GetHealthReport()
    {
        var report = await _healthCheckService.CheckHealthAsync();
        var dto = new HealthReportDto(AppVersion.Version, report.Status, report.TotalDuration);
        return dto;
    }
}
