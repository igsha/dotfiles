{ config, lib, pkgs, ... }:

{
  imports = [
    ../../custom-args
    ../../home-config
    ../../fragments/boot
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
    ../../fragments/graphics/greetd
    ../../fragments/graphics/window-manager/qtile
    ../../fragments/graphics/redshift
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
    ../../fragments/services/autosuspend
    ../../fragments/services/jupyter
    ../../fragments/packages
    ../../fragments/programs
    ../../fragments/programs/git
    ../../fragments/programs/bash
    ../../fragments/programs/tmux
    ../../fragments/programs/neovim
    ../../fragments/users
  ];

  custom-args = {
    boot = {
      devdisk = "/dev/nvme0n1p";
      tmpsize = "16G";
    };
    greetd.cmd = "sx";
    user = "isharonov";
  };

  services = {
    upower.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lutris
  ] ++ lib.optionals config.services.xserver.enable [ autorandr ];

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