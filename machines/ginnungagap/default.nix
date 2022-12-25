{ config, lib, ... }:

{
  imports = [
    ../../home-config
    ../../fragments/boot
    ./network.nix
    ../../fragments/graphics/wayland
    ../../fragments/graphics/wayland/sway
    ../../fragments/graphics/wayland/waybar
    ../../fragments/graphics/wayland/gammastep
    ../../fragments/graphics/wayland/swayidle
    ../../fragments/other
    ../../fragments/other/sound
    ../../fragments/other/fonts
    ../../fragments/other/virtualisation
    ../../fragments/services
    ../../fragments/services/jupyterhub
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
    "/tmp" = lib.mkForce {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "nosuid" "nodev" "relatime" "size=16G"];
    };
  };

  swapDevices = lib.mkForce [ { device = "/dev/sda2"; } ];

  virtualisation.waydroid.enable = true;
}
