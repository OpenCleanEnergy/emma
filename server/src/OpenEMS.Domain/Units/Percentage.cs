using Vogen;

namespace OpenEMS.Domain.Units;

[ValueObject<double>]
[Instance("Zero", 0)]
public readonly partial record struct Percentage
{
    public static bool operator <(Percentage left, Percentage right) => left.CompareTo(right) < 0;

    public static bool operator <=(Percentage left, Percentage right) => left.CompareTo(right) <= 0;

    public static bool operator >(Percentage left, Percentage right) => left.CompareTo(right) > 0;

    public static bool operator >=(Percentage left, Percentage right) => left.CompareTo(right) >= 0;

    public static Percentage operator +(Percentage left, Percentage right) =>
        From(left.Value + right.Value);

    private static Validation Validate(double input)
    {
        if (input < 0 || input > 100)
        {
            return Validation.Invalid(
                $"{nameof(Percentage)} is expected to be between 0 and 100. {input} is out of range."
            );
        }

        return Validation.Ok;
    }
}
