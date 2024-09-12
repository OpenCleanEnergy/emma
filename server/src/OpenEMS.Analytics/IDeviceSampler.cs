namespace OpenEMS.Analytics;

public interface IDeviceSampler
{
    Task<NumberOfSamples> TakeSample(DateTimeOffset timestamp);
}
