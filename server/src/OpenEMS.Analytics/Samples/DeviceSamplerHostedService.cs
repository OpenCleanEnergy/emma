using System.Diagnostics;
using Microsoft.Extensions.Hosting;
using OpenEMS.Application.Shared.DependencyInjection;
using OpenEMS.Application.Shared.Logging;

namespace OpenEMS.Analytics.Samples;

public sealed class DeviceSamplerHostedService(
    DeviceSamplerConfiguration configuration,
    IScopedServiceFactory<IDeviceSampler> deviceSamplerFactory,
    TimeProvider timeProvider,
    ILogger<DeviceSamplerHostedService> logger
) : IHostedService, IDisposable
{
    private readonly DeviceSamplerConfiguration _configuration = configuration;

    private readonly CancellationTokenSource _cts = new();
    private readonly IScopedServiceFactory<IDeviceSampler> _deviceSamplerFactory =
        deviceSamplerFactory;
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

        try
        {
            using var scope = _deviceSamplerFactory.GetScopedInstance();

            var timestamp = _timeProvider.GetUtcNow();
            var sw = Stopwatch.StartNew();
            var numberOfSamples = await scope.Service.TakeSamples(timestamp);

            _logger.Info(
                "Took {NumberOfSamples} samples in {ElapsedMs} ms",
                numberOfSamples,
                sw.ElapsedMilliseconds
            );
        }
        catch (Exception exception)
        {
            _logger.Error(exception, "Exception while taking samples.");
        }
    }
}
