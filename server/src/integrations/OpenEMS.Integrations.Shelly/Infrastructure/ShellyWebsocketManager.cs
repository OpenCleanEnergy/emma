using OpenEMS.Application.Shared.Logging;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;
using ILoggerFactory = Microsoft.Extensions.Logging.ILoggerFactory;

namespace OpenEMS.Integrations.Shelly.Infrastructure;

public sealed class ShellyWebsocketManager : IShellyWebsocketManager, IDisposable
{
    private readonly Dictionary<FullyQualifiedDomainName, ShellyWebsocket> _webSocketsByHost = [];

    private readonly ShellyWebsocketConfigurationFactory _configurationFactory;

    private readonly ShellyWebsocketMessageHandler _messageHandler;
    private readonly ILogger _logger;
    private readonly ILoggerFactory _loggerFactory;

    public ShellyWebsocketManager(
        ShellyWebsocketConfigurationFactory configurationFactory,
        ShellyWebsocketMessageHandler messageHandler,
        ILogger<ShellyWebsocket> logger,
        ILoggerFactory loggerFactory
    )
    {
        _configurationFactory = configurationFactory;
        _messageHandler = messageHandler;
        _logger = logger;
        _loggerFactory = loggerFactory;
    }

    public async Task Refresh(
        IReadOnlySet<FullyQualifiedDomainName> hosts,
        CancellationToken cancellationToken
    )
    {
        var remove = _webSocketsByHost.Keys.Except(hosts);

        foreach (var host in remove)
        {
            _webSocketsByHost.Remove(host, out var websocket);
            websocket?.Dispose();
        }

        var add = hosts.Except(_webSocketsByHost.Keys);

        var starts = new List<Task>();

        foreach (var host in add)
        {
            var websocket = new ShellyWebsocket(
                host,
                _configurationFactory,
                _messageHandler,
                _logger,
                _loggerFactory
            );

            _webSocketsByHost.Add(host, websocket);
            starts.Add(websocket.Start(cancellationToken));
        }

        await Task.WhenAll(starts);
    }

    public void Dispose()
    {
        foreach (var websocket in _webSocketsByHost.Values)
        {
            websocket.Dispose();
        }
    }

    public void Send(FullyQualifiedDomainName host, string json)
    {
        if (!_webSocketsByHost.TryGetValue(host, out var websocket))
        {
            return;
        }

        websocket.Send(json);
    }
}
