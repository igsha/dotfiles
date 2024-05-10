{ config, lib, ... }:

{
  hardware.enableRedistributableFirmware = true;

  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [ "drm" ];
    kernelModules = [ "sg" "drm" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
  };

  fileSystems = {
    "/boot" = { device = "${config.custom-args.boot.devdisk}1"; fsType = "vfat"; };
    "/" = { device = "${config.custom-args.boot.devdisk}2"; fsType = "ext4"; };
    "/home" = { device = "${config.custom-args.boot.devdisk}3"; fsType = "ext4"; };
    "/tmp" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "nosuid" "nodev" "relatime" "size=${config.custom-args.boot.tmpsize}" ];
    };
  };

  swapDevices = [{ label = "swap"; }]; # need for hibernation
}
