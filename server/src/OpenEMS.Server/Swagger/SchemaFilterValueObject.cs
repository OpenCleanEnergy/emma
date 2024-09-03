using Vogen;

[assembly: VogenDefaults(
    openApiSchemaCustomizations: OpenApiSchemaCustomizations.GenerateSwashbuckleSchemaFilter
)]

namespace OpenEMS.Server.Swagger;

[ValueObject<byte>]
internal readonly partial record struct SchemaFilterValueObject
{
    private static Validation Validate(byte input)
    {
        _ = input;
        return Validation.Invalid(
            "Exists only to trigger generation of swashbuckle schema filter."
        );
    }
}
