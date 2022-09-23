_:

{
  networking = {
    resolvconf.extraOptions = [ "rotate" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 8080 8888 4200 8554 1935 ];
    };
  };

  services = {
    openssh = {
      enable = true;
      forwardX11 = true;
      extraConfig = ''
        AllowTcpForwarding yes
        TCPKeepAlive yes
        PermitTunnel yes
      '';
    };
    tor = {
      enable = true;
      client = {
        enable = true;
        dns.enable = false;
      };
    };
  };
}
