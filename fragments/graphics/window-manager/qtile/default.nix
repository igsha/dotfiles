{ config, pkgs, ... }:

{
  services.xserver.windowManager.qtile = {
    enable = true;
    backend = if config.services.xserver.enable then "x11" else "wayland";
    extraPackages = pythonPkgs: with pythonPkgs; [
      qtile-extras
    ];
  };

  home-config.qtile = {
    packages = [ "qtile" ];
    dir = builtins.toString ./home-config;
  };
}
