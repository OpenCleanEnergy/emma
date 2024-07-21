using Pulumi;
using Pulumi.CloudAmqp;
using Pulumi.HCloud;
using Pulumi.HCloud.Inputs;
using Pulumiverse.Time;

namespace OpenEMS.DevOps;

public class DefaultStack : Stack
{
    private static readonly InputList<string> _sourceIps = new[] { "0.0.0.0/0", "::/0" };

    public DefaultStack()
    {
        var stack = Deployment.Instance.StackName;

        var config = new Pulumi.Config();

        var outputDir = new DirectoryInfo(config.Require("output-dir"));

        var sshEnabled = config.RequireBoolean("ssh-enabled");
        var dataCenter = config.Require("data-center");

        var publicKey = config.Require("public-key");
        var privateKeyBase64 = config.RequireSecret("private-key-base64");

        var sshKey = new SshKey(
            $"{stack}-ssh-key",
            new SshKeyArgs() { Name = $"{stack}-ssh-key", PublicKey = publicKey }
        );
        var ipv4 = new PrimaryIp(
            $"{stack}-ipv4",
            new()
            {
                Name = $"{stack} IP v4",
                Datacenter = dataCenter,
                Type = "ipv4",
                AssigneeType = "server",
                AutoDelete = false,
            }
        );

        var ipv6 = new PrimaryIp(
            $"{stack}-ipv6",
            new()
            {
                Name = $"{stack} IP v6",
                Datacenter = dataCenter,
                Type = "ipv6",
                AssigneeType = "server",
                AutoDelete = false,
            }
        );

        var firewallRules = new List<FirewallRuleArgs>
        {
            new()
            {
                Direction = "in",
                Protocol = "icmp",
                SourceIps = _sourceIps,
            },
            new()
            {
                Direction = "in",
                Protocol = "tcp",
                Port = "80",
                SourceIps = _sourceIps,
            },
            new()
            {
                Direction = "in",
                Protocol = "tcp",
                Port = "443",
                SourceIps = _sourceIps,
            }
        };

        if (sshEnabled)
        {
            firewallRules.Add(
                new()
                {
                    Direction = "in",
                    Protocol = "tcp",
                    Port = "22",
                    SourceIps = _sourceIps
                }
            );
        }

        var firewall = new Firewall(
            $"{stack}-firewall",
            new() { Name = $"{stack}-firewall", Rules = firewallRules }
        );

        var server = new Server(
            $"{stack}-server",
            new()
            {
                Name = $"{stack}-server",
                Datacenter = dataCenter,
                Image = "fedora-40",
                ServerType = "cax21",
                PublicNets = new[]
                {
                    new ServerPublicNetArgs
                    {
                        Ipv4 = ipv4.Id.Apply(int.Parse),
                        Ipv6 = ipv6.Id.Apply(int.Parse),
                    }
                },
                SshKeys = new[] { sshKey.Id },
                FirewallIds = new[] { firewall.Id.Apply(int.Parse) },
                Backups = true,
                UserData = CloudConfig.Render(publicKey),
            }
        );

        _ = new Sleep(
            "Wait for server to boot",
            new() { CreateDuration = "60s" },
            new() { DependsOn = [server] }
        );

        var cloudAmqpInstance = new Instance(
            $"{stack}-amqp",
            new()
            {
                Name = $"{stack}-amqp",
                Plan = "lemming",
                Region = "azure-arm::westeurope",
                Tags = { stack, "emma" }
            }
        );

        AmqpInstance = cloudAmqpInstance.Id;
        ServerId = server.Id;
        Ipv4 = ipv4.IpAddress;
        Ipv6 = ipv6.IpAddress;
        SshEnabled = Output.Create(sshEnabled);

        ApplyOutput(
            outputDir: outputDir,
            ipv4: ipv4,
            privateKeyBase64: privateKeyBase64,
            cloudAmqpInstance: cloudAmqpInstance
        );
    }

    [Output("server-id")]
    public Output<string> ServerId { get; init; }

    [Output("ip-v4")]
    public Output<string> Ipv4 { get; init; }

    [Output("ip-v6")]
    public Output<string> Ipv6 { get; init; }

    [Output("ssh-enabled")]
    public Output<bool> SshEnabled { get; init; }

    [Output("amqp-instance")]
    public Output<string> AmqpInstance { get; init; }

    private static void ApplyOutput(
        DirectoryInfo outputDir,
        PrimaryIp ipv4,
        Output<string> privateKeyBase64,
        Instance cloudAmqpInstance
    )
    {
        outputDir.Create();

        var ansibleDir = new DirectoryInfo(Path.Combine(outputDir.FullName, "ansible"));
        ansibleDir.Create();

        var privateKeyFile = new FileInfo(Path.Combine(ansibleDir.FullName, "private-ssh-key"));
        privateKeyBase64.Apply(async base64 =>
        {
            var bytes = Convert.FromBase64String(base64);
            await File.WriteAllBytesAsync(privateKeyFile.FullName, bytes);

            if (OperatingSystem.IsLinux())
            {
                // owner read/write -> 600
                File.SetUnixFileMode(
                    privateKeyFile.FullName,
                    UnixFileMode.UserRead | UnixFileMode.UserWrite
                );
            }
        });

        ipv4.IpAddress.Apply(ipAddress =>
            File.WriteAllTextAsync(
                Path.Combine(ansibleDir.FullName, "inventory.ini"),
                $"""
                {ipAddress} ansible_ssh_private_key_file={privateKeyFile.FullName}
                """
            )
        );

        cloudAmqpInstance.Url.Apply(url =>
            File.WriteAllTextAsync(Path.Combine(outputDir.FullName, "Events__RabbitMQ__Url"), url)
        );
    }
}
