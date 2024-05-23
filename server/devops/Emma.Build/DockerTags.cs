namespace Emma.Build;

internal static class DockerTags
{
    public static IEnumerable<string> GetTags(string baseImage)
    {
        var version = ProjectVersion.FromProjectFile("./Directory.Build.props");
        return version.GetVersionTags().Select(t => $"{baseImage}:{t}");
    }
}
