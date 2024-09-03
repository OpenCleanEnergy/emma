namespace OpenEMS.Pipeline.Targets;

using Bullseye;
using OpenEMS.Pipeline.Targets.Docker;
using static SimpleExec.Command;

public static class AppTargets
{
    public const string Tags = "app:tags";
    public const string BuildApp = "app:build-app";
    public const string BuildImage = "app:build-image";
    public const string Publish = "app:publish";

    public static Targets AddAppTargets(this Targets targets)
    {
        var workingDir = new DirectoryInfo("./app");
        var dockerRegistry = Environment.GetEnvironmentVariable("DOCKER_REGISTRY") ?? "ghcr.io";
        var dockerBaseImage = $"{dockerRegistry}/opencleanenergy/openems-web-app";
        var tags = DockerTags.FromBaseImage(dockerBaseImage, workingDir);

        // Builds the flutter web app
        targets.Add(
            BuildApp,
            "Builds the flutter web app.",
            () =>
                Run(
                    "flutter",
                    "build web --base-href \"/app/\" --dart-define-from-file .env.production",
                    workingDirectory: workingDir.FullName
                )
        );

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
            BuildImage,
            "Builds the docker image.",
            dependsOn: [BuildApp, Tags],
            () =>
                Run(
                    "docker",
                    $"build {tags.ToBuildArgs()} .",
                    workingDirectory: workingDir.FullName
                )
        );

        targets.Add(
            Publish,
            "Uses buildx to build and push a multi-platform image.",
            dependsOn: [BuildApp, Tags],
            () =>
                Run(
                    "docker",
                    $"buildx build --push --platform linux/amd64,linux/arm64 {tags.ToBuildArgs()} .",
                    workingDirectory: workingDir.FullName
                )
        );

        return targets;
    }
}
