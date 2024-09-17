using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Analytics;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class ProducerSamplesEntityTypeConfiguration : IEntityTypeConfiguration<ProducerSample>
{
    public void Configure(EntityTypeBuilder<ProducerSample> builder)
    {
        builder.Property<long>("_PK");
        builder.HasKey("_PK");

        builder.HasIndex(x => x.Timestamp);
    }
}
