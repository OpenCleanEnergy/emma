using System.ComponentModel.DataAnnotations;
using OpenEMS.Analytics.Queries;
using OpenEMS.Application.Shared;

namespace OpenEMS.Analytics.Application;

public class AnnualAnalysisQuery : IQuery<AnnualAnalysisDto>
{
    [Range(1, int.MaxValue)]
    public required int Year { get; init; }

    public required TimeSpan TimeZoneOffset { get; init; }

    public class Handler(
        IAnalyticsEnergyHistoryQuery energyHistoryQuery,
        IAnalyticsTotalEnergyDataQuery totalEnergyDataQuery
    ) : IQueryHandler<AnnualAnalysisQuery, AnnualAnalysisDto>
    {
        private readonly IAnalyticsEnergyHistoryQuery _energyHistoryQuery = energyHistoryQuery;
        private readonly IAnalyticsTotalEnergyDataQuery _totalEnergyDataQuery =
            totalEnergyDataQuery;

        public async Task<AnnualAnalysisDto> Handle(
            AnnualAnalysisQuery request,
            CancellationToken cancellationToken
        )
        {
            var start = new DateTimeOffset(
                year: request.Year,
                month: 1,
                day: 1,
                hour: 0,
                minute: 0,
                second: 0,
                offset: request.TimeZoneOffset
            );

            var intervals = Enumerable
                .Range(start: 1, count: 12)
                .Select(month => new EnergyHistoryQueryInterval<int>
                {
                    Key = month,
                    Start = start.AddMonths(month - 1),
                    End = start.AddMonths(month),
                })
                .ToArray();

            var energyHistory = await _energyHistoryQuery.GetEnergyHistory(intervals);

            var totalEnergyData = await _totalEnergyDataQuery.QueryTotalEnergyData(
                start,
                start.AddYears(1)
            );

            return new AnnualAnalysisDto
            {
                EnergyHistory = AnnualEnergyHistoryDto.From(energyHistory),
                Metrics = AnalyticsMetricsDto.From(totalEnergyData),
            };
        }
    }
}
