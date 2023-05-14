{ lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.dunst ];

  home-config.dunst = {
    packages = [ "dunst" ];
    dir = builtins.toString ./home-config;
  };
}
