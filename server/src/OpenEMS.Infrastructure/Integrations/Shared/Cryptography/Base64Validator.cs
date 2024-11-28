namespace OpenEMS.Infrastructure.Integrations.Shared.Cryptography;

internal static class Base64Validator
{
    // https://stackoverflow.com/a/72938681
    public static bool IsValidBase64String(string value, out int bytesWritten)
    {
        var minLength = ((value.Length * 3) + 3) / 4;
        Span<byte> buffer = stackalloc byte[minLength];
        return Convert.TryFromBase64String(value, buffer, out bytesWritten);
    }
}
