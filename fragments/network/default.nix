{ pkgs, ... }:

{
  networking = {
    resolvconf.extraOptions = [ "rotate" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 554 3128 4200 5900 5901 8080 8888 8554 ];
    };
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
    avahi.enable = true;
  };

  systemd.suppressedSystemUnits = [
    "systemd-ask-password-wall.path"
    "systemd-ask-password-wall.service"
  ];

  security.pki.certificateFiles = [
    (builtins.fetchurl {
      url = "https://gu-st.ru/content/lending/russian_trusted_root_ca_pem.crt";
      sha256 = sha256:0135zid0166n0rwymb38kd5zrd117nfcs6pqq2y2brg8lvz46slk;
    })
    (builtins.fetchurl {
      url = "https://gu-st.ru/content/lending/russian_trusted_sub_ca_pem.crt";
      sha256 = sha256:19jffjrawgbpdlivdvpzy7kcqbyl115rixs86vpjjkvp6sgmibph;
    })
  ];

  environment.systemPackages = with pkgs; [
    arp-scan
    wget links2 httpie
    mtr nethogs ngrep nmap bind iftop wireshark-cli tcpdump
    samba cifs-utils
  ];
}
