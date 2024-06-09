namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Deploy;
using static SimpleExec.Command;

public static class DeployTargets
{
    public const string PrintEnvironmentVariables = "deploy:print-env";
    public const string Clean = "deploy:clean";
    public const string Templates = "deploy:templates";

    public const string SelectStack = "deploy:pulumi-select";
    public const string Up = "deploy:pulumi-up";
    public const string Down = "deploy:pulumi-down";
    public const string Secure = "deploy:pulumi-secure";

    public const string Ansible = "deploy:ansible";

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
            Clean,
            $"Clears the {renderedDir}",
            () =>
            {
                if (renderedDir.Exists)
                {
                    renderedDir.Delete(recursive: true);
                }
            }
        );

        targets.Add(
            Templates,
            $"Substitutes environment variables in {templateDir}/*",
            dependsOn: [PrintEnvironmentVariables, Clean],
            forEach: templates,
            (template) =>
                EnvSubst.Substitute(
                    new FileInfo(Path.Combine(templateDir.FullName, template)),
                    new FileInfo(Path.Combine(renderedDir.FullName, template))
                )
        );

        var pulumiWorkingDir = "./devops/Emma.DevOps";

        targets.Add(
            SelectStack,
            "Selects the pulumi stack.",
            () => RunAsync("pulumi", "stack select production", workingDirectory: pulumiWorkingDir)
        );

        targets.Add(
            Up,
            "Executes pulumi up with SSH enabled.",
            dependsOn: [SelectStack],
            () =>
                RunAsync(
                    "pulumi",
                    "up --yes --emoji --config emma:ssh-enabled=true",
                    workingDirectory: pulumiWorkingDir
                )
        );

        targets.Add(
            Secure,
            "Executes pulumi up with SSH disabled.",
            dependsOn: [SelectStack],
            () =>
                RunAsync(
                    "pulumi",
                    "up --yes --emoji --config emma:ssh-enabled=false",
                    workingDirectory: pulumiWorkingDir
                )
        );

        targets.Add(
            Down,
            "Executes pulumi down",
            dependsOn: [SelectStack],
            () => RunAsync("pulumi", "down --yes --emoji", workingDirectory: pulumiWorkingDir)
        );

        var ansibleWorkingDir = "./devops/ansible";
        targets.Add(
            Ansible,
            "Executes Ansible Playbook",
            dependsOn: [Templates, Up],
            () =>
            {
                var args = string.Join(
                    ' ',
                    "--user devops",
                    "--inventory inventory.ini",
                    "--private-key ~/.ssh/hcloud-production",
                    "--diff",
                    "play.yaml"
                );

                return RunAsync(
                    "ansible-playbook",
                    args,
                    ansibleWorkingDir,
                    configureEnvironment: (env) => env.Add("ANSIBLE_HOST_KEY_CHECKING", "False")
                );
            }
        );

        return targets;
    }
}
