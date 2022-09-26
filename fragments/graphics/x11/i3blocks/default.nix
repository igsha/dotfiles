{ lib, pkgs, ... }:

{
  services.xserver.windowManager.i3.extraPackages = [ pkgs.i3blocks-gaps ];

  home-config.i3blocks = {
    packages = [ "i3blocks" ];
    dir = builtins.toString ./home-config;
  };
}
