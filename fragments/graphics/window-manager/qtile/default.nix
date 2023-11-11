{ config, pkgs, ... }:

let
  iwlib = pkgs.python3Packages.buildPythonPackage rec {
    pname = "iwlib";
    version = "1.7.0";
    src = pkgs.fetchPypi {
      inherit pname version;
      hash = "sha256-qAX2WXpw7jABq6jwOft7Lct13BXE54UvVZT9Y3kZbaE=";
    };
    buildInputs = with pkgs.python3Packages; [ cffi ];
    propagatedBuildInputs = [ pkgs.wirelesstools ];
    meta = {
      homepage = https://github.com/nhoad/python-iwlib;
    };
  };

in {
  services.xserver = {
    updateDbusEnvironment = true;
    windowManager.qtile = {
      enable = true;
      backend = if config.services.xserver.enable then "x11" else "wayland";
      extraPackages = pythonPkgs: with pythonPkgs; [
        qtile-extras
        iwlib
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
