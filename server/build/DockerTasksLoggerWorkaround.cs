using System;
using Nuke.Common.Tooling;

namespace Emma.Build;

/// <summary>
/// <see cref="Nuke.Common.Tools.Docker.DockerTasks"/> logs information as <see cref="OutputType.Err"/>
/// and errors as <see cref="OutputType.Std"/>.
/// See: /// https://github.com/nuke-build/nuke/issues/1201
/// </summary>
public static class DockerTasksLogger
{

    public static void Log(OutputType outputType, string output)
    {
        _ = outputType;

        if (output.StartsWith("ERROR", StringComparison.OrdinalIgnoreCase))
        {
            Serilog.Log.Error(output);
        }
        else if (output.StartsWith("WARNING", StringComparison.OrdinalIgnoreCase))
        {
            Serilog.Log.Warning(output);
        }
        else
        {
            Serilog.Log.Debug(output);
        }
    }

