{ pkgs, ... }:

{
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      ponymix
      xkb-switch-i3
      flameshot
    ];
    configFile = ./config;
  };
}
