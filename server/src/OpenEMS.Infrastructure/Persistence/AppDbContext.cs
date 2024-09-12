using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using OpenEMS.Analytics;
using OpenEMS.Application.Shared.Identity;
using OpenEMS.Domain;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Producers;
using OpenEMS.Domain.Units;
using OpenEMS.Infrastructure.Persistence.EntityFramework.ValueConversion;
using OpenEMS.Integrations.Shelly.Domain;
using OpenEMS.Integrations.Shelly.Domain.ValueObjects;

namespace OpenEMS.Infrastructure.Persistence;

public class AppDbContext : DbContext
{
    private readonly ICurrentUserReader _currentUserReader;

    public AppDbContext(DbContextOptions options, ICurrentUserReader currentUserReader)
        : base(options)
    {
        _currentUserReader = currentUserReader;
    }

    public DbSet<GrantedShellyDevice> GrantedShellyDevices => Set<GrantedShellyDevice>();
    public DbSet<SwitchConsumer> SwitchConsumers => Set<SwitchConsumer>();
    public DbSet<Producer> Producers => Set<Producer>();
    public DbSet<ElectricityMeter> ElectricityMeters => Set<ElectricityMeter>();

    public DbSet<ProducerHistoryEntry> ProducerHistory => Set<ProducerHistoryEntry>();

    protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
    {
        configurationBuilder
            .Properties<DateTimeOffset>()
            .HaveConversion<DateTimeOffsetToUtcDateTimeConversion>();

        configurationBuilder.Properties<Enum>().HaveConversion<string>();

        // Domain
        configurationBuilder.Properties<UserId>().HaveVogenValueObjectConversion();
        configurationBuilder.Properties<DeviceName>().HaveVogenValueObjectConversion();
        configurationBuilder.Properties<IntegrationId>().HaveVogenValueObjectConversion();
        configurationBuilder.Properties<IntegrationDeviceId>().HaveVogenValueObjectConversion();

        // Units
        configurationBuilder.Properties<Watt>().HaveVogenValueObjectConversion();
        configurationBuilder.Properties<WattHours>().HaveVogenValueObjectConversion();

        // Consumers
        configurationBuilder.Properties<SwitchConsumerId>().HaveVogenValueObjectConversion();

        // Producers
        configurationBuilder.Properties<ProducerId>().HaveVogenValueObjectConversion();

        // Meters
        configurationBuilder.Properties<ElectricityMeterId>().HaveVogenValueObjectConversion();

        // Shelly
        configurationBuilder.Properties<ShellyDeviceCode>().HaveVogenValueObjectConversion();
        configurationBuilder.Properties<ShellyDeviceId>().HaveVogenValueObjectConversion();
        configurationBuilder.Properties<ShellyDeviceType>().HaveVogenValueObjectConversion();
        configurationBuilder.Properties<ShellyDeviceName>().HaveVogenValueObjectConversion();
        configurationBuilder.Properties<ShellyChannelIndex>().HaveVogenValueObjectConversion();
        configurationBuilder
            .Properties<FullyQualifiedDomainName>()
            .HaveVogenValueObjectConversion();
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);
        SetQueryFilter(modelBuilder);
    }

    private void SetQueryFilter(ModelBuilder modelBuilder)
    {
        LambdaExpression getUserId = () => _currentUserReader.GetUserIdOrThrow();
        var userId = getUserId.Body;

        var entitiesWithOwner = modelBuilder
            .Model.GetEntityTypes()
            .Where(entityType => entityType.ClrType.IsAssignableTo(typeof(IHasOwner)));

        foreach (var entity in entitiesWithOwner)
        {
            var parameter = Expression.Parameter(entity.ClrType);
            var ownedBy = Expression.Property(parameter, nameof(IHasOwner.OwnedBy));
            var filter = Expression.Lambda(Expression.Equal(ownedBy, userId), parameter);

            entity.SetQueryFilter(filter);
            entity.AddIndex(entity.GetProperty(nameof(IHasOwner.OwnedBy)));
        }
    }
}
