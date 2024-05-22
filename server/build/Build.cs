using System;
using System.Collections.Generic;
using System.Linq;
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

    [Parameter("The image name - Default is 'opencleanenergy/emma'")]
    readonly string Image = "opencleanenergy/emma";

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

    public Target DockerTags =>
        _ =>
            _.Executes(() =>
            {
                var tags = GetImageTags();
                foreach (var tag in tags)
                {
                    Log.Debug("Tag: {tag}", tag);
                }
            });

    public Target DockerBuild =>
        _ =>
            _.DependsOn(DockerTags)
                .Executes(() =>
                {
                    var tags = GetImageTags();
                    DockerTasks.DockerBuild(_ =>
                        _.SetPath(".").SetTag(tags).SetProcessLogger(DockerTasksLogger.Log)
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
                            _.SetName(tag).SetProcessLogger(DockerTasksLogger.Log)
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
            var versions = new List<string>()
            {
                $"{Registry}/{Image}:{version.Major}.{version.Minor}.{version.Patch}-{version.ReleaseLabels.First()}"
            };

            foreach (var releaseLabel in version.ReleaseLabels.Skip(1))
            {
                versions.Add($"{versions[^1]}.{releaseLabel}");
            }

            return [.. versions];
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
