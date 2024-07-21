namespace OpenEMS.Server.Configuration;

public class KeycloakConfiguration
{
    public required Uri AuthServerUrl { get; init; }
    public required string Realm { get; init; }
    public string? SwaggerClientId { get; init; }
    public required string NameClaimType { get; init; }
    public required string ValidAudience { get; init; }

    public Uri BaseUrl => AuthServerUrl.Append("realms", Realm);
    public Uri MetadataAddress => BaseUrl.Append(".well-known", "openid-configuration");

    public Uri AuthorizationEndpoint => BaseUrl.Append("protocol", "openid-connect", "auth");
}
