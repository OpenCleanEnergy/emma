using System.Text.Json;

namespace Emma.Integrations.Shelly.Commands;

public class ShellyCommandRequestSerializer
{
    public virtual string Serialize(ShellyCommandRequest commandRequest)
    {
        return JsonSerializer.Serialize(commandRequest, commandRequest.GetType());
    }
}
