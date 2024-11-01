using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Queries;

public record EnergyDataPoint<TKey>(TKey Key, WattHours Energy);
