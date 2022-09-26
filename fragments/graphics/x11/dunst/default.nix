{ lib, pkgs, ... }:

{
  services.xserver.windowManager.i3.extraPackages = [ pkgs.dunst ];

  home-config.dunst = {
    packages = [ "dunst" ];
    dir = builtins.toString ./home-config;
  };
}
