using System.Text.Json;
using Emma.Integrations.Shelly.Events;
using FluentAssertions;

namespace Emma.Integrations.Shelly.Test.Events;

public class ShellyEventSerializerTest
{
    public static TheoryData<string> TestCases()
    {
        var data = new TheoryData<string>();
        var directory = new DirectoryInfo(Path.Combine(nameof(Events), "messages"));
        var files = directory.EnumerateFiles("*.json");

        foreach (var file in files)
        {
            data.Add(file.FullName);
        }

        return data;
    }

    [Theory]
    [MemberData(nameof(TestCases))]
    public async Task Deserialize_Message(string file)
    {
        // Arrange
        var fileInfo = new FileInfo(file);
        var raw = await File.ReadAllTextAsync(file);
        var serializer = new ShellyEventSerializer();

        // Act
        var result = serializer.Deserialize(raw);

        // Assert
        await Verify(result).UseTextForParameters(Path.GetFileNameWithoutExtension(fileInfo.Name));
    }

    [Theory]
    [MemberData(nameof(TestCases))]
    public async Task Serialize_And_Deserialize_Result_In_Same_Result(string file)
    {
        // Arrange
        var raw = await File.ReadAllTextAsync(file);
        var serializer = new ShellyEventSerializer();
        var original = serializer.Deserialize(raw);

        // Act
        var json = JsonSerializer.Serialize(original, original!.GetType());
        var result = JsonSerializer.Deserialize(json, original!.GetType());

        // Assert
        original.Should().BeEquivalentTo(result, opts => opts.RespectingRuntimeTypes());
    }
}
