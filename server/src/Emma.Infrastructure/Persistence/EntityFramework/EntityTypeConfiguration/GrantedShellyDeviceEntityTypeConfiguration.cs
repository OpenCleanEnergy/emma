using Emma.Integrations.Shelly.Domain;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Emma.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class GrantedShellyDeviceEntityTypeConfiguration
    : IEntityTypeConfiguration<GrantedShellyDevice>
{
    public void Configure(EntityTypeBuilder<GrantedShellyDevice> builder)
    {
        builder.Property<int>("_PK");
        builder.HasKey("_PK");

        builder.HasIndex(x => new { x.DeviceId, x.Index }).IsUnique();
    }
}
