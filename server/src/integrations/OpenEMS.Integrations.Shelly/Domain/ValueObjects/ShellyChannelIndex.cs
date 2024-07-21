using Vogen;

namespace OpenEMS.Integrations.Shelly.Domain.ValueObjects;

[ValueObject<int>]
public readonly partial record struct ShellyChannelIndex
{
    public static bool operator <(ShellyChannelIndex left, ShellyChannelIndex right)
    {
        return left.CompareTo(right) < 0;
    }

    public static bool operator <=(ShellyChannelIndex left, ShellyChannelIndex right)
    {
        return left.CompareTo(right) <= 0;
    }

    public static bool operator >(ShellyChannelIndex left, ShellyChannelIndex right)
    {
        return left.CompareTo(right) > 0;
    }

    public static bool operator >=(ShellyChannelIndex left, ShellyChannelIndex right)
    {
        return left.CompareTo(right) >= 0;
    }

    private static Validation Validate(int input)
    {
        return input >= 0 ? Validation.Ok : Validation.Invalid("Index can't be negative.");
    }
}
