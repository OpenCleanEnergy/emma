using Emma.Build;
using static Bullseye.Targets;
using static Emma.Build.TargetNames;
using static SimpleExec.Command;

var dockerRegistry = Environment.GetEnvironmentVariable("DOCKER_REGISTRY") ?? "ghcr.io";
var dockerBaseImage = $"{dockerRegistry}/opencleanenergy/emma";

Target(
    Restore,
    "Restores .NET dependencies. ",
    () => RunAsync("dotnet", "restore --nologo --verbosity quiet")
);
Target(
    Build,
    "Builds the solution. If $CI == true then Configuration is 'Release' else 'Debug'.",
    DependsOn(Restore),
    () =>
    {
        var ci = bool.Parse(Environment.GetEnvironmentVariable("CI") ?? "false");
        var configuration = ci ? "Release" : "Debug";
        return RunAsync(
            "dotnet",
            $"build --no-restore --configuration {configuration} --nologo --verbosity quiet"
        );
    }
);

Target(
    Tags,
    "Prints the docker tags. The registry is read from $DOCKER_REGISTRY; defaults to 'ghcr.io'.",
    ForEach(dockerBaseImage),
    (baseImage) =>
    {
        foreach (var tag in DockerTags.GetTags(baseImage))
        {
            Console.WriteLine(tag);
        }
    }
);

Target(
    Pack,
    "Builds the docker image.",
    DependsOn(Tags),
    ForEach(dockerBaseImage),
    (baseImage) =>
    {
        var tags = DockerTags.GetTags(baseImage);
        var tagArgs = string.Join(" ", tags.Select(tag => $"--tag {tag}"));
        return RunAsync("docker", $"build {tagArgs} .");
    }
);

Target(
    Publish,
    "Pushes the docker image to the registry. The registry is read from $DOCKER_REGISTRY; defaults to 'ghcr.io'.",
    DependsOn(Pack),
    ForEach(DockerTags.GetTags(dockerBaseImage).ToArray()),
    (tag) => RunAsync("docker", $"push --quiet {tag}")
);

Target("default", $"The default target -> {Build}", DependsOn(Build));

await RunTargetsAndExitAsync(args);
