using Bullseye;
using Emma.Pipeline.Targets;
using static Bullseye.Targets;

var targets = new Targets();

targets.AddBuildTargets();
targets.AddDockerTargets();

Target("default", $"The default target -> {BuildTargets.Build}", DependsOn(BuildTargets.Build));

await targets.RunAndExitAsync(args);
