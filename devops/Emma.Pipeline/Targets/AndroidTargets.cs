namespace Emma.Pipeline.Targets;

using Bullseye;
using static SimpleExec.Command;

public static class AndroidTargets
{
    public const string Keystore = "android:keystore";

    public const string Restore = "android:restore";
    public const string Analyze = "android:analyze";
    public const string Build = "android:build";
    public const string Clean = "android:clean";

    public static Targets AddAndroidTargets(this Targets targets)
    {
        const string workingDir = "./app";
        const string keystoreEnv = "KEYSTORE_FILE_BASE64";
        var keystoreFile = new FileInfo("/tmp/emma/key.jks");

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
            dependsOn: [Keystore, Analyze],
            () =>
            {
                Run(
                    "flutter",
                    $"build appbundle --release --dart-define-from-file .env.production",
                    workingDirectory: workingDir
                );
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
