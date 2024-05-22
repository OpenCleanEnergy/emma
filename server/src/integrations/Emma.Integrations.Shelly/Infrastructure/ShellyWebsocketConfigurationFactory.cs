using Emma.Domain;
using Emma.Integrations.Shelly.Domain.ValueObjects;
using Flurl.Http;

namespace Emma.Integrations.Shelly.Infrastructure;

public class ShellyWebsocketConfigurationFactory
{
    private static readonly Uri _getAccessTokenUri =
        new("https://api.shelly.cloud/integrator/get_access_token");

    private readonly ShellyIntegrationConfiguration _configuration;

    public ShellyWebsocketConfigurationFactory(ShellyIntegrationConfiguration configuration)
    {
        _configuration = configuration;
    }

    public virtual async Task<ShellyWebsocketConfiguration> GetConfiguration(
        FullyQualifiedDomainName host
    )
    {
        var accessToken = await RequestAccessToken();
        return new ShellyWebsocketConfiguration(
            new Uri($"wss://{host}:6113/shelly/wss/hk_sock?t={accessToken}"),
            AmbientTimeProvider.UtcNow + TimeSpan.FromHours(18)
        );
    }

    private async Task<string> RequestAccessToken()
    {
        var response = await _getAccessTokenUri.PostUrlEncodedAsync(
            new { itg = _configuration.IntegratorTag, token = _configuration.IntegratorToken }
        );

        var accessTokenResponse = await response.GetJsonAsync<AccessTokenResponse>();
        return accessTokenResponse.Data;
    }

    private sealed record AccessTokenResponse(bool IsOk, string Data);
}
