using Emma.Domain.Meters;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Emma.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

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
    }
}
