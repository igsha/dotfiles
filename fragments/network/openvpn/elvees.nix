{ pkgs, ... }:

{
  services.openvpn.servers.elvees = {
    config = "config /etc/vpn/elvees2fa.ovpn";
    autoStart = false;
    updateResolvConf = false;
    up = pkgs.openvpn-systemd-resolved-up-script;
  };
}
