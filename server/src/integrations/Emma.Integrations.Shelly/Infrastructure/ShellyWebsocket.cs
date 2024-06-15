using Emma.Domain;
using Emma.Integrations.Shelly.Domain.ValueObjects;
using Microsoft.Extensions.Logging;
using Websocket.Client;
using ILogger = Emma.Application.Shared.Logging.ILogger;

namespace Emma.Integrations.Shelly.Infrastructure;

public sealed class ShellyWebsocket : IDisposable
{
    private readonly FullyQualifiedDomainName _host;
    private readonly ShellyWebsocketConfigurationFactory _configurationFactory;
    private readonly ShellyWebsocketMessageHandler _messageHandler;
    private readonly ILogger _logger;
    private readonly ILoggerFactory _loggerFactory;

    private readonly CancellationTokenSource _cancellationTokenSource = new();
    private IDisposable[] _disposables = [];
    private WebsocketClient? _client;
    private ShellyWebsocketConfiguration? _configuration;

    public ShellyWebsocket(
        FullyQualifiedDomainName host,
        ShellyWebsocketConfigurationFactory configurationFactory,
        ShellyWebsocketMessageHandler messageHandler,
        ILogger logger,
        ILoggerFactory loggerFactory
    )
    {
        _host = host;
        _configurationFactory = configurationFactory;
        _messageHandler = messageHandler;
        _logger = logger;
        _loggerFactory = loggerFactory;
    }

    public async Task Start(CancellationToken cancellationToken)
    {
        await InitializeClient(cancellationToken);
        await _client!.StartOrFail();
    }

    public void Send(string json)
    {
        _client?.Send(json);
    }

    public void Dispose()
    {
        foreach (var disposable in _disposables)
        {
            disposable.Dispose();
        }

        _client?.Dispose();

        _cancellationTokenSource.Cancel();
        _cancellationTokenSource.Dispose();
    }

    private async Task InitializeClient(CancellationToken cancellationToken)
    {
        if (_client is not null)
        {
            return;
        }

        _configuration = await _configurationFactory.GetConfiguration(_host, cancellationToken);

        _client = new WebsocketClient(
            _configuration.Uri,
            _loggerFactory.CreateLogger<WebsocketClient>()
        );

        _disposables =
        [
            _client.DisconnectionHappened.Subscribe(OnDisconnectionHappened),
            _client.ReconnectionHappened.Subscribe(OnReconnectionHappened),
            _client.MessageReceived.Subscribe(OnMessageReceived),
        ];
    }

    private async Task RefreshConfiguration()
    {
        _configuration = await _configurationFactory.GetConfiguration(
            _host,
            _cancellationTokenSource.Token
        );

        _client!.Url = _configuration.Uri;
        await _client.Reconnect();
    }

    private void OnDisconnectionHappened(DisconnectionInfo info)
    {
        if (_configuration?.ValidUntil <= AmbientTimeProvider.UtcNow)
        {
            info.CancelReconnection = true;
            _ = RefreshConfiguration();
        }
    }

    private void OnReconnectionHappened(ReconnectionInfo info)
    {
        _logger.Info("Reconnection {Type} happened.", info.Type);
    }

    private void OnMessageReceived(ResponseMessage message)
    {
        _ = _messageHandler.Handle(message);
    }
}
