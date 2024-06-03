namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Docker;
using static Bullseye.Targets;
using static SimpleExec.Command;

public static class DockerTargets
{
    public const string Tags = "docker:tags";
    public const string Pack = "docker:pack";
    public const string Publish = "docker:publish";

    public static Targets AddDockerTargets(this Targets targets)
    {
        var dockerRegistry = Environment.GetEnvironmentVariable("DOCKER_REGISTRY") ?? "ghcr.io";
        var dockerBaseImage = $"{dockerRegistry}/opencleanenergy/emma";

        targets.Add(
            Tags,
            "Prints the docker tags. The registry is read from $DOCKER_REGISTRY; defaults to 'ghcr.io'.",
            ForEach(dockerBaseImage),
            (baseImage) =>
            {
                foreach (var tag in DockerTags.GetTags(baseImage))
                {
                    Console.WriteLine($"🏷️ {tag}");
                }
            }
        );

        targets.Add(
            Pack,
            "Builds the docker image.",
            DependsOn(Tags),
            ForEach(dockerBaseImage),
            (baseImage) =>
            {
                var tags = DockerTags.GetTags(baseImage);
                var tagArgs = string.Join(" ", tags.Select(tag => $"--tag {tag}"));
                
                return RunAsync("docker", $"build --platform linux/amd64,linux/arm64 {tagArgs} .");
            }
        );

        targets.Add(
            Publish,
            "Pushes the docker image to the registry. The registry is read from $DOCKER_REGISTRY; defaults to 'ghcr.io'.",
            DependsOn(Pack),
            ForEach(DockerTags.GetTags(dockerBaseImage).ToArray()),
            (tag) => RunAsync("docker", $"push {tag}")
        );

        return targets;
    }
}
