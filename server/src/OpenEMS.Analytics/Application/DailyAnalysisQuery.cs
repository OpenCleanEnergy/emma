using System.ComponentModel.DataAnnotations;
using OpenEMS.Analytics.Queries;
using OpenEMS.Application.Shared;

namespace OpenEMS.Analytics.Application;

public class DailyAnalysisQuery : IQuery<DailyAnalysisDto>
{
    [Range(1, int.MaxValue)]
    public required int Year { get; init; }

    [Range(1, 12)]
    public required int Month { get; init; }

    [Range(1, 31)]
    public required int Day { get; init; }
    public required TimeSpan TimeZoneOffset { get; init; }

    public class Handler(
        IAnalyticsPowerHistoryQuery powerHistoryQuery,
        IAnalyticsTotalEnergyDataQuery totalEnergyDataQuery
    ) : IQueryHandler<DailyAnalysisQuery, DailyAnalysisDto>
    {
        private readonly IAnalyticsPowerHistoryQuery _powerHistoryQuery = powerHistoryQuery;
        private readonly IAnalyticsTotalEnergyDataQuery _totalEnergyDataQuery =
            totalEnergyDataQuery;

        public async Task<DailyAnalysisDto> Handle(
            DailyAnalysisQuery request,
            CancellationToken cancellationToken
        )
        {
            var start = new DateTimeOffset(
                year: request.Year,
                month: request.Month,
                day: request.Day,
                hour: 0,
                minute: 0,
                second: 0,
                offset: request.TimeZoneOffset
            );

            var end = start.AddDays(1);

            var powerHistory = await _powerHistoryQuery.GetPowerHistory(
                start,
                end,
                TimeSpan.FromMinutes(15)
            );

            var totalEnergyData = await _totalEnergyDataQuery.QueryTotalEnergyData(start, end);

            return new DailyAnalysisDto
            {
                PowerHistory = PowerHistoryDto.From(powerHistory, request.TimeZoneOffset),
                Metrics = AnalyticsMetricsDto.From(totalEnergyData),
            };
        }
    }
}
