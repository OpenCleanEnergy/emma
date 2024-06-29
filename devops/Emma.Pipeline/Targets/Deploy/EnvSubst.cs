using System.Text.RegularExpressions;

namespace Emma.Pipeline.Targets.Deploy;

public static partial class TemplateSubst
{
    public static void PrintRequiredVariables(FileInfo source, DirectoryInfo keyPerFileDir)
    {
        var regex = VariableRegex();
        var sourceContent = File.ReadAllText(source.FullName);
        var matches = regex.Matches(sourceContent);
        var variables = matches.Select(GetVariableName).Distinct().Order();
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
        var regex = VariableRegex();

        var sourceContent = File.ReadAllText(source.FullName);
        var targetContent = regex
            .Replace(sourceContent, match => ReplaceVariable(match, keyPerFileDir, replacements))
            .ReplaceLineEndings();

        LogAndOrThrowOnFailure(source, target, replacements);

        target.Directory?.Create();
        File.WriteAllText(target.FullName, targetContent);
    }

    private static string ReplaceVariable(
        Match match,
        DirectoryInfo keyPerFileDir,
        List<Replacement> replacements
    )
    {
        var variable = GetVariableName(match);

        var value = Environment.GetEnvironmentVariable(variable);

        var file = Path.Combine(keyPerFileDir.FullName, variable);
        if (value is null && File.Exists(file))
        {
            value = File.ReadAllLines(file).FirstOrDefault();
        }

        replacements.Add(new Replacement(variable, value is not null));
        return value ?? string.Empty;
    }

    // {{A_VAR}} or {{ A_VAR }} => A_VAR
    private static string GetVariableName(Match match) => match.Value.Trim('{', '}', ' ');

    private static void LogAndOrThrowOnFailure(
        FileInfo source,
        FileInfo target,
        List<Replacement> replacements
    )
    {
        Console.WriteLine($"[{nameof(TemplateSubst)}] {source.FullName} => {target.FullName}");

        var ordered = replacements.OrderBy(r => r.Success).ThenBy(r => r.Variable);

        var missingVariables = new List<string>();

        foreach (var (variable, success) in ordered)
        {
            Console.WriteLine($"[{nameof(TemplateSubst)}] {(success ? "✅" : "❌")} {variable}");

            if (!success)
            {
                missingVariables.Add(variable);
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
    private static partial Regex VariableRegex();

    private sealed record Replacement(string Variable, bool Success);
}
