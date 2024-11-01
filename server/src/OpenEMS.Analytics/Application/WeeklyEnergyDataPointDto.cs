using OpenEMS.Domain.Units;

namespace OpenEMS.Analytics.Application;

public record WeeklyEnergyDataPointDto(DayOfWeek DayOfWeek, WattHours Energy);
