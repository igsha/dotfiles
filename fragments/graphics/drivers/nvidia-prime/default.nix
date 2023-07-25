{ config, pkgs, ... }:

{
  hardware = {
    opengl = {
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ nvidia-vaapi-driver ];
    };

    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:4:0:0";
      };
      nvidiaPersistenced = false;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
    };

    bumblebee = {
      enable = false;
    };
  };

  boot.initrd.kernelModules = [ "nvidia" ];
  services.xserver.videoDrivers = [ "nvidia" ];
}
