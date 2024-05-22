using System.Reflection;

namespace Emma.Server;

public static class EntryAssembly
{
    public const string Swagger = "dotnet-swagger";
    public const string EF = "ef";
    public const string Default = "default";

    public static string GetEntryAssembly()
    {
        return Assembly.GetEntryAssembly()?.GetName().Name switch
        {
            Swagger => Swagger,
            EF => EF,
            _ => Default
        };
    }
}
