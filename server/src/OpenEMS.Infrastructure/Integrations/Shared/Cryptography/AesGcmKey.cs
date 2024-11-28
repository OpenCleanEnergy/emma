using Vogen;

namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial struct AesGcmKey
{
    // https://cheatsheetseries.owasp.org/cheatsheets/Cryptographic_Storage_Cheat_Sheet.html#algorithms
    // minimum key length is 256 bits (32 bytes)
    private const int MinLength = 256 / 8;

    public static AesGcmKey From(byte[] bytes) => From(Convert.ToBase64String(bytes));

    public ReadOnlySpan<byte> AsReadOnlySpan() => Convert.FromBase64String(Value);

    private static Validation Validate(string value)
    {
        if (!Base64Validator.IsValidBase64String(value, out var bytesWritten))
        {
            return Validation.Invalid($"'{value}' is not a valid base64 string.");
        }

        if (bytesWritten < MinLength)
        {
            return Validation.Invalid(
                $"Expected '{value}' to be at least {MinLength} bytes, but it was {bytesWritten} bytes."
            );
        }

        return Validation.Ok;
    }
}
