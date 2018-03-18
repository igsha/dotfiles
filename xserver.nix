{ config, pkgs, lib, ... }:

let
  i3blocks-config = builtins.toPath ./templates/i3blocks.conf;
  i3-config = pkgs.writeText "i3.conf" (lib.concatStrings [ (builtins.readFile ./templates/i3.conf) "\n" ''
    bar {
        status_command DEFAULT_DIR=${pkgs.i3blocks-gaps}/libexec/i3blocks SCRIPT_DIR=${builtins.dirOf i3blocks-config} i3blocks -c ${i3blocks-config}
        font pango:Font Awesome 5 Free 10
        position top
        workspace_buttons yes
    }

    # startup
    exec urxvtc
    exec nvim-qt
    exec thunderbird
    exec davmail
    exec qutebrowser
    exec telegram-desktop
    exec feh --randomize --bg-center ~/Pictures/
    exec nm-applet
  '' ]);

in rec {

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
        extraPackages = with pkgs; [
          feh networkmanagerapplet xterm scrot davmail numlockx i3blocks-gaps metar yad ack metar xkb_switch
        ];
        extraSessionCommands = ''
          numlockx
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
