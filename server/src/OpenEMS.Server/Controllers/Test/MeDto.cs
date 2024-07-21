namespace OpenEMS.Server.Controllers.Test;

public class MeDto
{
    public required string? Name { get; init; }
    public required string? AuthenticationType { get; init; }
    public required IReadOnlyDictionary<string, string> Claims { get; init; }
}
