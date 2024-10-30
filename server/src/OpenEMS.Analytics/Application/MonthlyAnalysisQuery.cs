using System.ComponentModel.DataAnnotations;
using OpenEMS.Analytics.Queries;
using OpenEMS.Application.Shared;

namespace OpenEMS.Analytics.Application;

public class MonthlyAnalysisQuery : IQuery<MonthlyAnalysisDto>
{
    [Range(1, int.MaxValue)]
    public required int Year { get; init; }

    [Range(1, 12)]
    public required int Month { get; init; }
    public required TimeSpan TimeZoneOffset { get; init; }

    public class Handler(IAnalyticsTotalEnergyDataQuery totalEnergyDataQuery)
        : IQueryHandler<MonthlyAnalysisQuery, MonthlyAnalysisDto>
    {
        private readonly IAnalyticsTotalEnergyDataQuery _totalEnergyDataQuery =
            totalEnergyDataQuery;

        public async Task<MonthlyAnalysisDto> Handle(
            MonthlyAnalysisQuery request,
            CancellationToken cancellationToken
        )
        {
            var start = new DateTimeOffset(
                year: request.Year,
                month: request.Month,
                day: 1,
                hour: 0,
                minute: 0,
                second: 0,
                offset: request.TimeZoneOffset
            );

            var end = start.AddMonths(1);

            var totalEnergyData = await _totalEnergyDataQuery.QueryTotalEnergyData(start, end);

            return new MonthlyAnalysisDto { Metrics = AnalyticsMetricsDto.From(totalEnergyData) };
        }
    }
}
