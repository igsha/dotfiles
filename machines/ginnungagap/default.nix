{ config, lib, nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-hidpi
    nixos-hardware.nixosModules.common-pc

    ../../custom-args
    ../../fragments/boot
    ../../fragments/graphics
    ../../fragments/graphics/greetd
    ../../fragments/graphics/redshift
    ../../fragments/graphics/screenshot
    ../../fragments/graphics/window-manager/qtile
    ../../fragments/graphics/x11
    ../../fragments/graphics/x11/dunst
    ../../fragments/graphics/x11/lock
    ../../fragments/graphics/x11/picom
    ../../fragments/graphics/x11/sx
    ../../fragments/network
    ../../fragments/network/openvpn
    ../../fragments/network/openvpn/elvees2fa.nix
    ../../fragments/network/openvpn/miet.nix
    ../../fragments/network/openvpn/nto9.nix
    ../../fragments/network/tor
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/games
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
    ../../fragments/services/autosuspend
    ../../fragments/packages
    ../../fragments/packages/python-lab
    ../../fragments/programs
    ../../fragments/programs/bash
    ../../fragments/programs/git
    ../../fragments/programs/neovim
    ../../fragments/programs/tmux
    ../../fragments/programs/udevil
    ../../fragments/users
    ../../fragments/users/guest
    ../../home-config
  ];

  custom-args = {
    boot = {
      devdisk = "/dev/sda";
      tmpsize = "16G";
    };
    greetd.cmd = "sx";
    user = "igor";
  };

  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  fileSystems = {
    "/" = lib.mkForce { device = "/dev/sda3"; fsType = "ext4"; };
    "/home" = lib.mkForce { device = "/dev/sda4"; fsType = "ext4"; };
  };

  networking = {
    hostName = "ginnungagap";
    wireless.iwd.enable = true;
  };

  home-config.autostart = {
    packages = [ "autostart" ];
    dir = builtins.toString ./home-config;
  };
}
