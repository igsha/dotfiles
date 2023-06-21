_:

{
  networking = {
    resolvconf.extraOptions = [ "rotate" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 554 4200 5900 8080 8888 4200 8554 ];
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
  };

  systemd.suppressedSystemUnits = [
    "systemd-ask-password-wall.path"
    "systemd-ask-password-wall.service"
  ];
}
