using System.Diagnostics.CodeAnalysis;
using System.Text.Json.Serialization;

namespace Emma.Integrations.Shelly.Events.Status;

[SuppressMessage(
    "Style",
    "IDE0044:Add readonly modifier",
    Justification = "System.Text.Json can not deserialize readonly fields."
)]
public partial class ShellyStatus
{
    [JsonPropertyName("switch:0")]
    private ShellySwitchComponentStatus? _switch0 = null;

    [JsonPropertyName("switch:1")]
    private ShellySwitchComponentStatus? _switch1 = null;

    [JsonPropertyName("switch:2")]
    private ShellySwitchComponentStatus? _switch2 = null;

    public IReadOnlyList<ShellySwitchComponentStatus> Switches =>
        [.. new[] { _switch0, _switch1, _switch2 }.OfType<ShellySwitchComponentStatus>()];
}
