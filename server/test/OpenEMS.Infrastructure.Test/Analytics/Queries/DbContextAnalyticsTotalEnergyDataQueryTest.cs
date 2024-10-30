using System.Text;
using FluentAssertions;
using NSubstitute;
using OpenEMS.Analytics.Samples;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Domain;
using OpenEMS.Domain.Producers;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Analytics.Queries;

namespace OpenEMS.Infrastructure.Test.Analytics.Queries;

public class DbContextAnalyticsTotalEnergyDataQueryTest
{
    private readonly ICurrentUserReader _currentUserReader = Substitute.For<ICurrentUserReader>();

    [Fact]
    public async Task Queries_Total_Producer_Production()
    {
        // Arrange
        var user = UserId.From("user");
        var otherUser = UserId.From("other-user");

        var start = DateTimeOffset.UtcNow;
        var end = start.AddDays(1);

        var samples = new ProducerSample[]
        {
            // Producer 1
            // Before start
            new()
            {
                ProducerId = GetProducerId("producer-1"),
                Timestamp = start.AddSeconds(-1),
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(1),
                CurrentPowerProduction = Watt.Zero,
            },
            // Min value
            new()
            {
                ProducerId = GetProducerId("producer-1"),
                Timestamp = start,
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(2),
                CurrentPowerProduction = Watt.Zero,
            },
            // Max value
            new()
            {
                ProducerId = GetProducerId("producer-1"),
                Timestamp = end,
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(4),
                CurrentPowerProduction = Watt.Zero,
            },
            // After end
            new()
            {
                ProducerId = GetProducerId("producer-1"),
                Timestamp = end.AddSeconds(1),
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(6),
                CurrentPowerProduction = Watt.Zero,
            },
            // Producer 2
            // No value
            new()
            {
                ProducerId = GetProducerId("producer-2"),
                Timestamp = start,
                OwnedBy = user,
                TotalEnergyProduction = null,
                CurrentPowerProduction = Watt.Zero,
            },
            // Min value
            new()
            {
                ProducerId = GetProducerId("producer-2"),
                Timestamp = start.AddSeconds(1),
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(3),
                CurrentPowerProduction = Watt.Zero,
            },
            // Max value
            new()
            {
                ProducerId = GetProducerId("producer-2"),
                Timestamp = end.AddSeconds(-1),
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(6),
                CurrentPowerProduction = Watt.Zero,
            },
            // Producer 3 - no value
            new()
            {
                ProducerId = GetProducerId("producer-3"),
                Timestamp = start,
                OwnedBy = user,
                TotalEnergyProduction = null,
                CurrentPowerProduction = Watt.Zero,
            },
            new()
            {
                ProducerId = GetProducerId("producer-3"),
                Timestamp = end,
                OwnedBy = user,
                TotalEnergyProduction = null,
                CurrentPowerProduction = Watt.Zero,
            },
            // Producer 4 - other owner
            // Min value
            new()
            {
                ProducerId = GetProducerId("producer-4"),
                Timestamp = start.AddSeconds(1),
                OwnedBy = otherUser,
                TotalEnergyProduction = WattHours.From(4),
                CurrentPowerProduction = Watt.Zero,
            },
            // Max value
            new()
            {
                ProducerId = GetProducerId("producer-4"),
                Timestamp = end.AddSeconds(-1),
                OwnedBy = otherUser,
                TotalEnergyProduction = WattHours.From(6),
                CurrentPowerProduction = Watt.Zero,
            },
        };

        using var context = await TestDbContext.CreateNew();
        context.AddRange(samples);
        await context.SaveChangesAsync();

        _currentUserReader.GetUserIdOrThrow().Returns(user);

        // Act
        var query = new DbContextAnalyticsTotalEnergyDataQuery(
            TestDbContext.FromExisting(context, _currentUserReader)
        );

        var result = await query.QueryTotalEnergyData(start, end);

        // Assert
        result.Production.Should().Be(WattHours.From(5));
    }

    private static ProducerId GetProducerId(string producerId) =>
        ProducerId.From(GetGuid(producerId));

    private static Guid GetGuid(string name)
    {
        if (name.Length > 16)
        {
            throw new ArgumentException("Expected 16 characters or less.");
        }

        var nameBytes = Encoding.UTF8.GetBytes(name);
        var guidBytes = new byte[16];
        nameBytes.CopyTo(guidBytes, 0);
        return new Guid(guidBytes);
    }
}
