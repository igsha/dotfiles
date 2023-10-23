{ config, lib, ... }:

{
  imports = [
    <nixos-hardware/common/cpu/intel/cpu-only.nix>
    <nixos-hardware/common/gpu/amd>
    <nixos-hardware/common/hidpi.nix>
    <nixos-hardware/common/pc>

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
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
    ../../fragments/services/autosuspend
    ../../fragments/services/google-drive
    ../../fragments/services/jupyter
    ../../fragments/packages
    ../../fragments/programs
    ../../fragments/programs/bash
    ../../fragments/programs/git
    ../../fragments/programs/neovim
    ../../fragments/programs/tmux
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
  hardware.amdgpu.amdvlk = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  fileSystems = {
    "/" = lib.mkForce { device = "/dev/sda3"; fsType = "ext4"; };
    "/home" = lib.mkForce { device = "/dev/sda4"; fsType = "ext4"; };
  };

  networking = {
    hostName = "ginnungagap";
    wireless.iwd.enable = true;
  };

  virtualisation.waydroid.enable = true;

  home-config.autostart = {
    packages = [ "autostart" ];
    dir = builtins.toString ./home-config;
  };
}
