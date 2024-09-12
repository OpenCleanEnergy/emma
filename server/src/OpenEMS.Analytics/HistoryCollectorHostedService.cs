using Microsoft.Extensions.Hosting;

namespace OpenEMS.Analytics;

public sealed class HistoryCollectorHostedService(
    HistoryCollectorConfiguration configuration,
    IEnumerable<IDeviceSampler> deviceSamplers,
    TimeProvider timeProvider
) : IHostedService, IDisposable
{
    private readonly HistoryCollectorConfiguration _configuration = configuration;
    private readonly CancellationTokenSource _cts = new();
    private readonly IEnumerable<IDeviceSampler> _deviceSamplers = deviceSamplers;
    private readonly TimeProvider _timeProvider = timeProvider;
    private ITimer? _timer;

    public Task StartAsync(CancellationToken cancellationToken)
    {
        _timer = _timeProvider.CreateTimer(
            TimerCallback,
            null,
            _configuration.SamplingInterval,
            _configuration.SamplingInterval
        );

        return Task.CompletedTask;
    }

    public async Task StopAsync(CancellationToken cancellationToken)
    {
        await _cts.CancelAsync();
    }

    public void Dispose()
    {
        _cts.Dispose();
        _timer?.Dispose();
    }

    private void TimerCallback(object? state)
    {
        _ = state;

        var timestamp = _timeProvider.GetUtcNow();
        foreach (var deviceSampler in _deviceSamplers)
        {
            _ = deviceSampler.TakeSample(timestamp);
        }
    }
}
