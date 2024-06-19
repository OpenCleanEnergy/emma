namespace Emma.Pipeline.Targets.Docker;

internal sealed class DockerTags
{
    private readonly string[] _tags;

    private DockerTags(string[] tags)
    {
        _tags = tags;
    }

    public static DockerTags FromBaseImage(string baseImage, DirectoryInfo workingDir)
    {
        var version = ProjectVersion.FromDirectory(workingDir);
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

    private static IEnumerable<string> GetVersionTags(ProjectVersion version)
    {
        if (version.IsPrerelease)
        {
            yield return $"{version.Major}.{version.Minor}.{version.Patch}-{version.PrereleaseType}";
            yield return $"{version.Major}.{version.Minor}.{version.Patch}-{version.PrereleaseType}.{version.PrereleaseVersion}";
        }
        else
        {
            yield return $"{version.Major}";
            yield return $"{version.Major}.{version.Minor}";
            yield return $"{version.Major}.{version.Minor}.{version.Patch}";
        }

        yield return "latest";
    }
}
