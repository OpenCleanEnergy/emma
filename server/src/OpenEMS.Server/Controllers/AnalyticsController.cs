using MediatR;
using Microsoft.AspNetCore.Mvc;
using OpenEMS.Analytics.Application;

namespace OpenEMS.Server.Controllers;

[ApiController]
[Route("v1/[controller]")]
public class AnalyticsController(ISender sender) : ControllerBase
{
    private readonly ISender _sender = sender;

    [HttpGet("daily", Name = nameof(DailyAnalysisQuery))]
    public async Task<DailyAnalysisDto> GetDailyAnalysis([FromQuery] DailyAnalysisQuery query) =>
        await _sender.Send(query);
}
