{ pkgs, user, email }:

let
  packagesPath = builtins.toPath ./packages/default.nix;
  nixpkgsConfig = builtins.replaceStrings [ "./packages" ] [ packagesPath ] (builtins.readFile ./nixpkgs-config.nix);
  i3blocks-config = builtins.toPath ./templates/i3blocks.conf;
  i3-config = builtins.toPath ./templates/i3.conf;

in rec {
  home = {
    packages = with pkgs; [
      atool
      wine winetricks
      davmail
      mpv
      pavucontrol
      pqiv
      inkscape krita
      xournal
      zathura
      ffmpeg-full
      freerdp
      thunderbird
      abiword
      neovim-qt
      tdesktop
      qutebrowser flashplayer-standalone google-chrome
      #virtmanager virt-viewer
      mcomix
      maim
      gnome3.evolution
      libreoffice-fresh

      i3-gaps
      feh xterm davmail numlockx i3blocks-gaps metar yad ack metar xkb_switch i3lock-fancy libnotify
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
    network-manager-applet.enable = true;
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
          context = "ctrl+shift+period";
        };
      };
    };
  };

  nixpkgs.config = import ./nixpkgs-config.nix;

  xdg.configFile."nixpkgs/config.nix".text = nixpkgsConfig;
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
    ".themes/urxvt".source = builtins.fetchTarball https://api.github.com/repos/felixr/urxvt-color-themes/tarball/master;
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
