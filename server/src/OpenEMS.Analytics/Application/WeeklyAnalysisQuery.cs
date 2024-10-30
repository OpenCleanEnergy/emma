using System.ComponentModel.DataAnnotations;
using OpenEMS.Analytics.Queries;
using OpenEMS.Application.Shared;

namespace OpenEMS.Analytics.Application;

public class WeeklyAnalysisQuery : IQuery<WeeklyAnalysisDto>
{
    [Range(1, int.MaxValue)]
    public required int Year { get; init; }

    [Range(1, 12)]
    public required int Month { get; init; }

    [Range(1, 31)]
    public required int FirstDayOfWeek { get; init; }
    public required TimeSpan TimeZoneOffset { get; init; }

    public class Handler(IAnalyticsTotalEnergyDataQuery totalEnergyDataQuery)
        : IQueryHandler<WeeklyAnalysisQuery, WeeklyAnalysisDto>
    {
        private readonly IAnalyticsTotalEnergyDataQuery _totalEnergyDataQuery =
            totalEnergyDataQuery;

        public async Task<WeeklyAnalysisDto> Handle(
            WeeklyAnalysisQuery request,
            CancellationToken cancellationToken
        )
        {
            var start = new DateTimeOffset(
                year: request.Year,
                month: request.Month,
                day: request.FirstDayOfWeek,
                hour: 0,
                minute: 0,
                second: 0,
                offset: request.TimeZoneOffset
            );

            var end = start.AddDays(7);

            var totalEnergyData = await _totalEnergyDataQuery.QueryTotalEnergyData(start, end);

            return new WeeklyAnalysisDto { Metrics = AnalyticsMetricsDto.From(totalEnergyData) };
        }
    }
}
