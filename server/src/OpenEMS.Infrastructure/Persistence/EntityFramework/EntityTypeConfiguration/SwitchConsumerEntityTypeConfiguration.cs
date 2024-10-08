using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Domain.Consumers;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class SwitchConsumerEntityTypeConfiguration : IEntityTypeConfiguration<SwitchConsumer>
{
    public void Configure(EntityTypeBuilder<SwitchConsumer> builder)
    {
        builder.OwnsOne(
            switchConsumer => switchConsumer.Integration,
            navBuilder =>
            {
                navBuilder.WithOwner();
                navBuilder
                    .HasIndex(integration => new { integration.Integration, integration.Device })
                    .IsUnique();
            }
        );

        builder.OwnsOne(switchConsumer => switchConsumer.SmartModeConfiguration).WithOwner();
        builder.OwnsOne(electricityMeter => electricityMeter.TotalEnergyConsumption).WithOwner();
    }
}
