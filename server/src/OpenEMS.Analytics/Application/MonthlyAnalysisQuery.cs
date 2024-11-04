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

    public class Handler(
        IAnalyticsEnergyHistoryQuery energyHistoryQuery,
        IAnalyticsTotalEnergyDataQuery totalEnergyDataQuery
    ) : IQueryHandler<MonthlyAnalysisQuery, MonthlyAnalysisDto>
    {
        private readonly IAnalyticsEnergyHistoryQuery _energyHistoryQuery = energyHistoryQuery;
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

            var intervals = Enumerable
                .Range(start: 1, count: DateTime.DaysInMonth(request.Year, request.Month))
                .Select(day => new EnergyHistoryQueryInterval<int>
                {
                    Key = day,
                    Start = start.AddDays(day - 1),
                    End = start.AddDays(day),
                })
                .ToArray();

            var energyHistory = await _energyHistoryQuery.GetEnergyHistory(intervals);
            var totalEnergyData = await _totalEnergyDataQuery.QueryTotalEnergyData(
                start,
                start.AddMonths(1)
            );

            return new MonthlyAnalysisDto
            {
                EnergyHistory = MonthlyEnergyHistoryDto.From(energyHistory),
                Metrics = AnalyticsMetricsDto.From(totalEnergyData),
            };
        }
    }
}
