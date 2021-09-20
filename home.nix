{ pkgs, user, email }:

let
  popup-wcalc = pkgs.writeScriptBin "popup-wcalc" ''
    #!/usr/bin/env bash
    $TERMINAL --class popup --title wcalc --exec wcalc
  '';
  popup-translate = pkgs.writeScriptBin "popup-translate" ''
    #!/usr/bin/env bash
    $TERMINAL --class popup --title translate --exec "trans -I"
  '';
  message-recorder = pkgs.writeScriptBin "message-recorder" (builtins.readFile templates/message-recorder);
  color-tester = pkgs.writeScriptBin "color-tester" (builtins.readFile templates/color-tester.sh);
  check-updates = pkgs.writeScriptBin "check-updates" (builtins.readFile templates/check-updates);

in {
  home = {
    packages = with pkgs; [
      atool
      winetricks wineWowPackages.unstable
      pavucontrol
      (imv.overrideAttrs (old: { buildInputs = old.buildInputs ++ [ librsvg ]; }))
      inkscape krita
      kpcli
      zathura
      ffmpeg-full
      freerdp
      tdesktop
      qutebrowser google-chrome
      evolutionWithPlugins thunderbird
      libreoffice-still hunspellDicts.ru-ru
      xsel xclip xdotool
      xlibs.xhost hsetroot xorg.xev xorg.xkill
      xfontsel
      xorg.xwininfo
      yad ack libnotify slack-dark iplay google-drive-ocamlfuse
      popup-wcalc popup-translate message-recorder color-tester check-updates
      fzy
      asciinema discord obs-studio trueconf
      translate-shell
    ] ++ (with gst_all_1; [ gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gstreamer gstreamer.dev ]);
    keyboard = {
      layout = "us,ru";
      options = [ "grp:sclk_toggle" "grp:shift_caps_toggle" "grp_led:scroll" "keypad:pointerkeys" ];
    };
  };

  programs = {
    bash = {
      enable = true;
      historyControl = [ "ignoredups" "ignorespace" ];
    };
    git = import ./gitConfig.nix { userName = user.description; userEmail = email; };
    fzf.enable = true;
    command-not-found.enable = true;
    powerline-go = {
      enable = true;
      modules = [ "time" "nix-shell" "user" "ssh" "cwd" "perms" "git" "jobs" "exit" "root" ];
      settings = {
        cwd-mode = "dironly";
        numeric-exit-codes = true;
        condensed = true;
        mode = "patched";
        shell = "bash";
      };
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
    };
    pidgin = {
      enable = true;
      plugins = with pkgs; [ pidgin-latex pidgin-osd purple-hangouts telegram-purple pidgin-window-merge pidgin-skypeweb ];
    };
    termite = {
      enable = true;
      allowBold = true;
      font = "Hack 12";
      scrollOnOutput = true;
      scrollOnKeystroke = true;
      scrollbackLines = -1;
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
      clickableUrl = false;
    };
    mpv = {
      enable = true;
      bindings = {
        F1  = ''cycle-values af "dynaudnorm=g=5:f=250:r=0.9:p=0.5" "loudnorm=I=-16:TP=-3:LRA=4" ""'';
      };
      config = {
        ytdl-format = "bestvideo[height<=720]+bestaudio/best";
      };
    };
  };

  services = {
    flameshot.enable = true;
    gnome-keyring.enable = true;
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
  };

  xdg.configFile."nixpkgs/config.nix".text = builtins.readFile ./nixpkgs-config.nix;
  xdg.configFile."vifm/vifmrc".source = templates/vifmrc;
  xdg.configFile."qutebrowser/config.py".source = templates/qutebrowser/config.py;
  xdg.configFile."qutebrowser/scrollbar.css".source = templates/qutebrowser/scrollbar.css;

  home.file = {
    ".wcalcrc".source = templates/wcalcrc;
    ".gdbinit".source = templates/gdbinit;
  };

  systemd.user.services.google-drive = {
    Unit = {
      Description = "Mount google drive";
      After = [ "networ-online.target" ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };

    Service = {
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -f /home/${user.name}/Google/Drive";
    };
  };
}
