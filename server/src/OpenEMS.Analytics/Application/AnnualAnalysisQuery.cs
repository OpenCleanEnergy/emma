using System.ComponentModel.DataAnnotations;
using OpenEMS.Analytics.Queries;
using OpenEMS.Application.Shared;

namespace OpenEMS.Analytics.Application;

public class AnnualAnalysisQuery : IQuery<AnnualAnalysisDto>
{
    [Range(1, int.MaxValue)]
    public required int Year { get; init; }

    public required TimeSpan TimeZoneOffset { get; init; }

    public class Handler(IAnalyticsTotalEnergyDataQuery totalEnergyDataQuery)
        : IQueryHandler<AnnualAnalysisQuery, AnnualAnalysisDto>
    {
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

            var end = start.AddYears(1);

            var totalEnergyData = await _totalEnergyDataQuery.QueryTotalEnergyData(start, end);

            return new AnnualAnalysisDto { Metrics = AnalyticsMetricsDto.From(totalEnergyData) };
        }
    }
}
