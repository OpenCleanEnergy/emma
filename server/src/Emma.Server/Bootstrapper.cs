using System.Reflection;
using Emma.Application.Integrations;
using Emma.Application.Shared;
using Emma.Application.Shared.Events;
using Emma.Domain.Consumers;
using Emma.Domain.Meters;
using Emma.Domain.Producers;
using Emma.Infrastructure;
using Emma.Infrastructure.Devices.Consumers;
using Emma.Infrastructure.Devices.Meters;
using Emma.Infrastructure.Devices.Producers;
using Emma.Infrastructure.Events;
using Emma.Infrastructure.Events.CAP;
using Emma.Infrastructure.Integrations;
using Emma.Infrastructure.Persistence;
using Emma.Infrastructure.Persistence.EntityFramework;
using Emma.Infrastructure.RequestPipeline;
using Emma.Infrastructure.Shelly;
using Emma.Integrations.Development;
using Emma.Integrations.Shared;
using Emma.Integrations.Shelly;
using Emma.Integrations.Shelly.Callback.Trust;
using Emma.Integrations.Shelly.Commands;
using Emma.Integrations.Shelly.Domain;
using Emma.Integrations.Shelly.Events;
using Emma.Integrations.Shelly.Infrastructure;
using Emma.Server.Events;
using Emma.Server.Integrations;
using Emma.Server.Logging;
using MediatR;
using SimpleInjector;

namespace Emma.Server;

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
