using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Analytics;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class ProducerHistoryEntryEntityTypeConfiguration
    : IEntityTypeConfiguration<ProducerHistoryEntry>
{
    public void Configure(EntityTypeBuilder<ProducerHistoryEntry> builder)
    {
        builder.Property<long>("_PK");
        builder.HasKey("_PK");
    }
}
