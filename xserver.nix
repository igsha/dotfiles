{ config, pkgs, lib, ... }:

let
  i3blocks-config = builtins.toPath ./templates/i3blocks.conf;
  i3-config = pkgs.writeText "i3.conf" (lib.concatStrings [ (builtins.readFile ./templates/i3.conf) "\n" ''
    # startup
    exec $I3BLOCKS_CONF_DIR/../urxvt-start.sh
    exec nvim-qt
    exec thunderbird
    exec davmail
    exec qutebrowser
    exec telegram-desktop
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

    monitorSection = ''
      Option "DPMS" "true"
    '';
    serverLayoutSection = ''
      Option "StandbyTime" "10"
      Option "SuspendTime" "20"
      Option "OffTime" "30"
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

    xautolock = {
      enable = true;
      time = 5;
      locker = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
    };

    windowManager = {
      default = "i3";
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          feh networkmanagerapplet xterm scrot davmail numlockx i3blocks-gaps metar yad ack metar xkb_switch
          i3lock-fancy
        ];
        extraSessionCommands = ''
          numlockx
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
