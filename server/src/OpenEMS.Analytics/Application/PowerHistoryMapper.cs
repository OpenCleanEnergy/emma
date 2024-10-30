using OpenEMS.Analytics.Queries;
using Riok.Mapperly.Abstractions;

namespace OpenEMS.Analytics.Application;

[Mapper]
internal sealed partial class PowerHistoryMapper(TimeSpan timeZoneOffset)
{
    private readonly TimeSpan _timeZoneOffset = timeZoneOffset;

    public partial PowerHistoryDto Map(PowerHistory powerHistory);

    private PowerDataPointDto MapToPowerDataPointDto(PowerDataPoint powerDataPoint) =>
        new(powerDataPoint.Timestamp.ToOffset(_timeZoneOffset), powerDataPoint.Power);
}
