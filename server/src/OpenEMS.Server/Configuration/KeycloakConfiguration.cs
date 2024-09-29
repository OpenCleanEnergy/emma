using System.ComponentModel.DataAnnotations;

namespace OpenEMS.Server.Configuration;

public class KeycloakConfiguration : IValidatableObject
{
    public required Uri AuthServerUrl { get; init; }
    public required string Realm { get; init; }
    public string? SwaggerClientId { get; init; }
    public required string NameClaimType { get; init; }
    public required string ValidAudience { get; init; }

    public Uri BaseUrl => AuthServerUrl.Append("realms", Realm);
    public Uri MetadataAddress => BaseUrl.Append(".well-known", "openid-configuration");

    public Uri AuthorizationEndpoint => BaseUrl.Append("protocol", "openid-connect", "auth");

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        const string isRequired = "is required";

        if (AuthServerUrl is null)
        {
            yield return new ValidationResult(isRequired, [nameof(AuthServerUrl)]);
        }

        if (string.IsNullOrEmpty(Realm))
        {
            yield return new ValidationResult(isRequired, [nameof(Realm)]);
        }

        if (string.IsNullOrEmpty(NameClaimType))
        {
            yield return new ValidationResult(isRequired, [nameof(NameClaimType)]);
        }

        if (string.IsNullOrEmpty(ValidAudience))
        {
            yield return new ValidationResult(isRequired, [nameof(ValidAudience)]);
        }
    }
}
