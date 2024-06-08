namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Docker;
using static SimpleExec.Command;

public static class KeycloakTargets
{
    public const string Tags = "keycloak:tags";
    public const string Build = "keycloak:build";
    public const string Publish = "keycloak:publish";

    public static Targets AddKeycloakTargets(this Targets targets)
    {
        var workingDir = new DirectoryInfo("./keycloak");
        var dockerBaseImage = $"opence/keycloak";
        var tags = DockerTags.FromBaseImage(dockerBaseImage, workingDir);

        targets.Add(
            Tags,
            "Prints the docker tags.",
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
