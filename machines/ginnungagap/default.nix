{ config, lib, pkgs, ... }:

{
  imports = [
    ../../home-config
    (import ../../fragments/boot { tmpsize = "16G"; })
    ../../fragments/network
    ../../fragments/network/openvpn
    ../../fragments/network/openvpn/elvees.nix
    ../../fragments/network/openvpn/miet.nix
    ../../fragments/graphics
    (import ../../fragments/graphics/greetd "sway")
    ../../fragments/graphics/drivers/amd
    ../../fragments/graphics/wayland
    ../../fragments/graphics/wayland/sway
    ../../fragments/graphics/wayland/waybar
    ../../fragments/graphics/wayland/gammastep
    ../../fragments/graphics/wayland/swayidle
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
    (import ../../fragments/services/jupyter "igor")
    ../../fragments/services/google-drive
    ../../fragments/packages
    ../../fragments/programs
    ../../fragments/programs/git
    ../../fragments/programs/bash
    ../../fragments/programs/tmux
    ../../fragments/programs/neovim
    (import ../../fragments/users "igor")
    ../../fragments/users/guest
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];

  fileSystems = {
    "/" = lib.mkForce { device = "/dev/sda3"; fsType = "ext4"; };
    "/home" = lib.mkForce { device = "/dev/sda4"; fsType = "ext4"; };
  };

  networking = {
    hostName = "ginnungagap";
    wireless.iwd.enable = true;
  };

  virtualisation.waydroid.enable = true;
}
