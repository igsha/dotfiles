{ lib, ... }:

{
  services.xserver = {
    autorun = lib.mkForce false;
    displayManager.sx.enable = true;
  };

  home-config.sx = {
    packages = [ "sx" ];
    dir = builtins.toString ./home-config;
  };
}
