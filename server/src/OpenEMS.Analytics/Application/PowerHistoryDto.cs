using OpenEMS.Analytics.Queries;

namespace OpenEMS.Analytics.Application;

public class PowerHistoryDto
{
    public required IReadOnlyList<PowerDataPointDto> Consumers { get; init; }
    public required IReadOnlyList<PowerDataPointDto> Producers { get; init; }
    public required IReadOnlyList<PowerDataPointDto> ElectricityMetersConsume { get; init; }
    public required IReadOnlyList<PowerDataPointDto> ElectricityMetersFeedIn { get; init; }

    public static PowerHistoryDto From(PowerHistory powerHistory, TimeSpan timeZoneOffset)
    {
        var mapper = new PowerHistoryMapper(timeZoneOffset);
        return mapper.Map(powerHistory);
    }
}
