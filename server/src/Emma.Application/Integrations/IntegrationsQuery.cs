using Emma.Application.Shared;
using Emma.Domain;
using Emma.Integrations.Shared;
using MediatR;

namespace Emma.Application.Integrations;

public class IntegrationsQuery : IQuery<IntegrationDescriptionDto[]>
{
    public required DeviceCategory DeviceCategory { get; init; }

    public class Handler : IRequestHandler<IntegrationsQuery, IntegrationDescriptionDto[]>
    {
        private readonly IEnumerable<IIntegrationDescriptor> _integrationDescriptors;

        public Handler(IEnumerable<IIntegrationDescriptor> integrationDescriptors)
        {
            _integrationDescriptors = integrationDescriptors;
        }

        public Task<IntegrationDescriptionDto[]> Handle(
            IntegrationsQuery request,
            CancellationToken cancellationToken
        )
        {
            var integrations = _integrationDescriptors
                .Where(descriptor => descriptor.IsEnabled)
                .Where(descriptor => descriptor.Supports(request.DeviceCategory))
                .Select(descriptor => new IntegrationDescriptionDto
                {
                    Id = descriptor.Id,
                    Name = descriptor.Name,
                })
                .OrderBy(dto => dto.Name)
                .ToArray();

            return Task.FromResult(integrations);
        }
    }
}
