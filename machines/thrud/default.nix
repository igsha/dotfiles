{ config, lib, pkgs, ... }:

{
  imports = [
    ../../home-config
    (import ../../fragments/boot { devdisk = "/dev/nvme0n1p"; tmpsize = "16G"; })
    ../../fragments/network
    ../../fragments/network/openvpn
    ../../fragments/network/openvpn/elvees2fa.nix
    ../../fragments/network/openvpn/miet.nix
    ../../fragments/network/openvpn/nto9.nix
    ../../fragments/network/tor
    ../../fragments/graphics/drivers/nvidia-prime
    ../../fragments/graphics/x11
    ../../fragments/graphics/x11/sx
    ../../fragments/graphics/x11/dunst
    ../../fragments/graphics/x11/lock
    ../../fragments/graphics/x11/picom
    (import ../../fragments/graphics/greetd "sx")
    ../../fragments/graphics/window-manager/qtile
    ../../fragments/graphics/redshift
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/sound
    ../../fragments/other/xdg
    ../../fragments/services
    ../../fragments/services/autosuspend
    (import ../../fragments/services/jupyter "isharonov")
    ../../fragments/packages
    ../../fragments/programs
    ../../fragments/programs/git
    ../../fragments/programs/bash
    ../../fragments/programs/tmux
    ../../fragments/programs/neovim
    (import ../../fragments/users "isharonov")
  ];

  services = {
    upower.enable = true;
    autorandr.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lutris
  ];

  boot = {
    kernelParams = [ "clearcpuid=514" ];
    kernel.sysctl = {
      "vm.max_map_count" = 256 * 1024;
    };
    initrd.availableKernelModules = [ "nvme" ];
    kernelModules = [ "kvm-amd" ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  networking = {
    hostName = "thrud";
    wireless.iwd.enable = true;
  };
}
