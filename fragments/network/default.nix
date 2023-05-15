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
    tor = {
      enable = true;
      client = {
        enable = true;
        dns.enable = false;
      };
      settings = {
        FascistFirewall = true;
      };
    };
  };

  systemd.suppressedSystemUnits = [
    "systemd-ask-password-wall.path"
    "systemd-ask-password-wall.service"
  ];

  nixpkgs.overlays = [
    (self: super: {
      openvpn-systemd-resolved-up-script = ''
        for var in ''${!foreign_option_*}; do
          x=(''${!var})
          if [ "''${x[0]}" = dhcp-option ]; then
            if [ "''${x[1]}" = DOMAIN ]; then domains+=" ''${x[2]}"
            elif [ "''${x[1]}" = DNS ]; then nameservers+=" ''${x[2]}"
            fi
          fi
        done

        ${super.systemd}/bin/resolvectl dns $dev ''${nameservers[@]}
        ${super.systemd}/bin/resolvectl domain $dev ''${domains[@]}
      '';
    })
  ];
}
