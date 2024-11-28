using Vogen;

namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial struct AesGcmCiphertext
{
    public static AesGcmCiphertext From(byte[] tag) => From(Convert.ToBase64String(tag));

    public ReadOnlySpan<byte> AsReadOnlySpan() => Convert.FromBase64String(Value);

    private static Validation Validate(string value)
    {
        if (!Base64Validator.IsValidBase64String(value, out _))
        {
            return Validation.Invalid($"'{value}' is not a valid base64 string.");
        }

        return Validation.Ok;
    }
}
