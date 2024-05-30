using Bullseye;
using Emma.Pipeline.Targets;

var targets = new Targets();

targets.AddBuildTargets();
targets.AddDockerTargets();
targets.AddKeycloakTargets();
targets.AddDeployTargets();

await targets.RunAndExitAsync(args);
