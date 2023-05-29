{ pkgs, ... }:

{
  services.openvpn.servers.elvees = {
    config = "config /etc/vpn/nto9.conf";
    autoStart = false;
    updateResolvConf = false;
    up = pkgs.openvpn-systemd-resolved-up-script;
  };
}
