using System.Diagnostics;
using Microsoft.Extensions.Hosting;
using OpenEMS.Application.Shared.Logging;

namespace OpenEMS.Analytics;

public sealed class DeviceSamplerHostedService(
    DeviceSamplerConfiguration configuration,
    IDeviceSampler deviceSampler,
    TimeProvider timeProvider,
    ILogger logger
) : IHostedService, IDisposable
{
    private readonly DeviceSamplerConfiguration _configuration = configuration;
    private readonly CancellationTokenSource _cts = new();
    private readonly IDeviceSampler _deviceSampler = deviceSampler;
    private readonly TimeProvider _timeProvider = timeProvider;
    private readonly ILogger _logger = logger;
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

    private async void TimerCallback(object? state)
    {
        _ = state;

        var timestamp = _timeProvider.GetUtcNow();
        try
        {
            var sw = Stopwatch.StartNew();
            var numberOfSamples = await _deviceSampler.TakeSamples(timestamp);
            var elapsedMilliseconds = sw.ElapsedMilliseconds;

            _logger.Info(
                "Took {NumberOfSamples} in {ElapsedMs}",
                numberOfSamples,
                elapsedMilliseconds
            );
        }
        catch (Exception exception)
        {
            _logger.Error(exception, "Exception while taking samples.");
        }
    }
}
