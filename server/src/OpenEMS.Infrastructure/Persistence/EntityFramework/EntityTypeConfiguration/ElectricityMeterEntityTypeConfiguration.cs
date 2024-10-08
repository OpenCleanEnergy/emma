using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Domain.Meters;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class ElectricityMeterEntityTypeConfiguration : IEntityTypeConfiguration<ElectricityMeter>
{
    public void Configure(EntityTypeBuilder<ElectricityMeter> builder)
    {
        builder.OwnsOne(
            electricityMeter => electricityMeter.Integration,
            navBuilder =>
            {
                navBuilder.WithOwner();
                navBuilder
                    .HasIndex(integration => new { integration.Integration, integration.Device })
                    .IsUnique();
            }
        );

        builder.OwnsOne(electricityMeter => electricityMeter.TotalEnergyConsumption).WithOwner();
        builder.OwnsOne(electricityMeter => electricityMeter.TotalEnergyFeedIn).WithOwner();
    }
}
