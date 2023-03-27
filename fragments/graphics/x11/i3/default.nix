{ pkgs, ... }:

{
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      ponymix
      xkb-switch-i3
      flameshot
      x11vnc
    ];
  };

  home-config.i3 = {
    packages = [ "i3" ];
    dir = builtins.toString ./home-config;
  };
}
