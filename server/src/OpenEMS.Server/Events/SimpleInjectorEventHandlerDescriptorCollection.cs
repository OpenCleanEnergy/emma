using System.Collections;
using OpenEMS.Application.Shared.Events;
using OpenEMS.Domain.Events;
using OpenEMS.Infrastructure.Events;
using SimpleInjector;

namespace OpenEMS.Server.Events;

public class SimpleInjectorEventHandlerDescriptorCollection : IEnumerable<EventHandlerDescriptor>
{
    private readonly Container _container;

    public SimpleInjectorEventHandlerDescriptorCollection(Container container)
    {
        _container = container;
    }

    public IEnumerator<EventHandlerDescriptor> GetEnumerator()
    {
        return EnumerateEventHandlerDescriptors().GetEnumerator();
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return EnumerateEventHandlerDescriptors().GetEnumerator();
    }

    private static bool IsEventHandlerInterfaceType(Type serviceType)
    {
        if (!serviceType.IsGenericType)
        {
            return false;
        }

        var requestType = serviceType.GetGenericArguments()[0];

        if (!requestType.IsGenericType)
        {
            return false;
        }

        var openGenericType = requestType.GetGenericTypeDefinition();
        return openGenericType == typeof(EventRequest<,>);
    }

    private static EventHandlerDescriptor ToEventHandlerDescriptor(Type serviceType)
    {
        var requestType = serviceType.GetGenericArguments()[0];
        var genericArguments = requestType.GetGenericArguments();
        var domainEvent =
            GetInstance(genericArguments[0]) as IEvent
            ?? throw new ArgumentException(
                $"Unable to create {nameof(IEvent)} from {serviceType.Name}",
                nameof(serviceType)
            );

        var eventChannel =
            GetInstance(genericArguments[1]) as IEventChannel
            ?? throw new ArgumentException(
                $"Unable to create {nameof(IEventChannel)} from {serviceType.Name}",
                nameof(serviceType)
            );

        return new EventHandlerDescriptor(domainEvent, eventChannel);
    }

    private static object? GetInstance(Type type)
    {
        if (type.IsValueType)
        {
            return Activator.CreateInstance(type);
        }

        var ctor =
            type.GetConstructors().MinBy(x => x.GetParameters().Length)
            ?? throw new ArgumentException($"{type.Name} has no public constructor.", nameof(type));

        var parameters = ctor.GetParameters()
            .Select(parameterInfo => GetInstance(parameterInfo.ParameterType))
            .ToArray();

        return Activator.CreateInstance(type, parameters);
    }

    private IEnumerable<EventHandlerDescriptor> EnumerateEventHandlerDescriptors()
    {
        var eventHandlerServiceTypes = _container
            .GetCurrentRegistrations()
            .Select(registration => registration.ServiceType)
            .Where(IsEventHandlerInterfaceType);

        return eventHandlerServiceTypes.Select(ToEventHandlerDescriptor);
    }
}
