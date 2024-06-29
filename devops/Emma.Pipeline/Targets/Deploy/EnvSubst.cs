using System.Text.RegularExpressions;

namespace Emma.Pipeline.Targets.Deploy;

public static partial class EnvSubst
{
    public static void PrintRequiredEnvironmentVariables(
        FileInfo source,
        DirectoryInfo keyPerFileDir
    )
    {
        var regex = EnvironmentVariableRegex();
        var sourceContent = File.ReadAllText(source.FullName);
        var matches = regex.Matches(sourceContent);
        var variables = matches.Select(GetEnvironmentVariableName).Distinct().Order();
        foreach (var variable in variables)
        {
            var exists =
                Environment.GetEnvironmentVariable(variable) is not null
                || File.Exists(Path.Combine(keyPerFileDir.FullName, variable));
            var icon = exists ? "✅" : "❌";
            Console.WriteLine($"{icon} {variable}");
        }
    }

    public static void Substitute(FileInfo source, FileInfo target, DirectoryInfo keyPerFileDir)
    {
        var replacements = new List<Replacement>();
        var regex = EnvironmentVariableRegex();

        var sourceContent = File.ReadAllText(source.FullName);
        var targetContent = regex
            .Replace(
                sourceContent,
                match => ReplaceEnvironmentVariable(match, keyPerFileDir, replacements)
            )
            .ReplaceLineEndings();

        LogAndOrThrowOnFailure(source, target, replacements);

        target.Directory?.Create();
        File.WriteAllText(target.FullName, targetContent);
    }

    private static string ReplaceEnvironmentVariable(
        Match match,
        DirectoryInfo keyPerFileDir,
        List<Replacement> replacements
    )
    {
        var environmentVariable = GetEnvironmentVariableName(match);

        var value = Environment.GetEnvironmentVariable(environmentVariable);

        var file = Path.Combine(keyPerFileDir.FullName, environmentVariable);
        if (value is null && File.Exists(file))
        {
            value = File.ReadAllLines(file).FirstOrDefault();
        }

        replacements.Add(new Replacement(environmentVariable, value is not null));
        return value ?? string.Empty;
    }

    // {{ENV_VAR}} or {{ ENV_VAR }} => ENV_VAR
    private static string GetEnvironmentVariableName(Match match) =>
        match.Value.Trim('{', '}', ' ');

    private static void LogAndOrThrowOnFailure(
        FileInfo source,
        FileInfo target,
        List<Replacement> replacements
    )
    {
        Console.WriteLine($"[{nameof(EnvSubst)}] {source.FullName} => {target.FullName}");

        var ordered = replacements.OrderBy(r => r.Success).ThenBy(r => r.EnvironmentVariable);

        var missingVariables = new List<string>();

        foreach (var (envVar, success) in ordered)
        {
            Console.WriteLine($"[{nameof(EnvSubst)}] {(success ? "✅" : "❌")} {envVar}");

            if (!success)
            {
                missingVariables.Add(envVar);
            }
        }

        if (missingVariables.Count != 0)
        {
            throw new KeyNotFoundException(
                $"Environment variable(s) {string.Join(", ", missingVariables)} are missing."
            );
        }
    }

    [GeneratedRegex(@"{{ *[a-zA-Z0-9_]+ *}}", RegexOptions.None, 100)]
    private static partial Regex EnvironmentVariableRegex();

    private sealed record Replacement(string EnvironmentVariable, bool Success);
}
