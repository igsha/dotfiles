{ config, pkgs, ... }:

let
  user = "isharonov";

in {
  imports = [
    (import <home-manager> {}).nixos
    ../../home-config
    ../../fragments/boot
    (import ../../fragments/network "centimanus")
    ../../fragments/graphics/x11
    ../../fragments/graphics/x11/i3
    ../../fragments/graphics/x11/picom
    ../../fragments/graphics/x11/redshift
    ../../fragments/other
    ../../fragments/other/sound
    ../../fragments/other/fonts
    ../../fragments/other/virtualisation
    ../../fragments/services
    (import ../../fragments/services/jupyter user)
    ../../fragments/services/google-drive
    ../../fragments/services/random-background
    ../../fragments/packages
    ../../fragments/packages/neovim
    ../../fragments/programs
    ../../fragments/programs/git
    ../../fragments/programs/bash
    ../../fragments/programs/tmux
    (import ../../fragments/users user)
    ../../fragments/users/guest
  ];
}
