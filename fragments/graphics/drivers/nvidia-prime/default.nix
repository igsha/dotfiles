{ config, pkgs, ... }:

{
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:4:0:0";
      };
    };

    bumblebee = {
      enable = false;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
