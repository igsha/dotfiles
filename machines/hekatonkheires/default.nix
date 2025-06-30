{ config, lib, pkgs, nixos-hardware, ... }:

{
  imports = [
    nixos-hardware.nixosModules.hp-elitebook-845g8
    nixos-hardware.nixosModules.common-hidpi

    ../../custom-args
    ../../fragments/boot
    ../../fragments/graphics
    ../../fragments/graphics/dunst
    ../../fragments/graphics/redshift
    ../../fragments/graphics/screenshot
    ../../fragments/graphics/window-manager/hyprland
    ../../fragments/network
    ../../fragments/network/netutils
    ../../fragments/network/openvpn
    ../../fragments/other
    ../../fragments/other/fonts
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
    kernel.sysctl = {
      "net.core.wmem_max" = 5000000;
      "net.core.wmem_default" = 5000000;
      "net.core.rmem_max" = 5000000;
      "net.core.rmem_default" = 5000000;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  networking = {
    hostName = "hekatonkheires";
    wireless.iwd.enable = true;
  };

  home-config.autostart = ./home-config;

  environment.systemPackages = with pkgs; [
    shattered-pixel-dungeon
    firefox-bin
    gajim
    lksctp-tools
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
