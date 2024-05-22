using Vogen;

namespace Emma.Domain;

[ValueObject<string>]
public readonly partial record struct DeviceName
{
    public static bool operator <(DeviceName left, DeviceName right)
    {
        return left.CompareTo(right) < 0;
    }

    public static bool operator >(DeviceName left, DeviceName right)
    {
        return left.CompareTo(right) > 0;
    }

    public static bool operator <=(DeviceName left, DeviceName right)
    {
        return left.CompareTo(right) <= 0;
    }

    public static bool operator >=(DeviceName left, DeviceName right)
    {
        return left.CompareTo(right) >= 0;
    }

    private static string NormalizeInput(string input) => input.Trim();

    private static Validation Validate(string input)
    {
        return string.IsNullOrWhiteSpace(input)
            ? Validation.Invalid($"{nameof(DeviceName)} must not be null or empty or whitespace.")
            : Validation.Ok;
    }
}
