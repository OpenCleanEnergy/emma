using System.Text.RegularExpressions;

namespace Emma.Pipeline.Targets.Deploy;

public static partial class EnvSubst
{
    public static void Substitute(FileInfo source, FileInfo target)
    {
        var replacements = new List<Replacement>();
        var regex = EnvironmentVariableRegex();

        var sourceContent = File.ReadAllText(source.FullName);
        var targetContent = regex.Replace(
            sourceContent,
            match => ReplaceEnvironmentVariable(match, replacements)
        );

        LogAndOrThrowOnFailure(source, target, replacements);

        target.Directory?.Create();
        File.WriteAllText(target.FullName, targetContent);
    }

    private static string ReplaceEnvironmentVariable(Match match, List<Replacement> replacements)
    {
        // ${ENV_VAR} => ENV_VAR
        var environmentVariable = match.Value[2..^1];
        var value = Environment.GetEnvironmentVariable(environmentVariable);
        replacements.Add(new Replacement(environmentVariable, value));
        return value ?? string.Empty;
    }

    private static void LogAndOrThrowOnFailure(
        FileInfo source,
        FileInfo target,
        List<Replacement> replacements
    )
    {
        Console.WriteLine($"[{nameof(EnvSubst)}] {source.FullName} => {target.FullName}");
        var columnWidth = replacements
            .Select(r => r.EnvironmentVariable.Length)
            .DefaultIfEmpty(1)
            .Max();

        var ordered = replacements.OrderBy(r => r.Value is null).ThenBy(r => r.EnvironmentVariable);

        var missingVariables = new List<string>();

        foreach (var (envVar, value) in ordered)
        {
            Console.WriteLine(
                $"[{nameof(EnvSubst)}] {envVar.PadRight(columnWidth)} => {value ?? @"¯\_(ツ)_/¯"}"
            );

            if (value is null)
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

    [GeneratedRegex(@"\${[a-zA-Z0-9_]+}", RegexOptions.None, 100)]
    private static partial Regex EnvironmentVariableRegex();

    private sealed record Replacement(string EnvironmentVariable, string? Value);
}
