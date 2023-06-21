{ config, lib, ... }:

{
  imports = [
    ../../custom-args
    ../../home-config
    ../../fragments/boot
    ../../fragments/network
    ../../fragments/network/openvpn
    ../../fragments/network/openvpn/elvees2fa.nix
    ../../fragments/network/openvpn/miet.nix
    ../../fragments/network/tor
    ../../fragments/graphics
    ../../fragments/graphics/greetd
    ../../fragments/graphics/drivers/amd
    ../../fragments/graphics/redshift
    ../../fragments/graphics/wayland
    ../../fragments/graphics/wayland/sway
    ../../fragments/graphics/wayland/waybar
    ../../fragments/graphics/wayland/swayidle
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
    ../../fragments/services/jupyter
    ../../fragments/services/google-drive
    ../../fragments/packages
    ../../fragments/programs
    ../../fragments/programs/git
    ../../fragments/programs/bash
    ../../fragments/programs/tmux
    ../../fragments/programs/neovim
    ../../fragments/users
    ../../fragments/users/guest
  ];

  custom-args = {
    boot = {
      devdisk = "/dev/sda";
      tmpsize = "16G";
    };
    greetd.cmd = "sway";
    user = "igor";
  };

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
