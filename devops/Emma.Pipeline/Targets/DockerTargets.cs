namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Docker;
using static SimpleExec.Command;

public static class DockerTargets
{
    public const string Tags = "docker:tags";
    public const string Build = "docker:build";
    public const string Publish = "docker:publish";

    public static Targets AddDockerTargets(this Targets targets)
    {
        var workingDir = new DirectoryInfo("./server");
        var dockerRegistry = Environment.GetEnvironmentVariable("DOCKER_REGISTRY") ?? "ghcr.io";
        var dockerBaseImage = $"{dockerRegistry}/opencleanenergy/emma";
        var tags = DockerTags.FromBaseImage(dockerBaseImage, workingDir);

        targets.Add(
            Tags,
            "Prints the docker tags. The registry is read from $DOCKER_REGISTRY; defaults to 'ghcr.io'.",
            () =>
            {
                foreach (var tag in tags)
                {
                    Console.WriteLine($"🏷️  {tag}");
                }
            }
        );

        targets.Add(
            Build,
            "Builds the docker image.",
            dependsOn: [Tags],
            () =>
            {
                return RunAsync(
                    "docker",
                    $"build {tags.ToBuildArgs()} .",
                    workingDirectory: workingDir.FullName
                );
            }
        );

        targets.Add(
            Publish,
            "Uses buildx to build and push a multi-platform image.",
            dependsOn: [Tags],
            () =>
            {
                return RunAsync(
                    "docker",
                    $"buildx build --push --platform linux/amd64,linux/arm64 {tags.ToBuildArgs()} .",
                    workingDirectory: workingDir.FullName
                );
            }
        );

        return targets;
    }
}
