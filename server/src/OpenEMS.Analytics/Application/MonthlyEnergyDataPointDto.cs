using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Application;

public record MonthlyEnergyDataPointDto(int DayOfMonth, WattHours Energy);
