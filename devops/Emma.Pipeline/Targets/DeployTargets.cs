namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Deploy;
using static SimpleExec.Command;

public static class DeployTargets
{
    public const string DebugTemplates = "deploy:templates-debug";
    public const string Templates = "deploy:templates";
    public const string PostClean = "deploy:post-clean";

    public const string PulumiSelectStack = "deploy:pulumi-select";
    public const string PulumiUp = "deploy:pulumi-up";
    public const string PulumiSecure = "deploy:pulumi-secure";
    public const string PulumiDown = "deploy:pulumi-down";

    public const string Ansible = "deploy:ansible";

    public const string Up = "deploy:up";
    public const string Down = "deploy:down";

    public static Targets AddDeployTargets(this Targets targets)
    {
        var tempDir = new DirectoryInfo("/tmp/emma");
        var templateDir = new DirectoryInfo("./devops/templates");
        var ansibleDir = new DirectoryInfo(Path.Combine(tempDir.FullName, "ansible"));
        var renderedDir = new DirectoryInfo(Path.Combine(ansibleDir.FullName, "rendered"));

        var templates = templateDir
            .GetFiles("*", SearchOption.AllDirectories)
            .Select(f => Path.GetRelativePath(templateDir.FullName, f.FullName));

        targets.Add(
            DebugTemplates,
            $"Prints all required variables. Uses {tempDir}/{{variable}} as lookup.",
            forEach: templates,
            (template) =>
                TemplateSubst.PrintRequiredVariables(
                    new FileInfo(Path.Combine(templateDir.FullName, template)),
                    tempDir
                )
        );

        targets.Add(
            PostClean,
            $"Clears the {tempDir} directory.",
            () =>
            {
                tempDir.Refresh();
                if (tempDir.Exists)
                {
                    tempDir.Delete(recursive: true);
                }
            }
        );

        targets.Add(
            Templates,
            $"Substitutes template variables in {templateDir}/*. Uses {tempDir}/{{variable}} as lookup.",
            forEach: templates,
            (template) =>
                TemplateSubst.Substitute(
                    new FileInfo(Path.Combine(templateDir.FullName, template)),
                    new FileInfo(Path.Combine(renderedDir.FullName, template)),
                    tempDir
                )
        );

        var pulumiWorkingDir = "./devops/Emma.DevOps";

        targets.Add(
            PulumiSelectStack,
            "Selects the pulumi stack.",
            () => RunAsync("pulumi", "stack select production", workingDirectory: pulumiWorkingDir)
        );

        targets.Add(
            PulumiUp,
            "Executes pulumi up with SSH enabled.",
            dependsOn: [PulumiSelectStack],
            () =>
                RunAsync(
                    "pulumi",
                    "up --yes --emoji --config emma:ssh-enabled=true",
                    workingDirectory: pulumiWorkingDir
                )
        );

        targets.Add(
            PulumiSecure,
            "Executes pulumi up with SSH disabled.",
            dependsOn: [PulumiSelectStack],
            () =>
                RunAsync(
                    "pulumi",
                    "up --yes --emoji --config emma:ssh-enabled=false",
                    workingDirectory: pulumiWorkingDir
                )
        );

        targets.Add(
            PulumiDown,
            "Executes pulumi down",
            dependsOn: [PulumiSelectStack],
            () => RunAsync("pulumi", "down --yes --emoji", workingDirectory: pulumiWorkingDir)
        );

        var ansibleWorkingDir = "./devops/ansible";

        targets.Add(
            Ansible,
            "Executes Ansible Playbook",
            dependsOn: [Templates, PulumiUp],
            () =>
            {
                var args = string.Join(
                    ' ',
                    "--user devops",
                    $"--inventory {Path.Combine(ansibleDir.FullName, "inventory.ini")}",
                    "--diff",
                    "-vv",
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

        targets.Add(
            Up,
            "🚀 UP",
            dependsOn: [Templates, PulumiUp, Ansible, PulumiSecure, PostClean]
        );
        targets.Add(Down, "🔨 DOWN", dependsOn: [PulumiDown, PostClean]);

        return targets;
    }
}
