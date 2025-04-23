{ config, lib, pkgs, nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-cpu-amd-pstate
    nixos-hardware.nixosModules.common-gpu-nvidia
    nixos-hardware.nixosModules.common-hidpi
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-ssd

    ../../custom-args
    ../../fragments/boot
    ../../fragments/graphics
    ../../fragments/graphics/dunst
    ../../fragments/graphics/redshift
    ../../fragments/graphics/screenshot
    ../../fragments/graphics/window-manager/qtile
    #../../fragments/graphics/x11
    #../../fragments/graphics/x11/autosuspend
    ../../fragments/network
    ../../fragments/network/netutils
    ../../fragments/network/openvpn
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/games
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
    ../../fragments/services/location
    ../../fragments/packages
    ../../fragments/packages/python-lab
    ../../fragments/programs
    ../../fragments/programs/bash
    ../../fragments/programs/email
    ../../fragments/programs/git
    ../../fragments/programs/gnupg
    ../../fragments/programs/neovim
    ../../fragments/programs/nnn
    ../../fragments/programs/tmux
    ../../fragments/programs/udevil
    ../../fragments/users
  ];

  custom-args = {
    boot = {
      devdisk = "/dev/nvme0n1p";
      tmpsize = "16G";
    };
    user = "isharonov";
    battery = true;
  };

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  hardware.nvidia = {
    prime = {
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";
    };
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    open = true;
  };

  services = {
    upower.enable = true;
  };

  boot = {
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

  home-config.autostart = ./home-config;
}
