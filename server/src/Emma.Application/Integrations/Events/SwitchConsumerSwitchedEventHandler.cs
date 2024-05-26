using Emma.Application.Shared.Events;
using Emma.Domain.Consumers;
using Emma.Domain.Consumers.Events;
using Emma.Integrations.Shared;

namespace Emma.Application.Integrations.Events;

public class SwitchConsumerSwitchedEventHandler
    : IEventHandler<SwitchConsumerSwitchedEvent, IntegrationsEventChannel>
{
    private readonly IEnumerable<ISwitchConsumerIntegration> _switchConsumerIntegrations;

    public SwitchConsumerSwitchedEventHandler(
        IEnumerable<ISwitchConsumerIntegration> switchConsumerIntegrations
    )
    {
        _switchConsumerIntegrations = switchConsumerIntegrations;
    }

    public async Task Handle(
        EventRequest<SwitchConsumerSwitchedEvent, IntegrationsEventChannel> request,
        CancellationToken cancellationToken
    )
    {
        var domainEvent = request.DomainEvent;
        if (domainEvent.Actor == SwitchActor.Integration)
        {
            return;
        }

        var switchConsumerIntegration = _switchConsumerIntegrations.FirstOrDefault(x =>
            x.IntegrationId == domainEvent.Integration.Integration
        );

        if (switchConsumerIntegration is null)
        {
            return;
        }

        await switchConsumerIntegration.Switch(domainEvent.Integration, domainEvent.Status);
    }
}
