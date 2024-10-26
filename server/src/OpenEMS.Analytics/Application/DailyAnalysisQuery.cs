using OpenEMS.Analytics.Queries;
using OpenEMS.Application.Shared;

namespace OpenEMS.Analytics.Application;

public class DailyAnalysisQuery : IQuery<DailyAnalysisDto>
{
    public required DateOnly Day { get; init; }
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
            var start = new DateTimeOffset(request.Day, TimeOnly.MinValue, request.TimeZoneOffset);
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
                TotalEnergy = TotalEnergyDataDto.From(totalEnergyData),
            };
        }
    }
}
