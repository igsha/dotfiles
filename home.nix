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
      evolutionWithPlugins
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
      (yt-dlp.override { withAlias = true; phantomjsSupport = true; })
      xkb-switch-i3 metar
    ] ++ (with gst_all_1; [ gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gstreamer gstreamer.dev gst-libav ]);
    keyboard = {
      layout = "us,ru";
      options = [ "grp:sclk_toggle" "grp:shift_caps_toggle" "grp_led:scroll" "keypad:pointerkeys" ];
    };
    sessionVariables = {
      I3BLOCKS_DIR = "${pkgs.i3blocks-gaps}/libexec/i3blocks";
      I3BLOCKS_CONF_DIR = "${builtins.dirOf (builtins.toPath ./templates/i3blocks.conf)}";
    };
    file = {
      ".wcalcrc".source = templates/wcalcrc;
      ".gdbinit".source = templates/gdbinit;
    };
  };

  programs = {
    bash = {
      enable = true;
      historyControl = [ "ignoredups" "ignorespace" ];
      sessionVariables = {
        PAGER = "bat";
        MANPAGER = "less";
      };
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
        write-filename-in-watch-later-config = true;
      };
    };
    bottom.enable = true;
    bat.enable = true;
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
    picom = {
      enable = true;
      vSync = true;
      backend = "xrender";
      extraOptions = ''
        unredir-if-possible = false;
      '';
    };
    screen-locker = {
      enable = true;
      inactiveInterval = 20;
      lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy -- ${pkgs.maim}/bin/maim";
      xautolock = {
        enable = true;
        extraOptions = [
          "-notify 10"
          "-notifier '${pkgs.libnotify}/bin/notify-send \"Locking in 10 seconds\"'"
        ];
      };
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "vifm/vifmrc".source = templates/vifmrc;
      "qutebrowser/config.py".source = templates/qutebrowser/config.py;
      "qutebrowser/scrollbar.css".source = templates/qutebrowser/scrollbar.css;
    };
    mimeApps = {
      enable = true;
      defaultApplications = import ./xdg-default.nix;
    };
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

  xsession = {
    enable = true;
    numlock.enable = true;
    scriptPath = ".xsession-hm";
    initExtra = ''
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap
      ${pkgs.xorg.xrandr}/bin/xrandr $(${pkgs.xorg.xrandr}/bin/xrandr --listactivemonitors | awk '{print $4}') --primary
    '';
    windowManager = {
      i3 = let
        modeSystem = "System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown";
        modifier = "Mod4";
      in {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
          modifier = modifier;
          assigns = {
            "1" = [{ class = "Termite"; }];
            "2" = [{ instance = "qutebrowser"; }];
            "3" = [{ class = "Thunderbird|Evolution|.evolution-wrapped_"; }];
            "4" = [{ instance = "telegram-desktop"; }];
            "5" = [{ class = "Steam|steam|steam.exe"; }];
            "6" = [{ class = "Wine"; }];
          };
          bars = [
            {
              position = "top";
              statusCommand = "${pkgs.i3blocks-gaps}/bin/i3blocks -c ${builtins.toPath ./templates/i3blocks.conf}";
              fonts = {
                names = [ "FontAwesome5Free" "DejaVu Sans Mono" ];
                style = "Semi-Condensed";
                size = 10.0;
              };
              workspaceButtons = true;
              workspaceNumbers = true;
              trayOutput = "primary";
              extraConfig = ''
                output primary
              '';
            }
          ];
          floating = {
            criteria = [
              { class = "Galculator|ffplay|XTerm|Wine|popup"; }
              { instance = "popup|yad|nm-connection-editor"; }
              { class = "Kruler"; }
            ];
          };
          focus.followMouse = false;
          fonts = {
            names = [ "FontAwesome5Free" "DejaVu Sans Mono" ];
            style = "Semi-Condensed";
            size = 10.0;
          };
          keybindings = pkgs.lib.mkOptionDefault {
            XF86AudioMute = "exec --no-startup-id ponymix toggle && pkill -RTMIN+10 i3blocks";
            XF86AudioLowerVolume = "exec --no-startup-id ponymix decrease 5% && pkill -RTMIN+10 i3blocks";
            XF86AudioRaiseVolume = "exec --no-startup-id ponymix increase 5% && pkill -RTMIN+10 i3blocks";
            "Shift+XF86AudioLowerVolume" = "exec --no-startup-id ponymix decrease 1% && pkill -RTMIN+10 i3blocks";
            "Shift+XF86AudioRaiseVolume" = "exec --no-startup-id ponymix increase 1% && pkill -RTMIN+10 i3blocks";
            XF86Calculator = "exec popup-wcalc";
            "${modifier}+Control+c" = "exec popup-wcalc";
            XF86Search = "exec popup-translate";
            "${modifier}+Control+t" = "exec popup-translate";
            "${modifier}+Shift+Print" = "exec flameshot full -p $HOME";
            "${modifier}+Print" = "exec flameshot gui -p $HOME";
            "${modifier}+m" = "exec --no-startup-id message-recorder -t";
            "${modifier}+r" = "mode resize";
            "${modifier}+Pause" = ''mode "${modeSystem}"'';
            "${modifier}+Tab" = "workspace next";
            "${modifier}+Shift+Tab" = "workspace prev";
            "--release ISO_Next_Group" = "exec --no-startup-id pkill -RTMIN+11 i3blocks";
            "--release Caps_Lock" = "exec --no-startup-id pkill -RTMIN+11 i3blocks";
            "--release Num_Lock" = "exec --no-startup-id pkill -RTMIN+11 i3blocks";
          };
          modes = {
            resize = {
              Left = "resize shrink width 10 px or 10 ppt";
              Down = "resize grow height 10 px or 10 ppt";
              Up = "resize shrink height 10 px or 10 ppt";
              Right = "resize grow width 10 px or 10 ppt";
              Return = "mode default";
              Escape = "mode default";
            };
            "${modeSystem}" = {
              l = "exec --no-startup-id loginctl lock-session $XDG_SESSION_ID, mode default";
              e = ''[class=".*"] kill, exec --no-startup-id i3-msg exit, mode default'';
              s = "exec --no-startup-id systemctl suspend, mode default";
              h = "exec --no-startup-id systemctl hibernate, mode default";
              r = "exec --no-startup-id systemctl reboot, mode default";
              "Shift+s" = "exec --no-startup-id systemctl poweroff, mode default";
              Return = "mode default";
              Escape = "mode default";
            };
          };
          startup = [
            { command = "i3-sensible-terminal -e tmux"; }
            { command = "qutebrowser"; }
            { command = "evolution"; }
            { command = "telegram-desktop"; }
          ];
          window = {
            commands = [
              { command = "border none"; criteria = { class = "Kruler"; }; }
            ];
          };
          workspaceAutoBackAndForth = true;
          workspaceLayout = "tabbed";
          defaultWorkspace = "workspace number 1";
        };
      };
    };
  };
}
