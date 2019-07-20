{ pkgs, user, email }:

let
  i3blocks-config = builtins.toPath ./templates/i3blocks.conf;
  i3-config = builtins.toPath ./templates/i3.conf;

in rec {
  home = {
    packages = with pkgs; [
      atool
      wine winetricks
      xst
      davmail
      mpv
      pavucontrol
      viewnior
      imv
      inkscape krita
      zathura
      ffmpeg-full
      freerdp
      neovim-qt
      tdesktop
      qutebrowser flashplayer-standalone google-chrome
      gnome3.evolution
      libreoffice-still
      skypeforlinux
      steam
      # X11
      xsel xclip xdotool
      xlibs.xhost hsetroot xorg.xev xorg.xkill
      dmenu
      xfontsel
      xorg.xwininfo

      i3-gaps
      davmail numlockx i3blocks-gaps metar yad ack metar xkb-switch i3lock-fancy libnotify dropbox slack-dark iplay
    ];
  };

  programs = {
    home-manager.enable = true;
    git = import ./gitConfig.nix { userName = user; userEmail = email; };
    fzf.enable = true;
    pidgin = {
      enable = true;
      plugins = with pkgs; [ pidgin-latex pidgin-osd purple-hangouts telegram-purple pidgin-window-merge pidgin-skypeweb ];
    };
    command-not-found.enable = true;
  };

  services = {
    flameshot.enable = true;
    random-background = {
      enable = true;
      imageDirectory = "%h/Pictures";
      interval = "2hours";
    };
    screen-locker = {
      enable = true;
      inactiveInterval = 15;
      lockCmd = "${pkgs.i3lock-fancy}/bin/i3lock-fancy";
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
  xdg.configFile."matplotlib".source = configs/matplotlib;
  xdg.configFile."vifm/vifmrc".source = configs/vifmrc;
  xdg.configFile."qutebrowser/config.py".source = configs/qutebrowser/config.py;
  xdg.configFile."qutebrowser/scrollbar.css".source = configs/qutebrowser/scrollbar.css;

  home.file = {
    ".wcalcrc".source = configs/wcalcrc;
    ".gdbinit".source = configs/gdbinit;
    ".Xdefaults".source = configs/Xdefaults;
    ".git-prompt.sh".source = configs/git-prompt.sh;
    ".bashrc".source = configs/bashrc;
    "bin/popup-wcalc".source = configs/popup;
    "bin/popup-sdcv".source = configs/popup;
    "bin/message-recorder".source = configs/message-recorder;
  };

  xsession = {
    enable = true;
    windowManager.command = ''
      ${pkgs.i3-gaps}/bin/i3 -c ${i3-config}
    '';
    initExtra = ''
      numlockx
      export I3BLOCKS_DIR=${pkgs.i3blocks-gaps}/libexec/i3blocks
      export I3BLOCKS_CONF_DIR=${builtins.dirOf i3blocks-config}
    '';
  };
}
