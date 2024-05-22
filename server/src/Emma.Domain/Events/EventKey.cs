using Vogen;

namespace Emma.Domain.Events;

[ValueObject<string>(fromPrimitiveCasting: CastOperator.None)]
public readonly partial record struct EventKey
{
    public static implicit operator EventKey(string value) => From(value);

    public static bool operator <(EventKey left, EventKey right)
    {
        return left.CompareTo(right) < 0;
    }

    public static bool operator <=(EventKey left, EventKey right)
    {
        return left.CompareTo(right) <= 0;
    }

    public static bool operator >(EventKey left, EventKey right)
    {
        return left.CompareTo(right) > 0;
    }

    public static bool operator >=(EventKey left, EventKey right)
    {
        return left.CompareTo(right) >= 0;
    }

    private static string NormalizeInput(string input) => input.Trim();

    private static Validation Validate(string input)
    {
        return string.IsNullOrWhiteSpace(input)
            ? Validation.Invalid($"{nameof(EventKey)} must not be null, empty or whitespace.")
            : Validation.Ok;
    }
}
