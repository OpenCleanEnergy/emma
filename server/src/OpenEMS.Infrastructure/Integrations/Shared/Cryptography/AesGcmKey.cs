using System.Text;
using Vogen;

namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

[ValueObject<string>(comparison: ComparisonGeneration.Omit)]
public readonly partial struct AesGcmKey
{
    // https://cheatsheetseries.owasp.org/cheatsheets/Cryptographic_Storage_Cheat_Sheet.html#algorithms
    // minimum key length is 256 bits
    private const int MinLength = 256 / 8;

    public ReadOnlySpan<byte> AsReadOnlySpan() => Encoding.UTF8.GetBytes(Value);

    private static Validation Validate(string value)
    {
        var bytes = Encoding.UTF8.GetBytes(value);
        if (bytes.Length < MinLength)
        {
            return Validation.Invalid(
                $"Expected '{value}' to be at least {MinLength} bytes, but it was {bytes.Length} bytes."
            );
        }

        return Validation.Ok;
    }
}
