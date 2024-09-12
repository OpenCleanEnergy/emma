namespace OpenEMS.Analytics;

public interface IDeviceSampler
{
    Task TakeSample(DateTimeOffset timestamp);
}
