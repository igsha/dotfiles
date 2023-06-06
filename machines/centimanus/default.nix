{ config, lib, pkgs, ... }:

{
  imports = [
    ../../home-config
    (import ../../fragments/boot)
    ../../fragments/network
    ../../fragments/network/openvpn
    ../../fragments/network/openvpn/elvees.nix
    ../../fragments/network/openvpn/nto9.nix
    ../../fragments/graphics
    ../../fragments/graphics/drivers/nvidia-legacy
    ../../fragments/graphics/window-manager/qtile
    ../../fragments/graphics/sddm
    ../../fragments/graphics/x11
    ../../fragments/graphics/x11/dunst
    ../../fragments/graphics/x11/lock
    ../../fragments/graphics/x11/picom
    ../../fragments/graphics/x11/redshift
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
    (import ../../fragments/services/jupyter "isharonov")
    ../../fragments/services/google-drive
    ../../fragments/services/random-background
    ../../fragments/packages
    ../../fragments/programs
    ../../fragments/programs/git
    ../../fragments/programs/bash
    ../../fragments/programs/tmux
    ../../fragments/programs/neovim
    (import ../../fragments/users "isharonov")
    ../../fragments/users/guest
  ];

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
}
