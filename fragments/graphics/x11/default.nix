{ config, pkgs, ... }:

let
  locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy -- ${pkgs.maim}/bin/maim";
in {
  services = {
    xserver = {
      enable = true;
      autorun = false;
      autoRepeatDelay = 250;
      autoRepeatInterval = 40;
      enableTCP = true;
      wacom.enable = true;
      xkb = {
        options = "grp:alt_space_toggle,grp:sclk_toggle,keypad:pointerkeys";
        layout = "us,ru";
      };
      serverFlagsSection = ''
        Option "BlankTime" "0"
      '';
      monitorSection = ''
        Option "DPMS" "false"
      '';
      exportConfiguration = true;
      desktopManager.xterm.enable = false;
      displayManager.sx.enable = true;
      xautolock = {
        enable = true;
        time = 20;
        notify = 10;
        notifier = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds'";
        inherit locker;
      };
    };
    picom = {
      enable = true;
      vSync = true;
      backend = "xrender";
      settings = {
        unredir-if-possible = false;
      };
    };
  };

  programs.xss-lock = {
    enable = true;
    lockerCommand = locker;
    extraOptions = [ "--ignore-sleep" ];
  };

  environment.systemPackages = with pkgs; [
    evtest
    xf86_input_wacom
    libwacom
    wacomtablet
  ];
}
