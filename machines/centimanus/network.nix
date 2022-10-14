{ pkgs, ... }:

{
  imports = [ ../../fragments/network ];

  networking = {
    hostName = "centimanus";
    nameservers = [ "82.179.190.64" "82.179.191.64" ];
    interfaces = {
      enp3s0 = {
        wakeOnLan.enable = true;
        ipv4 = {
          addresses = [
            { address = "82.179.182.138"; prefixLength = 27; }
          ];
          routes = [
            { address = "82.179.182.128"; prefixLength = 27; via = "82.179.182.129"; }
            { address = "0.0.0.0"; prefixLength = 0; via = "82.179.182.129"; }
          ];
        };
        useDHCP = false;
      };
      enp6s0 = {
        ipv4 = {
          addresses = [ { address = "83.179.182.146"; prefixLength = 27; } ];
          routes = [
            { address = "83.179.182.128"; prefixLength = 27; via = "83.179.182.146"; }
          ];
        };
        useDHCP = false;
      };
    };
  };

  services = {
    openvpn.servers = let
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
      elvees = {
        config = "config /home/isharonov/.vpn/elvees2fa.conf";
        autoStart = false;
        updateResolvConf = false;
        up = up-script;
      };
      nto9 = {
        config = "config /home/isharonov/.vpn/nto9.ovpn";
        autoStart = false;
        updateResolvConf = false;
        up = up-script;
      };
    };
  };
}
