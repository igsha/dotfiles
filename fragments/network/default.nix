{ pkgs, ... }:

{
  networking = {
    resolvconf.extraOptions = [ "rotate" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 554 3128 4200 5900 5901 8080 8888 8554 4043 ];
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
    termshark
    wireshark
  ];

  security.pki.certificateFiles = [
    (builtins.fetchurl {
      url = "https://gu-st.ru/content/downloads/Russian_Trusted_Root_CA.cer";
      sha256 = sha256:0135zid0166n0rwymb38kd5zrd117nfcs6pqq2y2brg8lvz46slk;
    })
    (builtins.fetchurl {
      url = "https://gu-st.ru/content/downloads/Russian_Trusted_Sub_CA.cer";
      sha256 = sha256:19jffjrawgbpdlivdvpzy7kcqbyl115rixs86vpjjkvp6sgmibph;
    })
    (builtins.fetchurl {
      url = "https://gu-st.ru/content/downloads/Russian_Trusted_Sub_CA_2024.cer";
      sha256 = sha256:0ghrqkm86zngv4zvbdymqm4jhrw8hy6na91nrr7l84k7isf857bg;
    })
  ];
}
