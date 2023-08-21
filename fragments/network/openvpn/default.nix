_:

{
  services.openvpn.restartAfterSleep = false;

  programs.openvpn3.enable = true;

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
