using FluentAssertions;
using FluentAssertions.Execution;
using OpenEMS.Domain;
using OpenEMS.Integrations.Shelly.Domain;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Integrations.Shelly.Test.Domain;

public class IntegrationDeviceIdConverterTest
{
    [Theory]
    [InlineData("device", 0, "device-0")]
    [InlineData("123456789", 42, "123456789-42")]
    [InlineData("plug-s-abc", 3, "plug-s-abc-3")]
    public void Convert_To_IntegrationDeviceId(string shellyDeviceId, int index, string expected)
    {
        // Act
        var result = IntegrationDeviceIdConverter.GetIntegrationDeviceId(
            ShellyDeviceId.From(shellyDeviceId),
            ShellyChannelIndex.From(index)
        );

        // Assert
        result.Should().Be(IntegrationDeviceId.From(expected));
    }

    [Theory]
    [InlineData("device-0", "device", 0)]
    [InlineData("123456789-42", "123456789", 42)]
    [InlineData("plug-s-abc-3", "plug-s-abc", 3)]
    [InlineData("device-1-4", "device-1", 4)]
    public void Convert_From_IntegrationDeviceId(
        string integrationDeviceId,
        string expectedShellyDeviceId,
        int expectedIndex
    )
    {
        // Act
        var deviceId = IntegrationDeviceIdConverter.GetShellyDeviceId(
            IntegrationDeviceId.From(integrationDeviceId)
        );

        var channelIndex = IntegrationDeviceIdConverter.GetShellyChannelIndex(
            IntegrationDeviceId.From(integrationDeviceId)
        );

        // Assert
        using var scope = new AssertionScope();
        deviceId.Should().Be(ShellyDeviceId.From(expectedShellyDeviceId));
        channelIndex.Should().Be(ShellyChannelIndex.From(expectedIndex));
    }
}
