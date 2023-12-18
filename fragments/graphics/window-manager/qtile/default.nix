{ config, pkgs, ... }:

{
  services.xserver = {
    updateDbusEnvironment = true;
    windowManager.qtile = {
      enable = true;
      backend = if config.services.xserver.enable then "x11" else "wayland";
      extraPackages = pythonPkgs: with pythonPkgs; [
        # TODO: https://github.com/NixOS/nixpkgs/issues/271610
        (qtile-extras.overridePythonAttrs (old: {
          doCheck = false;
        }))
      ];
    };
    desktopManager.runXdgAutostartIfNone = true;
  };

  environment.systemPackages = with pkgs; [
    ponymix
    kbdd
    rofi
  ];

  home-config.qtile = {
    packages = [ "qtile" "rofi" ];
    dir = builtins.toString ./home-config;
  };

  environment.etc."rofi/themes".source = "${pkgs.rofi}/share/rofi/themes";
}
