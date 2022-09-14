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

  nix = {
    settings.sandbox = true;
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  console = {
    useXkbConfig = true;
    font = "LatArCyrHeb-16";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = !config.services.xserver.enable;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0547", ATTRS{idProduct}=="1002", MODE="0666"
  '';
}
