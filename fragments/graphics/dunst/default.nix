{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst
    libnotify
  ];

  home-config.dunst = ./home-config;
}
