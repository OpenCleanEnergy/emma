using System.Collections.Concurrent;
using Emma.Application.Shared.Logging;
using Emma.Integrations.Shelly.Domain.ValueObjects;

namespace Emma.Integrations.Shelly.Infrastructure;

public sealed class ShellyWebsocketManager : IShellyWebsocketManager, IDisposable
{
    private readonly ConcurrentDictionary<
        FullyQualifiedDomainName,
        ShellyWebsocket
    > _webSocketsByHost = [];

    private readonly ShellyWebsocketConfigurationFactory _configurationFactory;

    private readonly ShellyWebsocketMessageHandler _messageHandler;
    private readonly ILogger _logger;

    public ShellyWebsocketManager(
        ShellyWebsocketConfigurationFactory configurationFactory,
        ShellyWebsocketMessageHandler messageHandler,
        ILogger<ShellyWebsocket> logger
    )
    {
        _configurationFactory = configurationFactory;
        _messageHandler = messageHandler;
        _logger = logger;
    }

    public async Task Refresh(IReadOnlySet<FullyQualifiedDomainName> hosts)
    {
        var remove = _webSocketsByHost.Keys.Except(hosts);

        foreach (var host in remove)
        {
            _webSocketsByHost.TryRemove(host, out var websocket);
            websocket?.Dispose();
        }

        var add = hosts.Except(_webSocketsByHost.Keys);

        foreach (var host in add)
        {
            var websocket = new ShellyWebsocket(
                host,
                _configurationFactory,
                _messageHandler,
                _logger
            );

            await websocket.Start();
            _webSocketsByHost.TryAdd(host, websocket);
        }
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
