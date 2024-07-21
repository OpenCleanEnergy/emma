using System.Reflection;
using DotNetCore.CAP;
using DotNetCore.CAP.Internal;
using OpenEMS.Application.Shared.Events;

namespace OpenEMS.Infrastructure.Events.CAP;

public class CustomConsumerServiceSelector : IConsumerServiceSelector
{
    private readonly IEnumerable<EventHandlerDescriptor> _eventHandlerDescriptors;

    public CustomConsumerServiceSelector(
        IEnumerable<EventHandlerDescriptor> eventHandlerDescriptors
    )
    {
        _eventHandlerDescriptors = eventHandlerDescriptors;
    }

    public ConsumerExecutorDescriptor? SelectBestCandidate(
        string key,
        IReadOnlyList<ConsumerExecutorDescriptor> candidates
    )
    {
        // Implementation based on ConsumerServiceSelector
        if (candidates.Count == 0)
        {
            return null;
        }

        return candidates.FirstOrDefault(desc =>
            desc.TopicName.Equals(key, StringComparison.InvariantCultureIgnoreCase)
        );
    }

    public IReadOnlyList<ConsumerExecutorDescriptor> SelectCandidates()
    {
        return _eventHandlerDescriptors.Select(ToConsumerExecutorDescriptor).ToArray();
    }

    private static ConsumerExecutorDescriptor ToConsumerExecutorDescriptor(
        EventHandlerDescriptor eventHandlerDescriptor
    )
    {
        var implTypeInfo = typeof(CapEventMediatorAdapter<>)
            .MakeGenericType(eventHandlerDescriptor.EventChannel.GetType())
            .GetTypeInfo();

        var methodInfo =
            implTypeInfo.GetMethod(nameof(CapEventMediatorAdapter<StubEventChannel>.Send))
            ?? throw new InvalidOperationException(
                $"'{nameof(CapEventMediatorAdapter<StubEventChannel>.Send)}' method not found."
            );

        var parameters = methodInfo
            .GetParameters()
            .Select(parameter => new ParameterDescriptor
            {
                Name = parameter.Name!,
                ParameterType = parameter.ParameterType,
                IsFromCap =
                    parameter.GetCustomAttributes(typeof(FromCapAttribute)).Any()
                    || typeof(CancellationToken).IsAssignableFrom(parameter.ParameterType)
            })
            .ToArray();

        return new ConsumerExecutorDescriptor
        {
            ImplTypeInfo = implTypeInfo,
            MethodInfo = methodInfo,
            Parameters = parameters,
            Attribute = ToTopicAttribute(eventHandlerDescriptor),
        };
    }

    private static CapSubscribeAttribute ToTopicAttribute(
        EventHandlerDescriptor eventHandlerDescriptor
    )
    {
        return new CapSubscribeAttribute(eventHandlerDescriptor.DomainEvent.EventKey.ToString())
        {
            Group = eventHandlerDescriptor.EventChannel.Name,
            GroupConcurrent =
                eventHandlerDescriptor.EventChannel.PrefetchCount > byte.MaxValue
                    ? byte.MaxValue
                    : (byte)eventHandlerDescriptor.EventChannel.PrefetchCount,
        };
    }

    private sealed class StubEventChannel : IEventChannel
    {
        public string Name { get; } = string.Empty;
        public int PrefetchCount { get; }
    }
}
