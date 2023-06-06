{ devdisk ? "/dev/sda", tmpsize ? "8G" }:
{ lib, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

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
    "/boot" = { device = "${devdisk}1"; fsType = "vfat"; };
    "/" = { device = "${devdisk}2"; fsType = "ext4"; };
    "/home" = { device = "${devdisk}3"; fsType = "ext4"; };
    "/tmp" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "nosuid" "nodev" "relatime" "size=${tmpsize}" ];
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
