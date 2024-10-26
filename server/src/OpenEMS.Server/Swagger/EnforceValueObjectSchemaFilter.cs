using System.Reflection;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;
using Vogen;

namespace OpenEMS.Server.Swagger;

public class EnforceValueObjectSchemaFilter : ISchemaFilter
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
            var isValueObject = property.Type.IsDefined(typeof(ValueObjectAttribute));
            if (!isValueObject)
            {
                continue;
            }

            if (property.Schema.Reference is null)
            {
                // Handled otherwise
                continue;
            }

            property.Schema.AllOf = [new OpenApiSchema { Reference = property.Schema.Reference }];
            property.Schema.Reference = null;
        }
    }
}
