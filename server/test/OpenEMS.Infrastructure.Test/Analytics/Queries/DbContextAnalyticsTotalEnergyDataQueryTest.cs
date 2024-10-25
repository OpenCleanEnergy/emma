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
        var arrangeContext = await TestDbContext.CreateNew();
        var user = UserId.From("user");
        var otherUser = UserId.From("other-user");

        var start = DateTimeOffset.UtcNow;
        var end = start.Add(TimeSpan.FromDays(1));

        var samples = new ProducerSample[]
        {
            // Producer 1
            // Before start
            new()
            {
                ProducerId = GetProducerId("producer-1"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(1),
                Timestamp = start.Subtract(TimeSpan.FromSeconds(1)),
            },
            // Min value
            new()
            {
                ProducerId = GetProducerId("producer-1"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(2),
                Timestamp = start,
            },
            // Max value
            new()
            {
                ProducerId = GetProducerId("producer-1"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(4),
                Timestamp = end,
            },
            // After end
            new()
            {
                ProducerId = GetProducerId("producer-1"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(6),
                Timestamp = end.AddSeconds(1),
            },
            // Producer 2
            // No value
            new()
            {
                ProducerId = GetProducerId("producer-2"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = null,
                Timestamp = start,
            },
            // Min value
            new()
            {
                ProducerId = GetProducerId("producer-2"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(3),
                Timestamp = start.AddSeconds(1),
            },
            // Max value
            new()
            {
                ProducerId = GetProducerId("producer-2"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = WattHours.From(6),
                Timestamp = end.AddSeconds(-1),
            },
            // Producer 3 - no value
            new()
            {
                ProducerId = GetProducerId("producer-3"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = null,
                Timestamp = start,
            },
            new()
            {
                ProducerId = GetProducerId("producer-3"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = user,
                TotalEnergyProduction = null,
                Timestamp = end,
            },
            // Producer 4 - other owner
            // Min value
            new()
            {
                ProducerId = GetProducerId("producer-4"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = otherUser,
                TotalEnergyProduction = WattHours.From(4),
                Timestamp = start.AddSeconds(1),
            },
            // Max value
            new()
            {
                ProducerId = GetProducerId("producer-4"),
                CurrentPowerProduction = Watt.Zero,
                OwnedBy = otherUser,
                TotalEnergyProduction = WattHours.From(6),
                Timestamp = end.AddSeconds(-1),
            },
        };

        arrangeContext.AddRange(samples);
        await arrangeContext.SaveChangesAsync();

        _currentUserReader.GetUserIdOrThrow().Returns(user);

        // Act
        var query = new DbContextAnalyticsTotalEnergyDataQuery(
            TestDbContext.FromExisting(arrangeContext, _currentUserReader)
        );

        var result = await query.QueryTotalEnergyData(start, end);

        // Assert
        result.TotalEnergyProduction.Should().Be(WattHours.From(5));
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
