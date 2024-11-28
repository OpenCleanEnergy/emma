using System.Security.Cryptography;
using Vogen;

namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial struct AesGcmNonce
{
    public static int ByteSize => AesGcm.NonceByteSizes.MaxSize;

    public static AesGcmNonce Random()
    {
        var nonce = RandomNumberGenerator.GetBytes(AesGcm.NonceByteSizes.MaxSize);
        return From(Convert.ToBase64String(nonce));
    }

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

        if (bytesWritten != AesGcm.NonceByteSizes.MaxSize)
        {
            return Validation.Invalid(
                $"Expected '{value}' to be a nonce of {AesGcm.NonceByteSizes.MaxSize} bytes, but it was {bytesWritten} bytes."
            );
        }

        return Validation.Ok;
    }
}
