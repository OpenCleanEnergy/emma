using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Emma.Server.Swagger;

public class RequireNonNullableParameterFilter : IParameterFilter
{
    public void Apply(OpenApiParameter parameter, ParameterFilterContext context)
    {
        parameter.Required |= !parameter.Schema.Nullable;
    }
}
