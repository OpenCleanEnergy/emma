using NMolecules.DDD;
using OpenEMS.Domain.Units;

namespace OpenEMS.Domain;

[ValueObject]
public class TotalEnergy
{
    private TotalEnergy() { }

    public static TotalEnergy Zero => new();

    /// <summary>
    /// Gets the last reported value.
    /// This value may be reset to zero if the hardware has been reset.
    /// </summary>
    public WattHours LastReported { get; private set; } = WattHours.Zero;

    /// <summary>
    /// Gets the actual total energy.
    /// This value is not affected by hardware resets.
    /// </summary>
    public WattHours Value { get; private set; } = WattHours.Zero;

    public TotalEnergy WithReported(WattHours reportedValue)
    {
        if (reportedValue < LastReported)
        {
            // Hardware has been reset
            return new TotalEnergy { LastReported = reportedValue, Value = Value + reportedValue };
        }

        return new TotalEnergy
        {
            LastReported = reportedValue,
            Value = Value + (reportedValue - LastReported),
        };
    }
}
