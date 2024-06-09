using Pulumi;
using Pulumi.Command.Local;
using Pulumi.HCloud;
using Pulumi.HCloud.Inputs;

namespace Emma.DevOps;

public class DefaultStack : Stack
{
    private static readonly InputList<string> _sourceIps = new[] { "0.0.0.0/0", "::/0" };

    public DefaultStack()
    {
        var stack = Deployment.Instance.StackName;

        var config = new Pulumi.Config();
        var sshEnabled = config.RequireBoolean("ssh-enabled");
        var dataCenter = config.Require("data-center");

        var publicKey = config.Require("public-key");

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

        _ = new Command(
            "Ansible inventory",
            new()
            {
                Create = "echo ${IPV4} > '../ansible/inventory.ini'",
                Environment = new() { { "IPV4", ipv4.IpAddress } },
                AssetPaths = ["../ansible/inventory.ini"]
            }
        );

        ServerId = server.Id;
        Ipv4 = ipv4.IpAddress;
        Ipv6 = ipv6.IpAddress;
        SshEnabled = Output.Create(sshEnabled);
    }

    [Output("server-id")]
    public Output<string> ServerId { get; init; }

    [Output("ip-v4")]
    public Output<string> Ipv4 { get; init; }

    [Output("ip-v6")]
    public Output<string> Ipv6 { get; init; }

    [Output("ssh-enabled")]
    public Output<bool> SshEnabled { get; init; }
}
