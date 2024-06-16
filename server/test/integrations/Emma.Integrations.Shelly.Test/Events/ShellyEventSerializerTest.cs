using Emma.Integrations.Shelly.Events;

namespace Emma.Integrations.Shelly.Test.Events;

public class ShellyEventSerializerTest
{
    public static TheoryData<FileInfo> TestCases()
    {
        var data = new TheoryData<FileInfo>();
        var directory = new DirectoryInfo(Path.Combine(nameof(Events), "messages"));
        var files = directory.EnumerateFiles("*.json");

        foreach (var file in files)
        {
            data.Add(file);
        }

        return data;
    }

    [Theory]
    [MemberData(nameof(TestCases))]
    public async Task Deserialize_Message(FileInfo file)
    {
        // Arrange
        var raw = await File.ReadAllTextAsync(file.FullName);
        var serializer = new ShellyEventSerializer();

        // Act
        var result = serializer.Deserialize(raw);

        // Assert
        await Verify(result).UseTextForParameters(Path.GetFileNameWithoutExtension(file.Name));
    }
}
