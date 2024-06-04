namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Deploy;

public static class DeployTargets
{
    public const string Templates = "deploy:templates";

    public static Targets AddDeployTargets(this Targets targets)
    {
        targets.Add(
            Templates,
            "Substitutes environment variables in ./devops/templates/server/secrets.json",
            forEach: ["server/secrets.json", "keycloak/.env", "keycloak/realm.json"],
            (template) =>
                EnvSubst.Substitute(
                    new FileInfo($"./devops/templates/{template}"),
                    new FileInfo($"./devops/rendered/{template}")
                )
        );

        return targets;
    }
}
