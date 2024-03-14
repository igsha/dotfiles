{ config, pkgs, ... }:

{
  security = {
    sudo.enable = true;
    pam = {
      loginLimits = [
        { domain = "*"; type = "hard"; item = "core"; value = "unlimited"; }
        { domain = "*"; type = "soft"; item = "core"; value = "unlimited"; }
      ];
    };
    polkit.enable = true;
  };

  system.stateVersion = "unstable";

  time.timeZone = "Europe/Moscow";
  i18n.supportedLocales = [
    "${config.i18n.defaultLocale}/UTF-8"
    "C.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      sandbox = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };
  };

  console = {
    useXkbConfig = true;
    font = "LatArCyrHeb-16";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0547", ATTRS{idProduct}=="1002", MODE="0666"
  '';
}
