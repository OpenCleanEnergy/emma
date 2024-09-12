using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using NSubstitute;
using OpenEMS.Analytics;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Domain;
using OpenEMS.Domain.Producers;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Analytics;

namespace OpenEMS.Infrastructure.Test.Analytics;

public class ProducerSamplerTest
{
    [Fact]
    public async Task Creates_Producer_History_Entry()
    {
        // Arrange
        var userId = UserId.From("test-user");
        var producer = new Producer
        {
            Name = DeviceName.From("producer-1"),
            Integration = new IntegrationIdentifier(
                IntegrationId.From("producer"),
                IntegrationDeviceId.From("1")
            ),
            OwnedBy = userId,
        };

        producer.ReportCurrentPowerProduction(Watt.From(123));
        producer.ReportCurrentPowerProduction(Watt.From(12));
        producer.ReportTotalEnergyProduction(WattHours.From(456));
        producer.ReportTotalEnergyProduction(WattHours.From(789));

        var utcNow = new DateTimeOffset(2024, 08, 31, 13, 34, 59, TimeSpan.Zero);
        var expected = new ProducerHistoryEntry
        {
            Timestamp = utcNow,
            ProducerId = producer.Id,
            OwnedBy = userId,
            CurrentPowerProduction = Watt.From(12),
            MaximumPowerProduction = Watt.From(123),
            TotalEnergyProduction = WattHours.From(789),
        };

        var currentUserReader = Substitute.For<ICurrentUserReader>();
        await using var initial = await TestDbContext.Start(currentUserReader);
        initial.Producers.Add(producer);
        await initial.SaveChangesAsync();

        await using var samplerContext = TestDbContext.FromExisting(initial);
        var sampler = new ProducerSampler(samplerContext);

        // Act
        var numberOfSamples = await sampler.TakeSample(utcNow);

        // Assert
        currentUserReader.GetUserIdOrThrow().Returns(userId);
        await using var assertContext = TestDbContext.FromExisting(initial);
        numberOfSamples.Should().Be(NumberOfSamples.From(1));
        var history = await assertContext.ProducerHistory.ToArrayAsync();
        history.Should().BeEquivalentTo(new[] { expected });
    }
}
