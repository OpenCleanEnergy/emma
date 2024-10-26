using System.Text;
using FluentAssertions;
using NSubstitute;
using OpenEMS.Analytics.Queries;
using OpenEMS.Analytics.Samples;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Analytics.Queries;

namespace OpenEMS.Infrastructure.Test.Analytics.Queries;

public class DbContextAnalyticsDayDataQueryTest
{
    private const int StrideMinutes = 30;
    private readonly ICurrentUserReader _currentUserReader = Substitute.For<ICurrentUserReader>();

    private readonly UserId _user = UserId.From("user");
    private readonly UserId _otherUser = UserId.From("other-user");

    [Fact]
    public async Task Queries_Consumers()
    {
        // Arrange
        var start = new DateTimeOffset(2024, 10, 25, 00, 00, 00, TimeSpan.Zero);
        var end = start.AddDays(1);

        var bin1 = new { Start = start, End = start.AddMinutes(StrideMinutes - 0.1) };
        var bin2 = new
        {
            Start = start.AddMinutes(StrideMinutes),
            End = start.AddMinutes(StrideMinutes + StrideMinutes - 0.1),
        };
        var lastBin = new { Start = end, End = end.AddMinutes(StrideMinutes - 0.1) };

        var samples = new SwitchConsumerSample[]
        {
            // Consumer 1
            // Before start
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-1"),
                Timestamp = start.AddSeconds(-1),
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(1),
                TotalEnergyConsumption = WattHours.Zero,
            },
            // Bin 1
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-1"),
                Timestamp = bin1.Start,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(2),
                TotalEnergyConsumption = WattHours.Zero,
            },
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-1"),
                Timestamp = bin1.End,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(4),
                TotalEnergyConsumption = WattHours.Zero,
            },
            // Bin 2
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-1"),
                Timestamp = bin2.Start,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(4),
                TotalEnergyConsumption = WattHours.Zero,
            },
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-1"),
                Timestamp = bin2.End,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(8),
                TotalEnergyConsumption = WattHours.Zero,
            },
            // Last bin
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-1"),
                Timestamp = lastBin.Start,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(16),
                TotalEnergyConsumption = WattHours.Zero,
            },
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-1"),
                Timestamp = lastBin.End,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(32),
                TotalEnergyConsumption = WattHours.Zero,
            },
            // After last bin
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-1"),
                Timestamp = end.AddMinutes(StrideMinutes).AddSeconds(1),
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(4),
                TotalEnergyConsumption = WattHours.Zero,
            },
            // Consumer 2
            // Bin 1 - first without value
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-2"),
                Timestamp = bin1.Start,
                OwnedBy = _user,
                CurrentPowerConsumption = null,
                TotalEnergyConsumption = WattHours.Zero,
            },
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-2"),
                Timestamp = bin1.End,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(8),
                TotalEnergyConsumption = WattHours.Zero,
            },
            // Bin 2 - second without value
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-2"),
                Timestamp = bin2.Start,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(16),
                TotalEnergyConsumption = WattHours.Zero,
            },
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-2"),
                Timestamp = bin2.End,
                OwnedBy = _user,
                CurrentPowerConsumption = null,
                TotalEnergyConsumption = WattHours.Zero,
            },
            // Last bin
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-2"),
                Timestamp = lastBin.Start,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(64),
                TotalEnergyConsumption = WattHours.Zero,
            },
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-2"),
                Timestamp = lastBin.End,
                OwnedBy = _user,
                CurrentPowerConsumption = Watt.From(128),
                TotalEnergyConsumption = WattHours.Zero,
            },
            // Consumer 3 - other user
            // Bin 1
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-3"),
                Timestamp = bin1.Start,
                OwnedBy = _otherUser,
                CurrentPowerConsumption = Watt.From(99),
                TotalEnergyConsumption = WattHours.Zero,
            },
            new()
            {
                SwitchConsumerId = GetSwitchConsumerId("consumer-3"),
                Timestamp = bin1.End,
                OwnedBy = _otherUser,
                CurrentPowerConsumption = Watt.From(999),
                TotalEnergyConsumption = WattHours.Zero,
            },
        };

        using var context = await TestDbContext.CreateNew();
        context.AddRange(samples);
        await context.SaveChangesAsync();

        _currentUserReader.GetUserIdOrThrow().Returns(_user);
        // Act
        var query = new DbContextAnalyticsDayDataQuery(
            TestDbContext.FromExisting(context, _currentUserReader),
            _currentUserReader
        );

        var result = await query.QueryDayData(start, end, TimeSpan.FromMinutes(StrideMinutes));

        // Assert
        result
            .Consumers.Should()
            .BeEquivalentTo(
                new PowerDataPoint[]
                {
                    new(bin1.Start, Watt.From(((2 + 4) / 2.0) + 8)),
                    new(bin2.Start, Watt.From(((4 + 8) / 2.0) + 16)),
                    new(lastBin.Start, Watt.From(((16 + 32) / 2.0) + ((64 + 128) / 2.0))),
                }
            );
    }

    private static SwitchConsumerId GetSwitchConsumerId(string switchConsumerId) =>
        SwitchConsumerId.From(GetGuid(switchConsumerId));

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
