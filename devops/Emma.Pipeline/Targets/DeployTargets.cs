namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Deploy;

public static class DeployTargets
{
    public const string PrintEnvironmentVariables = "deploy:print-env";
    public const string Templates = "deploy:templates";

    public static Targets AddDeployTargets(this Targets targets)
    {
        var templateDir = new DirectoryInfo("./devops/templates");
        var renderedDir = new DirectoryInfo("./devops/rendered");

        var templates = templateDir
            .GetFiles("*", SearchOption.AllDirectories)
            .Select(f => Path.GetRelativePath(templateDir.FullName, f.FullName));

        targets.Add(
            PrintEnvironmentVariables,
            "Prints all required environment variables",
            forEach: templates,
            (template) =>
                EnvSubst.PrintRequiredEnvironmentVariables(
                    new FileInfo(Path.Combine(templateDir.FullName, template))
                )
        );

        targets.Add(
            Templates,
            $"Substitutes environment variables in {templateDir}/*",
            dependsOn: [PrintEnvironmentVariables],
            forEach: templates,
            (template) =>
                EnvSubst.Substitute(
                    new FileInfo(Path.Combine(templateDir.FullName, template)),
                    new FileInfo(Path.Combine(renderedDir.FullName, template))
                )
        );

        return targets;
    }
}
