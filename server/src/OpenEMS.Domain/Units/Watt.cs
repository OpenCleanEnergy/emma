using Vogen;

namespace OpenEMS.Domain.Units;

[ValueObject<double>]
[Instance("Zero", 0)]
public readonly partial record struct Watt
{
    public static bool operator <(Watt left, Watt right) => left.CompareTo(right) < 0;

    public static bool operator <=(Watt left, Watt right) => left.CompareTo(right) <= 0;

    public static bool operator >(Watt left, Watt right) => left.CompareTo(right) > 0;

    public static bool operator >=(Watt left, Watt right) => left.CompareTo(right) >= 0;

    public static Watt operator +(Watt left, Watt right) => From(left.Value + right.Value);

    public static Watt operator -(Watt left, Watt right) => From(left.Value - right.Value);

    public Watt Abs() => From(Math.Abs(Value));

    private static Validation Validate(double input)
    {
        _ = input;
        return Validation.Ok;
    }
}
