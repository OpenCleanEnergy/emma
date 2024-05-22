using System;
using Emma.Build;
using NuGet.Versioning;
using Nuke.Common;
using Nuke.Common.ProjectModel;
using Nuke.Common.Tooling;
using Nuke.Common.Tools.Docker;
using Nuke.Common.Tools.DotNet;
using Serilog;

class Build : NukeBuild
{
    [Solution(GenerateProjects = true)]
    readonly Solution Solution;

    [Parameter("Configuration to build - Default is 'Debug' (local) or 'Release' (server)")]
    readonly Configuration Configuration = IsLocalBuild
        ? Configuration.Debug
        : Configuration.Release;

    [Parameter("Docker registry to push the image to - Default is 'ghcr.io'")]
    readonly string Registry = "ghcr.io";

    [Parameter("The image name - Default is 'OpenCleanEnergy/emma'")]
    readonly string Image = "OpenCleanEnergy/emma";

    public Target Clean =>
        _ =>
            _.Before(Restore)
                .Executes(() =>
                {
                    DotNetTasks.DotNetClean();
                });

    public Target Restore =>
        _ =>
            _.Executes(() =>
            {
                DotNetTasks.DotNetRestore();
            });

    public Target Compile =>
        _ =>
            _.DependsOn(Restore)
                .Executes(() =>
                {
                    DotNetTasks.DotNetBuild(_ =>
                        _.SetConfiguration(Configuration).EnableNoRestore()
                    );
                });

    public Target DockerBuild =>
        _ =>
            _.Executes(() =>
            {
                var tags = GetImageTags();
                DockerTasks.DockerBuild(_ =>
                    _.SetPath(".").SetTag(tags).SetProcessLogger(DockerTasksLoggerWorkaround.Log)
                );
            });

    public Target DockerPush =>
        _ =>
            _.DependsOn(DockerBuild)
                .Executes(() =>
                {
                    var tags = GetImageTags();
                    foreach (var tag in tags)
                    {
                        DockerTasks.DockerPush(_ =>
                            _.SetName(tag).SetProcessLogger(DockerTasksLoggerWorkaround.Log)
                        );
                    }
                });
    public Target Publish =>
        _ => _.DependsOn(DockerPush).Executes(() => Log.Information("🎉 Published"));

    public static int Main() => Execute<Build>(x => x.Compile);

    private string[] GetImageTags()
    {
        var project = Solution.src.Emma_Server;
        var version = SemanticVersion.Parse(
            project.GetProperty("Version")
                ?? throw new ArgumentException("Project does not have a version.")
        );

        if (version.IsPrerelease)
        {
            return [$"{Registry}/{Image}:{version}"];
        }

        return
        [
            $"{Registry}/{Image}:latest",
            $"{Registry}/{Image}:{version.Major}",
            $"{Registry}/{Image}:{version.Major}.{version.Minor}",
            $"{Registry}/{Image}:{version.Major}.{version.Minor}.{version.Patch}",
        ];
    }
}
