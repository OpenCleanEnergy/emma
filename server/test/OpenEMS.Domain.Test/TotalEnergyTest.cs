using FluentAssertions;
using OpenEMS.Domain.Units;

namespace OpenEMS.Domain.Test;

public class TotalEnergyTest
{
    [Theory]
    [InlineData(3, 1, 2, 3)]
    [InlineData(3, 1, 2, 3, 0)]
    [InlineData(4, 1, 2, 3, 1)]
    [InlineData(7, 1, 2, 3, 1, 2, 4)]
    public void Handles_Hardware_Resets(int expected, params int[] reportedValues)
    {
        // Arrange
        var totalEnergy = TotalEnergy.Zero;

        // Act
        foreach (var reportedValue in reportedValues)
        {
            totalEnergy = totalEnergy.WithReported(WattHours.From(reportedValue));
        }

        // Assert
        totalEnergy.Value.Should().Be(WattHours.From(expected));
    }
}
