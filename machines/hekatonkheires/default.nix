{ config, lib, pkgs, nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.common-cpu-amd-pstate
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-hidpi
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-laptop-ssd

    ../../custom-args
    ../../fragments/boot
    ../../fragments/graphics
    ../../fragments/graphics/dunst
    ../../fragments/graphics/redshift
    ../../fragments/graphics/screenshot
    ../../fragments/graphics/window-manager/qtile
    ../../fragments/graphics/x11
    ../../fragments/graphics/x11/autosuspend
    ../../fragments/network
    ../../fragments/network/netutils
    ../../fragments/network/openvpn
    ../../fragments/other
    ../../fragments/other/fonts
    ../../fragments/other/sound
    ../../fragments/other/virtualisation
    ../../fragments/other/xdg
    ../../fragments/services
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

  services = {
    upower = {
      enable = false;
      ignoreLid = true;
      criticalPowerAction = "Hibernate";
    };
    logind.lidSwitchDocked = "ignore";
    logind.lidSwitchExternalPower = "ignore";
  };

  boot = {
    initrd.availableKernelModules = [ "nvme" ];
    kernelModules = [ "kvm-amd" ];
    # https://github.com/NixOS/nixos-hardware/issues/1348
    # https://github.com/NixOS/nixos-hardware/issues/1314
    kernelParams = [
      "pcie_aspm=off"
      "amdgpu.abmlevel=0"
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  networking = {
    hostName = "hekatonkheires";
    wireless.iwd.enable = true;
  };

  home-config.autostart = {
    packages = [ "autostart" ];
    dir = builtins.toString ./home-config;
  };

  environment.systemPackages = with pkgs; [
    shattered-pixel-dungeon
    firefox-bin
  ];

  # Allow default config in ~/.config/docker/daemon.json
  systemd.user.services.docker.serviceConfig.ExecStart = lib.mkForce "${config.virtualisation.docker.rootless.package}/bin/dockerd-rootless";

  virtualisation.virtualbox.host = {
    enable = false;
    enableExtensionPack = true;
    enableKvm = false;
    addNetworkInterface = true;
  };
}
