using System.Text;
using Google.Apis.AndroidPublisher.v3;
using Google.Apis.AndroidPublisher.v3.Data;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;

namespace Emma.Pipeline.Targets.Android;

public class GooglePlay
{
    public const string PackageName = "org.opence.emma";
    private readonly AndroidPublisherService _service;

    public GooglePlay(AndroidPublisherService service)
    {
        _service = service;
    }

    public static GooglePlay FromEnvironmentVariable(string environmentVariable)
    {
        var base64 =
            Environment.GetEnvironmentVariable(environmentVariable)
            ?? throw new ArgumentException(
                $"Environment variable {environmentVariable} is not set"
            );

        var json = Encoding.UTF8.GetString(Convert.FromBase64String(base64));
        var credential = GoogleCredential
            .FromJson(json)
            .CreateScoped(AndroidPublisherService.Scope.Androidpublisher);

        var service = new AndroidPublisherService(
            new BaseClientService.Initializer() { HttpClientInitializer = credential }
        );

        return new GooglePlay(service);
    }

    public long GetNextBuildNumber()
    {
        return GetLastBuildNumber() + 1;
    }

    public long GetLastBuildNumber()
    {
        var edit = _service.Edits.Insert(new AppEdit(), PackageName).Execute();
        var tracks = _service.Edits.Tracks.List(PackageName, edit.Id).Execute();

        long max = 0;
        foreach (var track in tracks.Tracks)
        {
            Console.WriteLine($"Track: {track.TrackValue}");

            foreach (var release in track.Releases ?? [])
            {
                Console.WriteLine($"  - Release: {release.Name} ({release.Status})");

                foreach (var versionCode in release.VersionCodes ?? [])
                {
                    Console.WriteLine($"    - Version Code: {versionCode}");
                    if (versionCode > max)
                    {
                        max = versionCode.GetValueOrDefault(0);
                    }
                }
            }
        }

        _service.Edits.Delete(PackageName, edit.Id).Execute();

        return max;
    }
}
