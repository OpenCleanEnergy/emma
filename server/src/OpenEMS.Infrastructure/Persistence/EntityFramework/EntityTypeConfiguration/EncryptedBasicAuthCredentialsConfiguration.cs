using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using OpenEMS.Infrastructure.Integrations.Shared.Credentials;

namespace OpenEMS.Infrastructure.Persistence.EntityFramework.EntityTypeConfiguration;

public class EncryptedBasicAuthCredentialsConfiguration
    : IEntityTypeConfiguration<EncryptedBasicAuthCredentials>
{
    public void Configure(EntityTypeBuilder<EncryptedBasicAuthCredentials> builder)
    {
        builder.HasShadowPrimaryKey();
        builder.OwnsOne(_ => _.Username).WithOwner();
        builder.OwnsOne(_ => _.Password).WithOwner();
        builder.HasIndex(_ => new { _.OwnedBy, _.Integration }).IsUnique();
    }
}
