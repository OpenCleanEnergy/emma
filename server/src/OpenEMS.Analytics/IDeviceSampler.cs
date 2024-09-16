namespace OpenEMS.Analytics;

public interface IDeviceSampler
{
    Task<NumberOfSamples> TakeSamples(DateTimeOffset timestamp);
}
