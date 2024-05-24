using Pulumi;

namespace Emma.DevOps;

public static class CloudConfig
{
    public static Output<string> Render(Input<string> publicKey)
    {
        return Output.Format(
            $"""
            #cloud-config
            # from https://community.hetzner.com/tutorials/basic-cloud-config
            users:
              - name: devops
                groups: users, admin, docker
                sudo: ALL=(ALL) NOPASSWD:ALL
                shell: /bin/bash
                ssh_authorized_keys:
                  - {publicKey}
            package_update: true
            package_upgrade: true
            packages:
              - fail2ban
            runcmd:
              - printf "[sshd]\nenabled = true\nbanaction = iptables-multiport" > /etc/fail2ban/jail.local
              - systemctl enable fail2ban
              - ufw allow OpenSSH
              - ufw enable
              - sed -i -e '/^\(#\|\)PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config
              - sed -i -e '/^\(#\|\)PasswordAuthentication/s/^.*$/PasswordAuthentication no/' /etc/ssh/sshd_config
              - sed -i -e '/^\(#\|\)KbdInteractiveAuthentication/s/^.*$/KbdInteractiveAuthentication no/' /etc/ssh/sshd_config
              - sed -i -e '/^\(#\|\)MaxAuthTries/s/^.*$/MaxAuthTries 2/' /etc/ssh/sshd_config
              - sed -i -e '/^\(#\|\)AllowTcpForwarding/s/^.*$/AllowTcpForwarding no/' /etc/ssh/sshd_config
              - sed -i -e '/^\(#\|\)X11Forwarding/s/^.*$/X11Forwarding no/' /etc/ssh/sshd_config
              - sed -i -e '/^\(#\|\)AllowAgentForwarding/s/^.*$/AllowAgentForwarding no/' /etc/ssh/sshd_config
              - sed -i -e '/^\(#\|\)AuthorizedKeysFile/s/^.*$/AuthorizedKeysFile .ssh\/authorized_keys/' /etc/ssh/sshd_config
              - sed -i '$a AllowUsers devops' /etc/ssh/sshd_config
              - reboot
            """
        );
    }
}
