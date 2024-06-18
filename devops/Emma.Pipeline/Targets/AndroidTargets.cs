namespace Emma.Pipeline.Targets;

using Bullseye;
using Emma.Pipeline.Targets.Android;
using static SimpleExec.Command;

public static class AndroidTargets
{
    public const string Keystore = "android:keystore";
    public const string BuildNumber = "android:build-number";

    public const string Restore = "android:restore";
    public const string Analyze = "android:analyze";
    public const string Build = "android:build";
    public const string Clean = "android:clean";

    public static Targets AddAndroidTargets(this Targets targets)
    {
        const string workingDir = "./app";
        const string keystoreEnv = "KEYSTORE_FILE_BASE64";
        var keystoreFile = new FileInfo("/tmp/emma/key.jks");
        long buildNumber = 0;

        targets.Add(
            Keystore,
            $"Writes ${{{keystoreEnv}}} to {keystoreFile.FullName}.",
            () =>
            {
                keystoreFile.Directory!.Create();
                var base64 =
                    Environment.GetEnvironmentVariable(keystoreEnv)
                    ?? throw new KeyNotFoundException(
                        $"Environment variable {keystoreEnv} does not exists."
                    );
                var decoded = Convert.FromBase64String(base64);
                return File.WriteAllBytesAsync(keystoreFile.FullName, decoded);
            }
        );

        targets.Add(
            BuildNumber,
            "Get next build number.",
            () =>
            {
                buildNumber = GooglePlay
                    .FromEnvironmentVariable("SERVICE_ACCOUNT_JSON_BASE64")
                    .GetNextBuildNumber();
                Console.WriteLine($"Next builder number: {buildNumber}");
            }
        );

        targets.Add(
            Restore,
            "Restores pub.dev packages",
            () => Run("flutter", "pub get", workingDirectory: workingDir)
        );

        targets.Add(
            Analyze,
            "Analyze the project's Dart code.",
            dependsOn: [Restore],
            () => Run("flutter", "analyze", workingDirectory: workingDir)
        );

        targets.Add(
            Build,
            "Build an Android App Bundle file from your app.",
            dependsOn: [Keystore, BuildNumber, Analyze],
            () =>
            {
                var args = string.Join(
                    ' ',
                    "--release",
                    "--dart-define-from-file .env.production",
                    $"--build-number {buildNumber}"
                );

                Run("flutter", $"build appbundle {args}", workingDirectory: workingDir);
            }
        );

        targets.Add(
            Clean,
            "Clean up.",
            () =>
            {
                keystoreFile.Directory!.Refresh();
                if (keystoreFile.Directory!.Exists)
                {
                    keystoreFile.Directory!.Delete(recursive: true);
                }

                Run("flutter", "clean", workingDirectory: workingDir);
            }
        );

        return targets;
    }
}
