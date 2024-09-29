using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Analytics;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class SwitchConsumerSamplesEntityTypeConfiguration
    : IEntityTypeConfiguration<SwitchConsumerSample>
{
    public void Configure(EntityTypeBuilder<SwitchConsumerSample> builder)
    {
        builder.HasShadowPrimaryKey().OfType<long>();

        builder.HasIndex(x => x.Timestamp);
    }
}
