{ config, lib, pkgs, ... }:

{
  imports = [
    ../../home-config
    ../../fragments/boot
    ../../fragments/network
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
    "/tmp" = lib.mkForce {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "nosuid" "nodev" "relatime" "size=16G"];
    };
  };

  networking = {
    hostName = "ginnungagap";
    wireless.iwd.enable = true;
  };

  services = {
    openvpn.servers = {
      elvees = {
        config = "config /home/igor/.vpn/elvees2fa.conf";
        autoStart = false;
        updateResolvConf = false;
        up = pkgs.openvpn-systemd-resolved-up-script;
      };
      miet = {
        config = "config /home/igor/.vpn/miet.conf";
        autoStart = false;
        updateResolvConf = false;
      };
    };
  };

  virtualisation.waydroid.enable = true;
}
