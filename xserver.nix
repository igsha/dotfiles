{ config, pkgs, lib, ... }:

let
  i3blocks-config = builtins.toPath ./templates/i3blocks.conf;
  i3-config = builtins.toPath ./templates/i3.conf;

in rec {

  services.xserver = {
    autorun = true;
    enable = true;

    layout = "us,ru";
    xkbOptions = "grp:sclk_toggle,grp:shift_caps_toggle,grp_led:scroll,keypad:pointerkeys";
    autoRepeatDelay = 300;
    autoRepeatInterval = 20;
    enableTCP = true;

    monitorSection = ''
      Option "DPMS" "true"
    '';
    serverLayoutSection = ''
      Option "BlankTime" "5"
      Option "StandbyTime" "30"
      Option "SuspendTime" "60"
      Option "OffTime" "90"
    '';

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
        extraPackages = with pkgs; [
          feh networkmanagerapplet xterm davmail numlockx i3blocks-gaps metar yad ack metar xkb_switch
          i3lock-fancy flameshot xss-lock
        ];
        extraSessionCommands = ''
          numlockx
          xss-lock -- i3lock-fancy &
          export I3BLOCKS_DIR=${pkgs.i3blocks-gaps}/libexec/i3blocks
          export I3BLOCKS_CONF_DIR=${builtins.dirOf i3blocks-config}
        '';
        configFile = i3-config;
      };
    };
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    enableCoreFonts = true;
    fontconfig = {
      defaultFonts.monospace = ["DejaVu Sans Mono"];
      antialias = true;
    };
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      freefont_ttf
      ttf_bitstream_vera
      inconsolata-lgc
      google-fonts
      anonymousPro
      font-awesome-ttf
    ];
  };
}
