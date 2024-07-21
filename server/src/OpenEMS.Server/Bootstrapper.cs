using System.Reflection;
using MediatR;
using OpenEMS.Application.Integrations;
using OpenEMS.Application.Shared;
using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Consumers;
using OpenEMS.Domain.Meters;
using OpenEMS.Domain.Producers;
using OpenEMS.Infrastructure;
using OpenEMS.Infrastructure.Devices.Consumers;
using OpenEMS.Infrastructure.Devices.Meters;
using OpenEMS.Infrastructure.Devices.Producers;
using OpenEMS.Infrastructure.Events;
using OpenEMS.Infrastructure.Events.CAP;
using OpenEMS.Infrastructure.Integrations;
using OpenEMS.Infrastructure.Persistence;
using OpenEMS.Infrastructure.Persistence.EntityFramework;
using OpenEMS.Infrastructure.RequestPipeline;
using OpenEMS.Infrastructure.Shelly;
using OpenEMS.Integrations.Development;
using OpenEMS.Integrations.Shared;
using OpenEMS.Integrations.Shelly;
using OpenEMS.Integrations.Shelly.Callback.Trust;
using OpenEMS.Integrations.Shelly.Commands;
using OpenEMS.Integrations.Shelly.Domain;
using OpenEMS.Integrations.Shelly.Events;
using OpenEMS.Integrations.Shelly.Infrastructure;
using OpenEMS.Server.Events;
using OpenEMS.Server.Integrations;
using OpenEMS.Server.Logging;
using SimpleInjector;

namespace OpenEMS.Server;

public static class Bootstrapper
{
    public static IEnumerable<Assembly> Assemblies =>
        [
            typeof(IntegrationsQuery).Assembly,
            // Integrations
            typeof(ShellyIntegrationDescriptor).Assembly,
            typeof(DevelopmentIntegrationDescriptor).Assembly,
        ];

    public static void Bootstrap(Container container, IConfiguration configuration)
    {
        AddLogging(container);
        AddDomain(container);
        AddRequestHandler(container);
        AddPersistence(container);
        AddIntegrations(container, configuration);
    }

    private static void AddLogging(Container container)
    {
        container.RegisterSingleton<Serilog.ILogger>(() => Serilog.Log.Logger);
        container.RegisterConditional(
            typeof(Application.Shared.Logging.ILogger),
            context =>
                context.Consumer is null
                    ? typeof(SerilogLoggerAdapter)
                    : typeof(SerilogLoggerAdapter<>).MakeGenericType(
                        context.Consumer.ImplementationType
                    ),
            Lifestyle.Singleton,
            _ => true
        );

        container.RegisterSingleton(
            typeof(Application.Shared.Logging.ILogger<>),
            typeof(SerilogLoggerAdapter<>)
        );
    }

    private static void AddDomain(Container container)
    {
        // Consumers
        container.Register<ISwitchConsumerRepository, SwitchConsumerRepository>(Lifestyle.Scoped);
        container.Register<IElectricityMeterRepository, ElectricityMeterRepository>(
            Lifestyle.Scoped
        );

        container.Register<IProducerRepository, ProducerRepository>(Lifestyle.Scoped);
    }

    private static void AddRequestHandler(Container container)
    {
        var mediator = new Mediator(container);
        container.RegisterInstance<ISender>(mediator);
        container.RegisterInstance(() => container.GetInstance<ISender>());
        container.Register(typeof(IRequestHandler<,>), Assemblies);
        container.Register(typeof(IRequestHandler<>), Assemblies);

        // Events
        container.RegisterSingleton<IEventPublisher, CapEventPublisher>();

        container.RegisterInstance<IEventMediator>(
            new SimpleInjectorScopedEventMediator(container, new MediatREventMediator(mediator))
        );

        container.RegisterInstance<IEnumerable<EventHandlerDescriptor>>(
            new SimpleInjectorEventHandlerDescriptorCollection(container)
        );

        // Pipeline
        container.Collection.Register(
            typeof(IPipelineBehavior<,>),
            [typeof(LoggingBehavior<,>), typeof(TransactionBehavior<,>)]
        );
    }

    private static void AddPersistence(Container container)
    {
        container.Register<IUnitOfWork, UnitOfWork>(Lifestyle.Scoped);
        container.Collection.Register<IUnitOfWorkInterceptor>(
            [typeof(IUnitOfWorkInterceptor).Assembly],
            Lifestyle.Scoped
        );
    }

    private static void AddIntegrations(Container container, IConfiguration configuration)
    {
        container.Register<IExistingDevicesReader, ExistingDevicesReader>();
        container.Register<IDevicesRepository, DevicesRepository>();
        container.RegisterSingleton(
            typeof(IScopedServiceFactory<>),
            typeof(SimpleInjectorScopedServiceFactory<>)
        );

        container.Collection.Register<IIntegrationDescriptor>(Assemblies);
        container.Collection.Register<ISwitchConsumerIntegration>(Assemblies);

        var config =
            configuration.GetRequiredSection("Integrations").Get<IntegrationsConfiguration>()
            ?? throw new ArgumentException("Failed to read integrations configuration");

        // Shelly
        container.RegisterInstance(config.Shelly);
        container.RegisterSingleton<ShellyTrustTokenValidator>();
        container.Register<IGrantedShellyDeviceRepository, GrantedShellyDeviceRepository>(
            Lifestyle.Scoped
        );
        container.Register<IShellyHostsReader, ShellyHostsReader>();
        container.RegisterInstance(container.GetInstance<IShellyHostsReader>);
        container.RegisterSingleton<ShellyHostedService>();
        container.RegisterSingleton<ShellyWebsocketConfigurationFactory>();
        container.RegisterSingleton<IShellyWebsocketManager, ShellyWebsocketManager>();
        container.RegisterSingleton<ShellyWebsocketMessageHandler>();
        container.RegisterSingleton<ShellyEventSerializer>();

        container.Register<ShellyCommandRequestSerializer>();
        container.Register<ShellyCommandSender>();

        container.RegisterInstance(ShellyHostsAutoResetEvent.Instance);
    }
}
