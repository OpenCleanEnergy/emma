using Microsoft.OpenApi.Models;
using OpenEMS.Server.Configuration;

namespace OpenEMS.Server.Swagger;

public static class SwaggerGenServiceCollectionExtensions
{
    public static IServiceCollection AddSwaggerGen(
        this IServiceCollection services,
        KeycloakConfiguration keycloakConfiguration
    )
    {
        return services.AddSwaggerGen(options =>
        {
            options.SwaggerDoc(
                "v1",
                new OpenApiInfo
                {
                    Title = "OpenEMS backend server",
                    Version = "v1",
                    Description = $"You **MUST** authorize first!",
                }
            );

            options.SupportNonNullableReferenceTypes();
            options.SchemaFilter<VogenSchemaFilter>();
            options.SchemaFilter<RequireNonNullablePropertiesSchemaFilter>();
            options.ParameterFilter<RequireNonNullableParameterFilter>();

            options.CustomOperationIds(api =>
            {
                var actionId =
                    api.ActionDescriptor.AttributeRouteInfo?.Name
                    ?? api.ActionDescriptor.RouteValues["action"];

                return $"{api.ActionDescriptor.RouteValues["controller"]}_{actionId}";
            });

            var securityId = "oauth";
            options.AddSecurityDefinition(
                securityId,
                new OpenApiSecurityScheme
                {
                    Type = SecuritySchemeType.OAuth2,
                    Description =
                        $"**client_id:** `{keycloakConfiguration.SwaggerClientId ?? "not available"}`",
                    Flows = new OpenApiOAuthFlows
                    {
                        Implicit = new OpenApiOAuthFlow
                        {
                            AuthorizationUrl = keycloakConfiguration.AuthorizationEndpoint,
                        },
                    },
                }
            );
            options.AddSecurityRequirement(
                new OpenApiSecurityRequirement
                {
                    {
                        new OpenApiSecurityScheme
                        {
                            Reference = new OpenApiReference
                            {
                                Type = ReferenceType.SecurityScheme,
                                Id = securityId,
                            },
                        },
                        Array.Empty<string>()
                    },
                }
            );
        });
    }
}
