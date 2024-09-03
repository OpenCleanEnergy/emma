using Bullseye;
using OpenEMS.Pipeline.Targets;

var targets = new Targets();

targets.AddBuildTargets();
targets.AddDockerTargets();

targets.AddAppTargets();

targets.AddKeycloakTargets();

targets.AddDeployTargets();

await targets.RunAndExitAsync(args);
