namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Docker;
using static Bullseye.Targets;
using static SimpleExec.Command;

public static class DockerTargets
{
    public const string Tags = "docker:tags";
    public const string Build = "docker:build";
    public const string Publish = "docker:publish";

    public static Targets AddDockerTargets(this Targets targets)
    {
        var dockerRegistry = Environment.GetEnvironmentVariable("DOCKER_REGISTRY") ?? "ghcr.io";
        var dockerBaseImage = $"{dockerRegistry}/opencleanenergy/emma";

        targets.Add(
            Tags,
            "Prints the docker tags. The registry is read from $DOCKER_REGISTRY; defaults to 'ghcr.io'.",
            () =>
            {
                foreach (var tag in DockerTags.GetTags(dockerBaseImage))
                {
                    Console.WriteLine($"🏷️ {tag}");
                }
            }
        );

        targets.Add(
            Build,
            "Builds the docker image.",
            dependsOn: [Tags],
            () =>
            {
                var tags = DockerTags.GetTags(dockerBaseImage);
                var tagArgs = string.Join(" ", tags.Select(tag => $"--tag {tag}"));
                return RunAsync("docker", $"build {tagArgs} .");
            }
        );

        targets.Add(
            Publish,
            "Uses buildx to build and publish a multi-platform image.",
            dependsOn: [Build],
            () =>
            {
                var tags = DockerTags.GetTags(dockerBaseImage);
                var tagArgs = string.Join(" ", tags.Select(tag => $"--tag {tag}"));
                return RunAsync(
                    "docker",
                    $"buildx build --platform linux/amd64,linux/arm64 {tagArgs}"
                );
            }
        );

        return targets;
    }
}
