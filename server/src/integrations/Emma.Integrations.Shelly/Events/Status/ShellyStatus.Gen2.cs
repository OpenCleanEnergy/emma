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
    // switch
    [JsonPropertyName("switch:0")]
    private ShellySwitchComponentStatus? _switch0 = null;

    [JsonPropertyName("switch:1")]
    private ShellySwitchComponentStatus? _switch1 = null;

    [JsonPropertyName("switch:2")]
    private ShellySwitchComponentStatus? _switch2 = null;

    [JsonPropertyName("switch:3")]
    private ShellySwitchComponentStatus? _switch3 = null;

    // em
    [JsonPropertyName("em:0")]
    private ShellyEMComponentStatus? _em0 = null;

    [JsonPropertyName("emdata:0")]
    private ShellyEMDataComponentStatus? _emData0 = null;

    // em1
    [JsonPropertyName("em1:0")]
    private ShellyEM1ComponentStatus? _em10 = null;

    [JsonPropertyName("em1:1")]
    private ShellyEM1ComponentStatus? _em11 = null;

    [JsonPropertyName("em1:2")]
    private ShellyEM1ComponentStatus? _em12 = null;

    [JsonPropertyName("em1data:0")]
    private ShellyEM1DataComponentStatus? _em1Data0 = null;

    [JsonPropertyName("em1data:1")]
    private ShellyEM1DataComponentStatus? _em1Data1 = null;

    [JsonPropertyName("em1data:2")]
    private ShellyEM1DataComponentStatus? _em1Data2 = null;

    // pm1
    [JsonPropertyName("pm1:0")]
    private ShellyPM1ComponentStatus? _pm10 = null;

    // Maximum of 4 switches available in
    // https://shelly-api-docs.shelly.cloud/gen2/Devices/Gen2/ShellyPro4PM and
    // https://shelly-api-docs.shelly.cloud/gen2/Devices/Gen2/ShellyPlusI4
    public IReadOnlyList<ShellySwitchComponentStatus> Switches =>
        [.. new[] { _switch0, _switch1, _switch2, _switch3 }.OfType<ShellySwitchComponentStatus>()];

    // Maximum of 1 EM in
    // https://shelly-api-docs.shelly.cloud/gen2/Devices/Gen2/ShellyPro3EM
    public IReadOnlyList<ShellyEMComponentStatus> EM =>
        [.. new[] { _em0 }.OfType<ShellyEMComponentStatus>()];

    // Maximum of 1 EMData in
    // https://shelly-api-docs.shelly.cloud/gen2/Devices/Gen2/ShellyPro3EM
    public IReadOnlyList<ShellyEMDataComponentStatus> EMData =>
        [.. new[] { _emData0 }.OfType<ShellyEMDataComponentStatus>()];

    // Maximum of 3 EM1 in
    // https://shelly-api-docs.shelly.cloud/gen2/Devices/Gen2/ShellyPro3EM
    public IReadOnlyList<ShellyEM1ComponentStatus> EM1 =>
        [.. new[] { _em10, _em11, _em12 }.OfType<ShellyEM1ComponentStatus>()];

    // Maximum of 3 EM1Data in
    // https://shelly-api-docs.shelly.cloud/gen2/Devices/Gen2/ShellyPro3EM
    public IReadOnlyList<ShellyEM1DataComponentStatus> EM1Data =>
        [.. new[] { _em1Data0, _em1Data1, _em1Data2 }.OfType<ShellyEM1DataComponentStatus>()];

    // Maximum of 1 PM1 in
    // https://shelly-api-docs.shelly.cloud/gen2/Devices/Gen3/ShellyMiniPMG3
    public IReadOnlyList<ShellyPM1ComponentStatus> PM1 =>
        [.. new[] { _pm10 }.OfType<ShellyPM1ComponentStatus>()];
}
