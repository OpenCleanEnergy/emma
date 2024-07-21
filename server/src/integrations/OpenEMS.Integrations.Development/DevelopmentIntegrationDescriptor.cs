using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using OpenEMS.Domain;
using OpenEMS.Integrations.Shared;

namespace OpenEMS.Integrations.Development;

public class DevelopmentIntegrationDescriptor : IIntegrationDescriptor
{
    private readonly IWebHostEnvironment _environment;

    public DevelopmentIntegrationDescriptor(IWebHostEnvironment environment)
    {
        _environment = environment;
    }

    public static IntegrationId Id { get; } = IntegrationId.From("development");

    IntegrationId IIntegrationDescriptor.Id => Id;
    public string Name { get; } = "Development";
    public bool IsEnabled => _environment.IsDevelopment();

    public bool Supports(DeviceCategory deviceCategory) => true;
}
