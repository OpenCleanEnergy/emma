namespace Emma.Pipeline.Targets.Docker;

internal sealed class DockerTags
{
    private readonly string[] _tags;

    private DockerTags(string[] tags)
    {
        _tags = tags;
    }

    public static DockerTags FromBaseImage(string baseImage)
    {
        var version = ProjectVersion.FromProjectFile("./Directory.Build.props");
        var tags = GetVersionTags(version).Select(t => $"{baseImage}:{t}");
        return new DockerTags([.. tags]);
    }

    public string ToBuildArgs()
    {
        return string.Join(' ', _tags.Select(tag => $"--tag {tag}"));
    }

    public IEnumerator<string> GetEnumerator()
    {
        return _tags.AsEnumerable().GetEnumerator();
    }

    private static string[] GetVersionTags(ProjectVersion version)
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
