using Bullseye;
using Emma.Pipeline.Targets;

var targets = new Targets();

targets.AddBuildTargets();
targets.AddDockerTargets();
targets.AddKeycloakTargets();

await targets.RunAndExitAsync(args);
