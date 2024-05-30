namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Deploy;

public static class DeployTargets
{
    public const string ServerSecrets = "deploy:server-secrets";

    public static Targets AddDeployTargets(this Targets targets)
    {
        targets.Add(
            ServerSecrets,
            "Substitutes environment variables in ./devops/templates/server/secrets.json",
            () =>
                EnvSubst.Substitute(
                    new FileInfo("./devops/templates/server/secrets.json"),
                    new FileInfo("./devops/rendered/server/secrets.json")
                )
        );

        return targets;
    }
}
