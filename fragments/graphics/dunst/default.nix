{ lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.dunst ];

  home-config.dunst = ./home-config;
}
