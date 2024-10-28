namespace OpenEMS.Analytics.Application;

public class DailyAnalysisDto
{
    public required DateOnly Day { get; init; }
    public required PowerHistoryDto PowerHistory { get; init; }
    public required TotalEnergyDataDto TotalEnergy { get; init; }
}
