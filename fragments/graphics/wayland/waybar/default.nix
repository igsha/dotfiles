{ pkgs, ... }:

{
  programs.waybar.enable = true;
  environment.systemPackages = [ pkgs.waybar ];

  home-config.waybar = {
    packages = [ "waybar" ];
    dir = builtins.toString ./home-config;
  };
}
