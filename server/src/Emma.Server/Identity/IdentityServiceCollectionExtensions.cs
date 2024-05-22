using Emma.Application.Shared.Identity;

namespace Emma.Server.Identity;

public static class IdentityServiceCollectionExtensions
{
    public static IServiceCollection AddIdentity(this IServiceCollection services)
    {
        services.AddHttpContextAccessor();
        services.AddSingleton<ICurrentUserReader, HttpContextCurrentUserReader>();
        return services;
    }
}
