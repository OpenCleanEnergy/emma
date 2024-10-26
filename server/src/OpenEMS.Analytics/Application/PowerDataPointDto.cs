using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Application;

public record PowerDataPointDto(DateTimeOffset Timestamp, Watt Power);
