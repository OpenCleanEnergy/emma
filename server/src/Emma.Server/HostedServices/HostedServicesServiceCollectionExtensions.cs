using System.Diagnostics.CodeAnalysis;
using System.Reflection;
using SimpleInjector;

namespace Emma.Server.HostedServices;

public static class HostedServicesServiceCollectionExtensions
{
    public static IServiceCollection AddHostedServices(
        this IServiceCollection services,
        Container container
    )
    {
        var hostedServiceRegistrations = container
            .GetCurrentRegistrations()
            .Where(registration => registration.ServiceType.IsAssignableTo(typeof(IHostedService)));

        foreach (var registration in hostedServiceRegistrations)
        {
            var registerMethod = GetRegisterHostedServiceMethod(registration);
            registerMethod.Invoke(null, [services, container]);
        }

        return services;
    }

    [SuppressMessage(
        "Major Code Smell",
        "S3011:Reflection should not be used to increase accessibility of classes, methods, or fields",
        Justification = "Own helper method."
    )]
    private static MethodInfo GetRegisterHostedServiceMethod(InstanceProducer registration)
    {
        return typeof(HostedServicesServiceCollectionExtensions)
            .GetMethod(nameof(RegisterHostedService), BindingFlags.NonPublic | BindingFlags.Static)!
            .MakeGenericMethod(registration.ServiceType);
    }

    private static void RegisterHostedService<THostedService>(
        IServiceCollection services,
        Container container
    )
        where THostedService : class, IHostedService
    {
        services.AddHostedService((_) => container.GetInstance<THostedService>());
    }
}
