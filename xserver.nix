{ config, pkgs, ... }:

{
  services.xserver = {
    autorun = true;
    enable = true;

    layout = "us,ru";
    xkbOptions = "grp:sclk_toggle,grp:shift_caps_toggle,grp_led:scroll,keypad:pointerkeys";
    autoRepeatDelay = 300;
    autoRepeatInterval = 20;
    enableTCP = true;

    videoDrivers = [ "nvidia" ];

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };

    windowManager = {
      default = "i3";
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [ feh networkmanagerapplet xterm scrot i3pystatus davmail numlockx ];
        extraSessionCommands = ''
          numlockx
        '';
      };
    };
  };
}
