using System.Security.Cryptography;
using Vogen;

namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial struct AesGcmTag
{
    public static int ByteSize => AesGcm.TagByteSizes.MaxSize;

    public static AesGcmTag From(byte[] bytes) => From(Convert.ToBase64String(bytes));

    public ReadOnlySpan<byte> AsReadOnlySpan() => Convert.FromBase64String(Value);

    private static Validation Validate(string value)
    {
        if (!Base64Validator.IsValidBase64String(value, out var bytesWritten))
        {
            return Validation.Invalid($"'{value}' is not a valid base64 string.");
        }

        if (bytesWritten != AesGcm.TagByteSizes.MaxSize)
        {
            return Validation.Invalid(
                $"Expected '{value}' to be a tag of {AesGcm.TagByteSizes.MaxSize} bytes, but it was {bytesWritten} bytes."
            );
        }

        return Validation.Ok;
    }
}
