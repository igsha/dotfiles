{ pkgs, ... }:

let
  miet-ovpn = pkgs.fetchurl {
    url = https://vpn.miet.ru/miet.ovpn;
    hash = "sha256-TGmM9P9wsbQ6u1ZP9DdFI/svcCPUvHhd++IvrJ4fuNw=";
  };

in {
  services.openvpn.servers.miet = {
    config = "config ${miet-ovpn}";
    autoStart = false;
    updateResolvConf = false;
  };
}
