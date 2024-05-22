using System;
using Nuke.Common.Tooling;

namespace Emma.Build;

/// <summary>
/// <see cref="Nuke.Common.Tools.Docker.DockerTasks"/> logs information as <see cref="OutputType.Err"/>
/// and errors as <see cref="OutputType.Std"/>.
/// See: /// https://github.com/nuke-build/nuke/issues/1201
/// </summary>
public static class DockerTasksLoggerWorkaround
{
    public static void Log(OutputType outputType, string output)
    {
        switch (outputType)
        {
            case OutputType.Std:
                Serilog.Log.Error(output);
                break;
            case OutputType.Err:
                Serilog.Log.Information(output);
                break;
            default:
                throw new NotImplementedException(
                    $"{nameof(OutputType)} {outputType} is not implemented"
                );
        }
    }
}
