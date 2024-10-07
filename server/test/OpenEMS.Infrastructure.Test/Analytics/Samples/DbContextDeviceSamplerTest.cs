using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using NSubstitute;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Producers;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Analytics.Samples;

namespace OpenEMS.Infrastructure.Test.Analytics.Samples;

public class DbContextDeviceSamplerTest
{
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

        // Maximum power: 9000W and current power: 123W
        producer.ReportCurrentPowerProduction(Watt.From(9000));
        producer.ReportCurrentPowerProduction(Watt.From(123));

        // TotalEnergy.Value: 150Wh and TotalEnergy.LastReported: 50Wh
        producer.ReportTotalEnergyProduction(WattHours.From(100));
        producer.ReportTotalEnergyProduction(WattHours.From(50));

        using var arrangeContext = await TestDbContext.CreateNew();
        await AddAndSave(arrangeContext, producer);

        var utcNow = new DateTimeOffset(2024, 08, 31, 13, 34, 59, TimeSpan.Zero);

        // Act
        using var actContext = TestDbContext.FromExisting(arrangeContext);
        var sampler = CreateSampler(actContext);
        var numberOfSamples = await sampler.TakeSamples(utcNow);

        // Assert
        var currentUserReader = Substitute.For<ICurrentUserReader>();
        currentUserReader.GetUserIdOrThrow().Returns(userId);
        await using var assertContext = TestDbContext.FromExisting(
            arrangeContext,
            currentUserReader
        );

        var result = new
        {
            numberOfSamples,
            samples = await assertContext.ProducerSamples.ToArrayAsync(),
        };

        await Verify(result).DontScrubDateTimes().AddNamedGuid(producer.Id.Value, "producer-id");
    }

    [Fact]
    public async Task Creates_Switch_Consumer_Samples()
    {
        // Arrange
        var userId = UserId.From("test-user");
        var switchConsumer = new SwitchConsumer
        {
            Name = DeviceName.From("switch-consumer-1"),
            Integration = new IntegrationIdentifier(
                IntegrationId.From("switch-consumer"),
                IntegrationDeviceId.From("1")
            ),
            OwnedBy = userId,
        };

        // Maximum power: 5000W and current power: 200W
        switchConsumer.ReportCurrentPowerConsumption(Watt.From(5000));
        switchConsumer.ReportCurrentPowerConsumption(Watt.From(200));

        // TotalEnergy.Value: 400Wh and TotalEnergy.LastReported: 100Wh
        switchConsumer.ReportTotalEnergyConsumption(WattHours.From(300));
        switchConsumer.ReportTotalEnergyConsumption(WattHours.From(100));

        using var arrangeContext = await TestDbContext.CreateNew();
        await AddAndSave(arrangeContext, switchConsumer);

        var utcNow = new DateTimeOffset(2024, 08, 31, 13, 34, 59, TimeSpan.Zero);

        // Act
        using var actContext = TestDbContext.FromExisting(arrangeContext);
        var sampler = CreateSampler(actContext);
        var numberOfSamples = await sampler.TakeSamples(utcNow);

        // Assert
        var currentUserReader = Substitute.For<ICurrentUserReader>();
        currentUserReader.GetUserIdOrThrow().Returns(userId);
        await using var assertContext = TestDbContext.FromExisting(
            arrangeContext,
            currentUserReader
        );

        var result = new
        {
            numberOfSamples,
            samples = await assertContext.SwitchConsumerSamples.ToArrayAsync(),
        };

        await Verify(result)
            .DontScrubDateTimes()
            .AddNamedGuid(switchConsumer.Id.Value, "switch-consumer-id");
    }

    [Fact]
    public async Task Creates_Electricity_Meter_Samples()
    {
        // Arrange
        var userId = UserId.From("test-user");
        var meter1 = new ElectricityMeter
        {
            Name = DeviceName.From("meter-1"),
            Integration = new IntegrationIdentifier(
                IntegrationId.From("meter"),
                IntegrationDeviceId.From("1")
            ),
            OwnedBy = userId,
        };

        // Maximum power: 3.5kW and current power: 1.2kW
        meter1.ReportCurrentPower(Watt.From(3_500), GridPowerDirection.Consume);
        meter1.ReportCurrentPower(Watt.From(1_200), GridPowerDirection.Consume);

        // TotalEnergy.Value: 400Wh and TotalEnergy.LastReported: 100Wh
        meter1.ReportTotalEnergyConsumption(WattHours.From(300));
        meter1.ReportTotalEnergyConsumption(WattHours.From(100));

        var meter2 = new ElectricityMeter
        {
            Name = DeviceName.From("meter-2"),
            Integration = new IntegrationIdentifier(
                IntegrationId.From("meter"),
                IntegrationDeviceId.From("2")
            ),
            OwnedBy = userId,
        };

        // Maximum power: 5kW and current power: 0.2kW
        meter2.ReportCurrentPower(Watt.From(5_000), GridPowerDirection.FeedIn);
        meter2.ReportCurrentPower(Watt.From(200), GridPowerDirection.FeedIn);
        // TotalEnergy.Value: 150Wh and TotalEnergy.LastReported: 50Wh
        meter2.ReportTotalEnergyFeedIn(WattHours.From(100));
        meter2.ReportTotalEnergyFeedIn(WattHours.From(50));

        using var arrangeContext = await TestDbContext.CreateNew();
        await AddAndSave(arrangeContext, meter1, meter2);

        var utcNow = new DateTimeOffset(2024, 08, 31, 13, 34, 59, TimeSpan.Zero);

        // Act
        using var actContext = TestDbContext.FromExisting(arrangeContext);
        var sampler = CreateSampler(actContext);
        var numberOfSamples = await sampler.TakeSamples(utcNow);

        // Assert
        var currentUserReader = Substitute.For<ICurrentUserReader>();
        currentUserReader.GetUserIdOrThrow().Returns(userId);
        await using var assertContext = TestDbContext.FromExisting(
            arrangeContext,
            currentUserReader
        );

        var result = new
        {
            numberOfSamples,
            samples = await assertContext.ElectricityMeterSamples.ToArrayAsync(),
        };

        await Verify(result)
            .DontScrubDateTimes()
            .AddNamedGuid(meter1.Id.Value, "meter-1-id")
            .AddNamedGuid(meter2.Id.Value, "meter-2-id");
    }

    private static async Task AddAndSave(TestDbContext context, params object[] devices)
    {
        context.AddRange(devices);
        await context.SaveChangesAsync();
    }

    private static DbContextDeviceSampler CreateSampler(TestDbContext context)
    {
        var sqlFactories = typeof(IDbContextDeviceSamplingSqlFactory)
            .Assembly.GetTypes()
            .Where(type =>
                !type.IsAbstract
                && type != typeof(IDbContextDeviceSamplingSqlFactory)
                && type.IsAssignableTo(typeof(IDbContextDeviceSamplingSqlFactory))
            )
            .Select(type => (IDbContextDeviceSamplingSqlFactory)Activator.CreateInstance(type)!)
            .ToArray();

        return new DbContextDeviceSampler(context, sqlFactories);
    }
}
