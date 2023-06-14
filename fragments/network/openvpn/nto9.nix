{ pkgs, ... }:

{
  services.openvpn.servers.nto9 = {
    config = "config /etc/vpn/nto9.ovpn";
    autoStart = false;
    updateResolvConf = false;
    up = pkgs.openvpn-systemd-resolved-up-script;
  };
}
