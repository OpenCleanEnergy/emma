using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace OpenEMS.Server.Health;

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
        var dto = new HealthReportDto(
            ServiceInfo.Name,
            ServiceInfo.Version,
            report.Status,
            report.TotalDuration
        );

        return dto;
    }
}
