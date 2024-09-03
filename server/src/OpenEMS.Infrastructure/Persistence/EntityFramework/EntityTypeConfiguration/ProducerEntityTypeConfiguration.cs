using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Domain.Producers;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class ProducerEntityTypeConfiguration : IEntityTypeConfiguration<Producer>
{
    public void Configure(EntityTypeBuilder<Producer> builder)
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
