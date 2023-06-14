{ pkgs, ... }:

{
  services.openvpn.servers.elvees2fa = {
    config = "config /etc/vpn/elvees2fa.ovpn";
    autoStart = false;
    updateResolvConf = false;
    up = pkgs.openvpn-systemd-resolved-up-script;
  };
}
