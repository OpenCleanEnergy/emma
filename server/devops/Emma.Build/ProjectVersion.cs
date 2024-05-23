using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.Text.RegularExpressions;

namespace Emma.Build;

internal sealed partial class ProjectVersion
{
    public int Major { get; private set; }
    public int Minor { get; private set; }
    public int Patch { get; private set; }

    [MemberNotNullWhen(true, nameof(PrereleaseType), nameof(PrereleaseVersion))]
    public bool IsPrerelease => !string.IsNullOrEmpty(PrereleaseType) && PrereleaseVersion.HasValue;
    public string? PrereleaseType { get; private set; }
    public int? PrereleaseVersion { get; private set; }

    public static ProjectVersion FromProjectFile(string path)
    {
        var project = File.ReadAllText(path);
        var match = VersionRegex().Match(project);
        return Parse(match.Value);
    }

    public static ProjectVersion Parse(string input)
    {
        var versionAndPrerelease = input.Split('-');

        var version = new ProjectVersion();
        var majorMinorPatch = versionAndPrerelease[0].Split('.');
        version.Major = ParseInt(majorMinorPatch[0]);
        version.Minor = ParseInt(majorMinorPatch[1]);
        version.Patch = ParseInt(majorMinorPatch[2]);

        if (versionAndPrerelease.Length == 2)
        {
            var typeAndVersion = versionAndPrerelease[1].Split('.');
            version.PrereleaseType = typeAndVersion[0];
            version.PrereleaseVersion = ParseInt(typeAndVersion[1]);
        }

        return version;
    }

    public IEnumerable<string> GetVersionTags()
    {
        if (IsPrerelease)
        {
            return
            [
                $"{Major}.{Minor}.{Patch}-{PrereleaseType}",
                $"{Major}.{Minor}.{Patch}-{PrereleaseType}.{PrereleaseVersion}",
            ];
        }
        else
        {
            return [$"{Major}", $"{Major}.{Minor}", $"{Major}.{Minor}.{Patch}",];
        }
    }

    private static int ParseInt(string input) => int.Parse(input, CultureInfo.InvariantCulture);

    [GeneratedRegex(@"(?<=<Version>).+(?=<\/Version>)")]
    private static partial Regex VersionRegex();
}
