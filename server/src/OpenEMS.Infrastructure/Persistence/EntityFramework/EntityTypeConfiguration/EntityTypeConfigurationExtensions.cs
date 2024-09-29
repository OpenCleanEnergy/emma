using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public static class EntityTypeConfigurationExtensions
{
    private const string PrimaryKeyPropertyName = "_PK";

    public static ShadowPrimaryKeyBuilder<TEntity> HasShadowPrimaryKey<TEntity>(
        this EntityTypeBuilder<TEntity> builder
    )
        where TEntity : class
    {
        builder.Property<int>(PrimaryKeyPropertyName);
        builder.HasKey(PrimaryKeyPropertyName);

        return new ShadowPrimaryKeyBuilder<TEntity>(builder);
    }

    public class ShadowPrimaryKeyBuilder<TEntity>(EntityTypeBuilder<TEntity> builder)
        where TEntity : class
    {
        private readonly EntityTypeBuilder<TEntity> _builder = builder;

        public void OfType<TKey>()
        {
            _builder.Property<TKey>(PrimaryKeyPropertyName);
        }
    }
}
