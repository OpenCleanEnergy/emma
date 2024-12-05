using Serilog.Sinks.OpenTelemetry;

namespace OpenEMS.Server.Logging;

public class OpenTelemetryConfiguration
{
    public OpenTelemetryConfiguration()
    {
        // From https://github.com/serilog/serilog-sinks-opentelemetry/blob/dev/src/Serilog.Sinks.OpenTelemetry/Sinks/OpenTelemetry/Configuration/OpenTelemetryEnvironment.cs
        var uriString = Environment.GetEnvironmentVariable("OTEL_EXPORTER_OTLP_ENDPOINT");
        Endpoint = Uri.TryCreate(uriString, UriKind.Absolute, out var uri) ? uri : null;

        var protocolString = Environment.GetEnvironmentVariable("OTEL_EXPORTER_OTLP_PROTOCOL");
        Protocol = protocolString switch
        {
            "http/protobuf" => OtlpProtocol.HttpProtobuf,
            "grpc" => OtlpProtocol.Grpc,
            _ => OtlpProtocol.Grpc,
        };
    }

    public Uri? Endpoint { get; init; }

    public OtlpProtocol Protocol { get; init; }
}
