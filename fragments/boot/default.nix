{ lib, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [ "drm" ];
    kernelModules = [ "kvm-intel" "sg" "drm" ];
    extraModulePackages = [ ];
    loader = {
      grub.device = "/dev/sda";
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/boot" = { device = "/dev/sda1"; fsType = "vfat"; };
    "/" = { device = "/dev/sda2"; fsType = "ext4"; };
    "/home" = { device = "/dev/sda3"; fsType = "ext4"; };
    "/tmp" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "nosuid" "nodev" "relatime" "size=8G" ];
    };
  };

  swapDevices = [
    { device = "/dev/sda4"; }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
