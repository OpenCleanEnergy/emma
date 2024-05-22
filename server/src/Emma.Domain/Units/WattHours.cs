using Vogen;

namespace Emma.Domain.Units;

[ValueObject<double>]
[Instance("Zero", 0)]
public readonly partial record struct WattHours
{
    public static bool operator <(WattHours left, WattHours right) => left.CompareTo(right) < 0;

    public static bool operator <=(WattHours left, WattHours right) => left.CompareTo(right) <= 0;

    public static bool operator >(WattHours left, WattHours right) => left.CompareTo(right) > 0;

    public static bool operator >=(WattHours left, WattHours right) => left.CompareTo(right) >= 0;

    public static WattHours operator +(WattHours left, WattHours right) =>
        From(left.Value + right.Value);

    private static Validation Validate(double input)
    {
        _ = input;
        return Validation.Ok;
    }
}
