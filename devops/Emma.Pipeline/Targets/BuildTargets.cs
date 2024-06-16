namespace Emma.Pipeline.Targets;

using Bullseye;
using static SimpleExec.Command;

public static class BuildTargets
{
    public const string Restore = "build:restore";
    public const string Build = "build:build";
    public const string Test = "build:test";

    public static Targets AddBuildTargets(this Targets targets)
    {
        const string workingDir = "./server";

        targets.Add(
            Restore,
            "Restores .NET dependencies. ",
            () =>
                RunAsync(
                    "dotnet",
                    "restore --nologo --verbosity quiet",
                    workingDirectory: workingDir
                )
        );

        targets.Add(
            Build,
            "Builds the solution. If $CI == true then Configuration is 'Release' else 'Debug'.",
            dependsOn: [Restore],
            () =>
            {
                var ci = bool.Parse(Environment.GetEnvironmentVariable("CI") ?? "false");
                var configuration = ci ? "Release" : "Debug";
                return RunAsync(
                    "dotnet",
                    $"build --no-restore --configuration {configuration} --nologo --verbosity quiet",
                    workingDirectory: workingDir
                );
            }
        );

        targets.Add(
            Test,
            "Runs all tests.",
            dependsOn: [Build],
            () =>
                RunAsync(
                    "dotnet",
                    "test --no-build --logger GitHubActions --nologo",
                    workingDirectory: workingDir
                )
        );

        return targets;
    }
}
