using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace Emma.Pipeline.Targets.Docker;

internal sealed partial class ProjectVersion
{
    private static readonly JsonSerializerOptions _serializerOptions =
        new(JsonSerializerDefaults.Web);

    public int Major { get; private set; }
    public int Minor { get; private set; }
    public int Patch { get; private set; }

    [MemberNotNullWhen(true, nameof(PrereleaseType), nameof(PrereleaseVersion))]
    public bool IsPrerelease => !string.IsNullOrEmpty(PrereleaseType) && PrereleaseVersion.HasValue;
    public string? PrereleaseType { get; private set; }
    public int? PrereleaseVersion { get; private set; }

    public static ProjectVersion FromNodePackage(FileInfo packageJson)
    {
        var json = File.ReadAllText(packageJson.FullName);
        var nodePackage = JsonSerializer.Deserialize<NodePackage>(json, _serializerOptions)!;
        return Parse(nodePackage.Version);
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

    private static int ParseInt(string input) => int.Parse(input, CultureInfo.InvariantCulture);

    [GeneratedRegex(@"(?<=<Version>).+(?=<\/Version>)")]
    private static partial Regex VersionRegex();
}
