using Flurl.Http;
using OpenEMS.Application.Shared.Logging;
using OpenEMS.Domain;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Infrastructure;

public class ShellyWebsocketConfigurationFactory
{
    private static readonly Uri _getAccessTokenUrl =
        new("https://api.shelly.cloud/integrator/get_access_token");

    private readonly ShellyIntegrationConfiguration _configuration;
    private readonly TimeProvider _timeProvider;
    private readonly ILogger _logger;

    public ShellyWebsocketConfigurationFactory(
        ShellyIntegrationConfiguration configuration,
        TimeProvider timeProvider,
        ILogger logger
    )
    {
        _configuration = configuration;
        _timeProvider = timeProvider;
        _logger = logger;
    }

    public virtual async Task<ShellyWebsocketConfiguration> GetConfiguration(
        FullyQualifiedDomainName host,
        CancellationToken cancellationToken
    )
    {
        var accessToken = await GetAccessTokenWithRetry(cancellationToken);
        return new ShellyWebsocketConfiguration(
            new Uri($"wss://{host}:6113/shelly/wss/hk_sock?t={accessToken}"),
            _timeProvider.GetUtcNow() + TimeSpan.FromHours(18)
        );
    }

    private static async Task RetryDelay(TimeSpan retryDelay, CancellationToken cancellationToken)
    {
        try
        {
            await Task.Delay(retryDelay, AmbientTimeProvider.Current, cancellationToken);
        }
        catch (OperationCanceledException ex) when (ex.CancellationToken == cancellationToken)
        {
            // delay canceled.
        }
    }

    private async Task<string> GetAccessTokenWithRetry(CancellationToken cancellationToken)
    {
        TimeSpan retryDelay = TimeSpan.FromMilliseconds(Random.Shared.Next(1500, 2500));

        while (true)
        {
            try
            {
                cancellationToken.ThrowIfCancellationRequested();
                return await RequestAccessToken(cancellationToken);
            }
            catch (OperationCanceledException ex) when (ex.CancellationToken == cancellationToken)
            {
                _logger.Info("Request access token canceled");
                throw;
            }
            catch (Exception ex)
            {
                _logger.Error(
                    ex,
                    "Error during request access token. Retry in {delay}",
                    retryDelay
                );

                await RetryDelay(retryDelay, cancellationToken);

                if (retryDelay < TimeSpan.FromMinutes(20))
                {
                    retryDelay *= 2;
                }
            }
        }
    }

    private async Task<string> RequestAccessToken(CancellationToken cancellationToken)
    {
        var response = await _getAccessTokenUrl.PostUrlEncodedAsync(
            new { itg = _configuration.IntegratorTag, token = _configuration.IntegratorToken },
            cancellationToken: cancellationToken
        );

        var accessTokenResponse = await response.GetJsonAsync<AccessTokenResponse>();
        return accessTokenResponse.Data;
    }

    private sealed record AccessTokenResponse(bool IsOk, string Data);
}
