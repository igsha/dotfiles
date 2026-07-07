{ pkgs, ... }:

{
  networking = {
    resolvconf.extraOptions = [ "rotate" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 554 3128 4200 5900 5901 8080 8888 8554 ];
      # ros2 multicast
      extraCommands = ''
        iptables -A nixos-fw -p udp -d 224.0.0.0/4 -j nixos-fw-accept
        iptables -A nixos-fw -p udp -s 224.0.0.0/4 -j nixos-fw-accept
      '';
    };
    enableIPv6 = false;
  };

  services = {
    resolved.enable = true;
    openssh = {
      enable = true;
      extraConfig = ''
        AllowTcpForwarding yes
        TCPKeepAlive yes
        PermitTunnel yes
      '';
    };
  };

  systemd.suppressedSystemUnits = [
    "systemd-ask-password-wall.path"
    "systemd-ask-password-wall.service"
  ];

  programs = {
    tcpdump.enable = true;
    wireshark = {
      enable = true;
      dumpcap.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    nixos-firewall-tool
    wireshark
  ];
}
