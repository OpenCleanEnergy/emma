namespace OpenEMS.Analytics.Samples;

public interface IDeviceSampler
{
    Task<NumberOfSamples> TakeSamples(DateTimeOffset timestamp);
}
