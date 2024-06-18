using Emma.Application.Shared.Logging;
using Emma.Domain;
using Emma.Integrations.Shared;
using Emma.Integrations.Shelly.Domain.ValueObjects;
using Microsoft.Extensions.Hosting;

namespace Emma.Integrations.Shelly.Infrastructure;

public sealed class ShellyHostedService : IHostedService, IDisposable
{
    private static readonly TimeSpan _retryDelay = TimeSpan.FromSeconds(10);

    private readonly CancellationTokenSource _cancellationTokenSource = new();

    private readonly ShellyIntegrationConfiguration _configuration;
    private readonly IScopedServiceFactory<IShellyHostsReader> _hostsReaderFactory;
    private readonly IShellyWebsocketManager _websocketManager;
    private readonly ILogger _logger;

    private Task? _backgroundTask;

    public ShellyHostedService(
        ShellyIntegrationConfiguration configuration,
        IScopedServiceFactory<IShellyHostsReader> hostsReaderFactory,
        IShellyWebsocketManager websocketManager,
        ILogger logger
    )
    {
        _configuration = configuration;
        _hostsReaderFactory = hostsReaderFactory;
        _websocketManager = websocketManager;
        _logger = logger;
    }

    public Task StartAsync(CancellationToken cancellationToken)
    {
        if (!_configuration.IsEnabled)
        {
            _logger.Info(
                "Integration {Integration} is disabled. Service is shutting down.",
                ShellyIntegrationDescriptor.Id
            );
            return Task.CompletedTask;
        }

        if (!_configuration.Validate(out var invalidProperties))
        {
            _logger.Warning(
                "Configuration is invalid because of {@invalidProperties}. Service is shutting down.",
                invalidProperties
            );

            return Task.CompletedTask;
        }

        _backgroundTask = Background(_cancellationTokenSource.Token);
        return Task.CompletedTask;
    }

    public async Task StopAsync(CancellationToken cancellationToken)
    {
        await _cancellationTokenSource.CancelAsync();
        await (_backgroundTask ?? Task.CompletedTask);
    }

    public void Dispose()
    {
        _cancellationTokenSource.Dispose();
    }

    private static async Task RetryDelay(CancellationToken cancellationToken)
    {
        try
        {
            await Task.Delay(_retryDelay, AmbientTimeProvider.Current, cancellationToken);
        }
        catch (OperationCanceledException ex) when (ex.CancellationToken == cancellationToken)
        {
            // delay canceled.
        }
    }

    private async Task Background(CancellationToken cancellationToken)
    {
        while (true)
        {
            try
            {
                cancellationToken.ThrowIfCancellationRequested();

                _logger.Info("Refresh hosts.");
                var hosts = await GetAllHosts();
                await _websocketManager.Refresh(hosts, cancellationToken);
                _logger.Info("Refreshed hosts. Listen for changes in hosts.");
                await WaitForChanges(cancellationToken);
            }
            catch (OperationCanceledException ex) when (ex.CancellationToken == cancellationToken)
            {
                _logger.Info("Service is shutting down.");
                return;
            }
            catch (Exception ex)
            {
                _logger.Warning(ex, "Error during hosts refresh. Retry in {delay}", _retryDelay);
                await RetryDelay(cancellationToken);
            }
        }
    }

    private async Task<IReadOnlySet<FullyQualifiedDomainName>> GetAllHosts()
    {
        using var scope = _hostsReaderFactory.GetScopedInstance();
        return await scope.Service.GetAllHosts();
    }

    private async Task WaitForChanges(CancellationToken cancellationToken)
    {
        using var scope = _hostsReaderFactory.GetScopedInstance();
        await scope.Service.WaitForChanges(cancellationToken);
    }
}
