{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
      base = true;
    };
    extraPackages = with pkgs; [
      swaylock
      swayidle
      swaybg
      foot
      mako
      swaykbdd
      sway-contrib.grimshot
      wl-clipboard
      ponymix
    ];
  };

  home-config.sway = {
    packages = [ "sway" ];
    dir = builtins.toString ./home-config;
  };
}
