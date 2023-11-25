{ config, lib, pkgs, ... }:

{
  imports = [
    ../../custom-args
    ../../fragments/boot
    ../../fragments/graphics/greetd
    ../../fragments/graphics/redshift
    ../../fragments/graphics/screenshot
    ../../fragments/graphics/window-manager/qtile
    ../../fragments/graphics/x11
    ../../fragments/graphics/x11/autorandr
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
    ../../fragments/services/jupyter
    ../../fragments/packages
    ../../fragments/programs
    ../../fragments/programs/bash
    ../../fragments/programs/git
    ../../fragments/programs/neovim
    ../../fragments/programs/tmux
    ../../fragments/users
    ../../home-config
  ];

  custom-args = {
    boot = {
      devdisk = "/dev/nvme0n1p";
      tmpsize = "16G";
    };
    greetd.cmd = "sx";
    user = "isharonov";
  };

  hardware.nvidia = {
    prime = {
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";
    };
    powerManagement = {
      enable = true;
      finegrained = true;
    };
  };

  services = {
    upower.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lutris
  ];

  boot = {
    initrd.availableKernelModules = [ "nvme" ];
    kernelModules = [ "kvm-amd" ];
  };

  swapDevices = [{ label = "swap"; }];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  networking = {
    hostName = "thrud";
    wireless.iwd.enable = true;
  };

  home-config.autostart = {
    packages = [ "autostart" ];
    dir = builtins.toString ./home-config;
  };
}
