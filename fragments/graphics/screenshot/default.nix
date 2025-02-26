{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (flameshot.override { enableWlrSupport = !config.services.xserver.enable; })
  ];

  home-config.screenshot = ./home-config;
}
