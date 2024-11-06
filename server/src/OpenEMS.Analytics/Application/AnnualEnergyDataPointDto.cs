using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Application;

public record AnnualEnergyDataPointDto(int Month, WattHours Energy);
