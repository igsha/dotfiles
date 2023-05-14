{ config, lib, ... }:

{
  imports = [
    ../../home-config
    ../../fragments/boot
    ./network.nix
    ../../fragments/graphics
    (import ../../fragments/graphics/greetd "sx")
    ../../fragments/graphics/drivers/nvidia
    ../../fragments/graphics/x11
    ../../fragments/graphics/x11/i3
    ../../fragments/graphics/x11/i3blocks
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

  systemd.services.openvpn-elvees.serviceConfig.Restart = lib.mkForce "no";
  systemd.suppressedSystemUnits = [
    "systemd-ask-password-wall.path"
    "systemd-ask-password-wall.service"
  ];
}
