{ config, lib, nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-hidpi
    nixos-hardware.nixosModules.common-pc

    ../../custom-args
    ../../encrypted
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
    ../../fragments/network/openvpn/miet.nix
    ../../fragments/network/tor
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/games
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
    ../../fragments/services/autosuspend
    ../../fragments/services/offlineimap
    ../../fragments/packages
    ../../fragments/packages/python-lab
    ../../fragments/packages/yt-dlp-with-plugins
    ../../fragments/programs
    ../../fragments/programs/bash
    ../../fragments/programs/davmail
    ../../fragments/programs/git
    ../../fragments/programs/gnupg
    ../../fragments/programs/neovim
    ../../fragments/programs/tmux
    ../../fragments/programs/udevil
    ../../fragments/users
    ../../fragments/users/guest
  ];

  custom-args = {
    boot = {
      devdisk = "/dev/sda";
      tmpsize = "16G";
    };
    greetd.cmd = "sx";
    user = "isharonov";
  };

  boot.extraModulePackages = [ config.boot.kernelPackages.rtl88x2bu ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  networking = {
    hostName = "ginnungagap";
    wireless.iwd.enable = true;
  };

  home-config.autostart = {
    packages = [ "autostart" ];
    dir = builtins.toString ./home-config;
  };
}
