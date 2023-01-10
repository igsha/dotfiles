{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" "nouveau" ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };
}
