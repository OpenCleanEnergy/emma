using System.Reflection;

namespace OpenEMS.Server;

public readonly record struct EntryAssembly
{
    private EntryAssembly(string name) => Name = name;

    public string Name { get; }

    public static EntryAssembly Swagger { get; } = new("dotnet-swagger");
    public static EntryAssembly EF { get; } = new("ef");
    public static EntryAssembly Default { get; } = new("default");

    public static EntryAssembly GetEntryAssembly()
    {
        var name = Assembly.GetEntryAssembly()?.GetName().Name;
        if (name == Swagger.Name)
        {
            return Swagger;
        }
        else if (name == EF.Name)
        {
            return EF;
        }
        else
        {
            return Default;
        }
    }
}
