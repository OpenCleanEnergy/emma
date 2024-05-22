using Emma.Domain;

namespace Emma.Application.Integrations;

public class IntegrationDescriptionDto
{
    public required IntegrationId Id { get; init; }
    public required string Name { get; init; }
}
