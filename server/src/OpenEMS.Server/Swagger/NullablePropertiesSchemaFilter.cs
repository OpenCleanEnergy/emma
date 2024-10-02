using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace OpenEMS.Server.Swagger;

// Workaround for https://github.com/epam-cross-platform-lab/swagger-dart-code-generator/issues/721
public class NullablePropertiesSchemaFilter : ISchemaFilter
{
    public void Apply(OpenApiSchema schema, SchemaFilterContext context)
    {
        var properties =
            from schemaProp in schema.Properties
            join prop in context.Type.GetProperties()
                on schemaProp.Key.ToUpperInvariant() equals prop.Name.ToUpperInvariant()
            select new { Schema = schemaProp.Value, Type = prop.PropertyType };

        foreach (var property in properties)
        {
            var isNullable = Nullable.GetUnderlyingType(property.Type) != null;
            if (!isNullable)
            {
                continue;
            }

            property.Schema.AllOf = [new OpenApiSchema { Reference = property.Schema.Reference }];
            property.Schema.Reference = null;
            property.Schema.Nullable = isNullable;
        }
    }
}
