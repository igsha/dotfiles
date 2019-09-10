{ pkgs, user, email }:

{
  home = {
    packages = with pkgs; [
      atool
      winetricks wineWowPackages.full
      xst
      mpv
      pavucontrol
      (imv.overrideAttrs (old: { buildInputs = old.buildInputs ++ [ librsvg ]; }))
      inkscape krita mypaint
      kpcli
      zathura
      ffmpeg-full
      freerdp
      tdesktop
      qutebrowser flashplayer-standalone google-chrome
      gnome3.evolution
      libreoffice-still
      skypeforlinux
      steam
      xsel xclip xdotool
      xlibs.xhost hsetroot xorg.xev xorg.xkill
      xfontsel
      xorg.xwininfo
      davmail yad ack libnotify dropbox slack-dark iplay
    ];
    keyboard = {
      layout = "us,ru";
      options = [ "grp:sclk_toggle" "grp:shift_caps_toggle" "grp_led:scroll" "keypad:pointerkeys" ];
    };
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
    "bin/color-tester".source = configs/color-tester.sh;
  };
}
