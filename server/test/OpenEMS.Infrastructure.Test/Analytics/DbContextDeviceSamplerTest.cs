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

public class DbContextDeviceSamplerTest : IClassFixture<TestDbContextFixture>
{
    private readonly TestDbContextFixture _testDbContextFixture;
    private readonly DbContextDeviceSampler _deviceSampler;

    public DbContextDeviceSamplerTest(TestDbContextFixture testDbContextFixture)
    {
        _testDbContextFixture = testDbContextFixture;

        var context = _testDbContextFixture.CreateNewContext();
        var sqlFactories = typeof(IDbContextDeviceSamplingSqlFactory)
            .Assembly.GetTypes()
            .Where(type =>
                type != typeof(IDbContextDeviceSamplingSqlFactory)
                && type.IsAssignableTo(typeof(IDbContextDeviceSamplingSqlFactory))
            )
            .Select(type => (IDbContextDeviceSamplingSqlFactory)Activator.CreateInstance(type)!)
            .ToArray();

        _deviceSampler = new DbContextDeviceSampler(context, sqlFactories);
    }

    [Fact]
    public async Task Creates_Producer_Samples()
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
        var expected = new ProducerSample
        {
            Timestamp = utcNow,
            ProducerId = producer.Id,
            OwnedBy = userId,
            CurrentPowerProduction = Watt.From(12),
            MaximumPowerProduction = Watt.From(123),
            TotalEnergyProduction = WattHours.From(789),
        };

        await AddToDatabase(producer);

        // Act
        var numberOfSamples = await _deviceSampler.TakeSamples(utcNow);

        // Assert
        var currentUserReader = Substitute.For<ICurrentUserReader>();
        currentUserReader.GetUserIdOrThrow().Returns(userId);
        await using var assertContext = _testDbContextFixture.CreateNewContext(currentUserReader);

        numberOfSamples.Should().Be(NumberOfSamples.From(1));
        var history = await assertContext.ProducerSamples.ToArrayAsync();
        history.Should().BeEquivalentTo(new[] { expected });
    }

    private async Task AddToDatabase(params object[] devices)
    {
        await using var initial = _testDbContextFixture.CreateNewContext();
        initial.AddRange(devices);
        await initial.SaveChangesAsync();
    }
}
