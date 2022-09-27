{ config, pkgs, ... }:

let
  user = "isharonov";

in {
  imports = [
    ../../home-config
    ../../fragments/boot
    ./network.nix
    ../../fragments/graphics/x11
    ../../fragments/graphics/x11/i3
    ../../fragments/graphics/x11/i3blocks
    ../../fragments/graphics/x11/dunst
    ../../fragments/graphics/x11/lock
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
    ../../fragments/programs
    ../../fragments/programs/git
    ../../fragments/programs/bash
    ../../fragments/programs/tmux
    ../../fragments/programs/neovim
    (import ../../fragments/users user)
    ../../fragments/users/guest
  ];
}
