using System.Reflection;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using Vogen;

namespace Emma.Server.Swagger;

public class ValueObjectSchemaFilter : ISchemaFilter
{
    public void Apply(OpenApiSchema schema, SchemaFilterContext context)
    {
        var type = context.Type;
        if (!type.IsDefined(typeof(ValueObjectAttribute)))
        {
            return;
        }

        var valueType = type.GetProperty("Value")!.PropertyType;
        var valueSchema = context.SchemaGenerator.GenerateSchema(
            valueType,
            context.SchemaRepository
        );

        schema.Type = valueSchema.Type;
        schema.Format = valueSchema.Format;
        schema.Nullable = valueSchema.Nullable;
        schema.Required = valueSchema.Required;
        schema.Properties = valueSchema.Properties;
        schema.AdditionalProperties = valueSchema.AdditionalProperties;
        schema.AdditionalPropertiesAllowed = valueSchema.AdditionalPropertiesAllowed;
    }
}
