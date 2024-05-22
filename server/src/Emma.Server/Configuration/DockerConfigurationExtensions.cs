namespace Emma.Server.Configuration;

public static class DockerConfigurationExtensions
{
    public static IConfigurationBuilder AddDockerSecretsJson(
        this IConfigurationBuilder configurationBuilder
    )
    {
        return configurationBuilder.AddJsonFile("/run/secrets/secrets.json", optional: true);
    }
}
