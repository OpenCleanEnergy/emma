using OpenEMS.Domain.Units;
using Vogen;

namespace OpenEMS.Integrations.Shelly.Events;

[ValueObject<double>]
public readonly partial record struct WattMinutes
{
    public static bool operator <(WattMinutes left, WattMinutes right)
    {
        return left.CompareTo(right) < 0;
    }

    public static bool operator <=(WattMinutes left, WattMinutes right)
    {
        return left.CompareTo(right) <= 0;
    }

    public static bool operator >(WattMinutes left, WattMinutes right)
    {
        return left.CompareTo(right) > 0;
    }

    public static bool operator >=(WattMinutes left, WattMinutes right)
    {
        return left.CompareTo(right) >= 0;
    }

    public WattHours ToWattHours() => WattHours.From(Value / 60.0);
}
