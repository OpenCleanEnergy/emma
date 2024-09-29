using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Integrations.Shelly.Domain;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class GrantedShellyDeviceEntityTypeConfiguration
    : IEntityTypeConfiguration<GrantedShellyDevice>
{
    public void Configure(EntityTypeBuilder<GrantedShellyDevice> builder)
    {
        builder.HasShadowPrimaryKey();
        builder.HasIndex(x => new { x.DeviceId, x.Index }).IsUnique();
    }
}
