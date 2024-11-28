using Vogen;

namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial struct AesGcmCiphertext
{
    public static AesGcmCiphertext From(byte[] tag) => From(Convert.ToBase64String(tag));

    public ReadOnlySpan<byte> AsReadOnlySpan() => Convert.FromBase64String(Value);

    private static Validation Validate(string value)
    {
        // https://stackoverflow.com/a/72938681
        var minLength = ((value.Length * 3) + 3) / 4;
        Span<byte> buffer = stackalloc byte[minLength];
        var validBase64 = Convert.TryFromBase64String(value, buffer, out var bytesWritten);
        if (!validBase64)
        {
            return Validation.Invalid($"'{value}' is not a valid base64 string.");
        }

        return Validation.Ok;
    }
}
