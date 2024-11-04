{ config, pkgs, ... }:

{
  services.xserver = {
    updateDbusEnvironment = true;
    windowManager.qtile = {
      enable = true;
      extraPackages = pythonPkgs: with pythonPkgs; [
        # TODO: https://github.com/NixOS/nixpkgs/issues/271610
        (qtile-extras.overridePythonAttrs (old: {
          doCheck = false;
        }))
      ];
    };
    desktopManager.runXdgAutostartIfNone = true;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      qtile = {
        prettyName = "Qtile";
        comment = "Qtile compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/qtile";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    ponymix
  ] ++ (if config.services.xserver.enable then [
    kbdd
    numlockx
    rofi
  ] else [
    rofi-wayland
    rofi-calc
    rofi-bluetooth
    rofi-screenshot
    rofi-pulse-select
    wayland-utils
    wlvncc
    wlay
    wdisplays
    wlr-randr
    wl-clipboard
    swaylock-effects
    hypridle # cannot use services.hypridle as it starts too early
  ]);

  security.pam.services.swaylock = {};

  home-config.qtile = {
    packages = [ "qtile" ];
    dir = builtins.toString ./home-config;
  };

  environment.etc."rofi/themes".source = "${pkgs.rofi}/share/rofi/themes";
}
