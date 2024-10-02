using System.Reflection;
using Vogen;

namespace OpenEMS.Server;

[ValueObject<string>]
[Instance("Swagger", "dotnet-swagger")]
[Instance("EF", "ef")]
[Instance("Default", "default")]
public readonly partial record struct EntryAssembly
{
    public static EntryAssembly GetEntryAssembly()
    {
        var name = Assembly.GetEntryAssembly()?.GetName().Name;
        Console.WriteLine(name);
        if (name == Swagger.Value)
        {
            return Swagger;
        }
        else if (name == EF.Value)
        {
            return EF;
        }
        else
        {
            return Default;
        }
    }

    private static Validation Validate(string input)
    {
        _ = input;
        return Validation.Invalid("Only available instances are allowed.");
    }
}
