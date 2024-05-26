namespace Emma.Pipeline.Targets.Docker;

internal static class DockerTags
{
    public static IEnumerable<string> GetTags(string baseImage)
    {
        var version = ProjectVersion.FromProjectFile("./Directory.Build.props");
        return GetVersionTags(version).Select(t => $"{baseImage}:{t}");
    }

    private static IEnumerable<string> GetVersionTags(ProjectVersion version)
    {
        if (version.IsPrerelease)
        {
            return
            [
                $"{version.Major}.{version.Minor}.{version.Patch}-{version.PrereleaseType}",
                $"{version.Major}.{version.Minor}.{version.Patch}-{version.PrereleaseType}.{version.PrereleaseVersion}",
            ];
        }
        else
        {
            return
            [
                $"{version.Major}",
                $"{version.Major}.{version.Minor}",
                $"{version.Major}.{version.Minor}.{version.Patch}",
            ];
        }
    }
}
