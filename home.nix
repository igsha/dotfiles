{ pkgs, user, email }:

let
  popup-wcalc = pkgs.writeScriptBin "popup-wcalc" ''
    #!/usr/bin/env bash
    $TERMINAL --class popup -t wcalc -e wcalc
  '';
  popup-translate = pkgs.writeScriptBin "popup-translate" ''
    #!/usr/bin/env bash
    $TERMINAL --class popup -t translate -e trans -I
  '';
  message-recorder = pkgs.writeScriptBin "message-recorder" (builtins.readFile templates/message-recorder);
  color-tester = pkgs.writeScriptBin "color-tester" (builtins.readFile templates/color-tester.sh);
  check-updates = pkgs.writeScriptBin "check-updates" (builtins.readFile templates/check-updates);

in {
  home = {
    packages = with pkgs; [
      atool
      bottles wineWowPackages.unstable
      pavucontrol
      (imv.overrideAttrs (old: { buildInputs = old.buildInputs ++ [ librsvg ]; }))
      inkscape krita gimp mypaint
      kpcli
      zathura
      ffmpeg-full
      freerdp
      tdesktop
      qutebrowser google-chrome
      evolutionWithPlugins
      hunspellDicts.ru-ru
      yad ack libnotify slack-dark iplay google-drive-ocamlfuse
      popup-wcalc popup-translate message-recorder color-tester check-updates
      fzy
      asciinema discord obs-studio trueconf
      translate-shell
      (yt-dlp.override { withAlias = true; phantomjsSupport = true; })
      metar rtorrent gitui python3Packages.speedtest-cli pre-commit
      xsel xclip xdotool
      xorg.xhost hsetroot xorg.xev xorg.xkill
      xfontsel
      xorg.xwininfo
      xkb-switch-i3
      wpsoffice
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
    foot = {
      enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "Fira Code:size=11";
          dpi-aware = "yes";
        };
        mouse.hide-when-typing = "yes";
      };
    };
    alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.8;
      };
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
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = [ pkgs.rofi-calc ];
      terminal = "alacritty";
    };
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      terminal = "xterm-256color";
      shortcut = "a";
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 50000;
      plugins = with pkgs.tmuxPlugins; [
        prefix-highlight
        sidebar
        urlview
        { plugin = yank; extraConfig = "set -g @yank_selection 'primary'"; }
        pain-control
        logging
        open
        copycat
      ];
      extraConfig = ''
        set -g mouse on
        set -g status-right '#{prefix_highlight} %a %Y-%m-%dT%H:%M'
        set -ga status-style "bg=black fg=white"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'

        bind-key -n Home send Escape "OH"
        bind-key -n End send Escape "OF"
      '';
    };
    qutebrowser = {
      enable = true;
      aliases = {
        defproxy = "set content.proxy system";
        noproxy = "set content.proxy none";
        tor = "set content.proxy socks://localhost:9050";
        play = "spawn alacritty --class popup -e iplay -b {url}";
      };
      keyBindings = {
        normal = {
          "t" = "set-cmd-text -s :open -t";
          "O" = "set-cmd-text :open {url:pretty}";
          "T" = "set-cmd-text -s :open -t {url:pretty}";
          "D" = "tab-prev ;; tab-close";
          "gt" = "tab-next";
          "<Ctrl-Tab>" = "tab-next";
          "gT" = "tab-prev";
          "<Ctrl-Shift-Tab>" = "tab-prev";
          "gD" = "download";
          "gd" = "download-open";
          ";P" = "spawn google-chrome-stable --incognito {url}";
          ";b" = "set-cmd-text -s :tab-select";
          ";m" = "hint links spawn mpv --load-unsafe-playlists {hint-url}";
          ";M" = "hint links spawn torsocks mpv --load-unsafe-playlists {hint-url}";
          ";p" = "hint all spawn google-chrome-stable --incognito {hint-url}";
          ";l" = "hint links spawn alacritty --class popup -e iplay -b {hint-url}";
        };
      };
      searchEngines = {
        google = "https://www.google.com/search?q={}";
        youtube = "https://www.youtube.com/results?search_query={}";
        goosh = "https://goosh.org/#{}";
        translate = "https://translate.yandex.ru/?text={}";
        wikipedia = "https://ru.wikipedia.org/wiki/{}";
        enwikipedia = "https://en.wikipedia.org/wiki/{}";
        cppreference = "http://cppreference.com/?search={}";
        github = "https://github.com/search?q={}";
        cmake = "https://cmake.org/cmake/help/latest/search.html?q={}";
        DEFAULT = "https://www.google.com/search?q={}";
      };
      settings = {
        url.start_pages = https://nixos.org;
        editor.command = [ "alacritty" "--class" "editor" "-e" "nvim" "{}" ];
        downloads = {
          position = "bottom";
          location.directory = "~/Downloads";
        };
        scrolling.bar = "always";
        window.title_format = "{perc}{current_title}{title_sep}qutebrowser{private}";
        colors.statusbar.command.private.bg = "black";
        completion.web_history.max_items = 100;
        input.partial_timeout = 2000;
        tabs = {
          background = true;
          title.format = "{index}: {current_title}{private}";
          show = "always";
        };
        content = {
          user_stylesheets = "${builtins.toPath ./templates/qutebrowser/scrollbar.css}";
          plugins = true;
          geolocation = true;
          blocking.enabled = false;
        };
        session.lazy_restore = true;
        hints = {
          chars = "asdfghjklqwertyuiopzxcvbnm";
          next_regexes = [ ''\\bДальше\\b'' ''\\bВпер(е|ё)д\\b'' ''\\bСледующая\\b'' ];
          prev_regexes = [ ''\\bНазад\\b'' ];
        };
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
          ignore_dbusclose = true;
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
    gammastep = {
      enable = true;
      provider = "geoclue2";
      tray = false;
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "vifm/vifmrc".source = templates/vifmrc;
    };
    mimeApps = {
      enable = true;
      defaultApplications = import ./xdg-default.nix;
    };
  };

  systemd.user.services.google-drive = {
    Unit = {
      Description = "Mount google drive";
      After = [ "network-online.target" ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };

    Service = {
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse -f /home/${user.name}/Google/Drive";
    };
  };

  manual = {
    html.enable = true;
    json.enable = true;
    manpages.enable = true;
  };

  xsession = {
    enable = true;
    numlock.enable = true;
    scriptPath = ".config/sx/sxrc";
    initExtra = ''
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap
      ${pkgs.xorg.xset}/bin/xset r rate 250 40
      ${pkgs.xorg.xrandr}/bin/xrandr --output $(${pkgs.xorg.xrandr}/bin/xrandr --listactivemonitors | awk '{print $4}') --primary
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
            "1" = [{ instance = "Alacritty"; }];
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
            names = [ "DejaVu Sans Mono" "Font Awesome 5 Free" ];
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
            "${modifier}+d" = "exec rofi -show run";
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
              l = "exec --no-startup-id loginctl lock-session, mode default";
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
            { command = "alacritty -e tmux"; }
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
