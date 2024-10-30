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

    [HttpGet("weekly", Name = nameof(WeeklyAnalysisQuery))]
    public async Task<WeeklyAnalysisDto> GetWeeklyAnalysis([FromQuery] WeeklyAnalysisQuery query) =>
        await _sender.Send(query);

    [HttpGet("monthly", Name = nameof(MonthlyAnalysisQuery))]
    public async Task<MonthlyAnalysisDto> GetMonthlyAnalysis(
        [FromQuery] MonthlyAnalysisQuery query
    ) => await _sender.Send(query);

    [HttpGet("annual", Name = nameof(AnnualAnalysisQuery))]
    public async Task<AnnualAnalysisDto> GetAnnualAnalysis([FromQuery] AnnualAnalysisQuery query) =>
        await _sender.Send(query);
}
