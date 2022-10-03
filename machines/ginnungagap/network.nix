{ pkgs, ... }:

let
  up-script = ''
    for var in ''${!foreign_option_*}; do
      x=(''${!var})
      if [ "''${x[0]}" = dhcp-option ]; then
        if [ "''${x[1]}" = DOMAIN ]; then domains+=" ''${x[2]}"
        elif [ "''${x[1]}" = DNS ]; then nameservers+=" ''${x[2]}"
        fi
      fi
    done

    ${pkgs.systemd}/bin/resolvectl dns $dev ''${nameservers[@]}
    ${pkgs.systemd}/bin/resolvectl domain $dev ''${domains[@]}
  '';

in {
  imports = [ ../../fragments/network ];

  networking = {
    hostName = "ginnungagap";
    wireless.iwd.enable = true;
  };

  services = {
    openvpn.servers = {
      elvees = {
        config = "config /home/igor/.vpn/elvees2fa.conf";
        autoStart = false;
        updateResolvConf = false;
        up = up-script;
      };
      miet = {
        config = "config /home/igor/.vpn/miet.conf";
        autoStart = false;
        updateResolvConf = false;
      };
    };
  };
}
