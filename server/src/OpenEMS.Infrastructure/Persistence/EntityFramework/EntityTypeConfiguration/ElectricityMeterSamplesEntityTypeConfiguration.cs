using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Analytics;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class ElectricityMeterSamplesEntityTypeConfiguration
    : IEntityTypeConfiguration<ElectricityMeterSample>
{
    public void Configure(EntityTypeBuilder<ElectricityMeterSample> builder)
    {
        builder.HasShadowPrimaryKey().OfType<long>();
        builder.HasIndex(x => x.Timestamp);
    }
}
