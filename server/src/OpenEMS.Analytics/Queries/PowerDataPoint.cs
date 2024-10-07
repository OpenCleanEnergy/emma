using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Queries;

public record PowerDataPoint(DateTimeOffset Timestamp, Watt Power);
