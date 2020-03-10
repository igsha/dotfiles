{ pkgs, user, email }:

let
  popup-wcalc = pkgs.writeScriptBin "popup-wcalc" (builtins.readFile templates/popup);
  popup-sdcv = pkgs.writeScriptBin "popup-sdcv" (builtins.readFile templates/popup);
  message-recorder = pkgs.writeScriptBin "message-recorder" (builtins.readFile templates/message-recorder);
  color-tester = pkgs.writeScriptBin "color-tester" (builtins.readFile templates/color-tester.sh);
  home-bin = pkgs.runCommand "home-bin" { ignoreCollisions = true; envVariable = true; } ''
    mkdir $out
    ln -s -t $out/ ${user.home}/bin
  '';

in {
  home = {
    packages = with pkgs; [
      atool
      winetricks wineWowPackages.full
      hexyl
      mpv
      pavucontrol
      (imv.overrideAttrs (old: { buildInputs = old.buildInputs ++ [ librsvg ]; }))
      inkscape krita mypaint gimp
      kpcli
      zathura
      ffmpeg-full
      freerdp
      tdesktop
      qutebrowser google-chrome
      gnome3.evolution
      libreoffice-still
      steam
      xsel xclip xdotool
      xlibs.xhost hsetroot xorg.xev xorg.xkill
      xfontsel
      xorg.xwininfo
      davmail yad ack libnotify dropbox slack-dark iplay
      popup-wcalc popup-sdcv message-recorder color-tester
      fzy
    ];
    keyboard = {
      layout = "us,ru";
      options = [ "grp:sclk_toggle" "grp:shift_caps_toggle" "grp_led:scroll" "keypad:pointerkeys" ];
    };
  };

  programs = {
    home-manager.enable = true;
    git = import ./gitConfig.nix { userName = user.description; userEmail = email; };
    fzf.enable = true;
    pidgin = {
      enable = true;
      plugins = with pkgs; [ pidgin-latex pidgin-osd purple-hangouts telegram-purple pidgin-window-merge pidgin-skypeweb ];
    };
    command-not-found.enable = true;
    termite = {
      enable = true;
      allowBold = true;
      font = "Hack 12";
      scrollOnOutput = true;
      scrollOnKeystroke = true;
      scrollbackLines = 65536;
      cursorBlink = "on";
      cursorShape = "block";
      scrollbar = "off";
      backgroundColor = "rgba(0, 0, 0, 0.75)";
      foregroundColor = "#c5c8c6";
      foregroundBoldColor = "#c5c8c6";
      colorsExtra = ''
        # black
        color0  = #282a2e
        color8  = #373b41
        # red
        color1  = #a54242
        color9  = #cc6666
        # green
        color2  = #8c9440
        color10 = #b5bd68
        # yellow
        color3  = #de935f
        color11 = #f0c674
        # blue
        color4  = #5f819d
        color12 = #81a2be
        # magenta
        color5  = #85678f
        color13 = #b294bb
        # cyan
        color6  = #5e8d87
        color14 = #8abeb7
        # white
        color7  = #707880
        color15 = #c5c8c6
      '';
      hintsPadding = 2;
    };
  };

  services = {
    flameshot.enable = true;
    random-background = {
      enable = true;
      imageDirectory = "%h/Pictures";
      interval = "2hours";
    };
    dunst = {
      enable = true;
      settings = {
        global = {
          transparency = 10;
          geometry = "300x5-30+30";
        };
        shortcuts = {
          close = "ctrl+space";
          close_all = "ctrl+shift+space";
          history = "ctrl+grave";
          context = "ctrl+apostrophe";
        };
      };
    };
    gnome-keyring.enable = true;
  };

  xdg.configFile."nixpkgs/config.nix".text = builtins.readFile ./nixpkgs-config.nix;
  xdg.configFile."vifm/vifmrc".source = templates/vifmrc;
  xdg.configFile."qutebrowser/config.py".source = templates/qutebrowser/config.py;
  xdg.configFile."qutebrowser/scrollbar.css".source = templates/qutebrowser/scrollbar.css;
  xdg.configFile."mpv/input.conf".source = templates/mpv-input.conf;

  home.file = {
    ".wcalcrc".source = templates/wcalcrc;
    ".gdbinit".source = templates/gdbinit;
    ".bashrc".source = templates/bashrc;
  };
}
