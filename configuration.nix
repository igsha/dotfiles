# use it in /etc/nixos/configuration.nix:
# imports = [ /home/user/.dotfiles/configuration.nix ];

{ config, pkgs, ... }:

with import ./nixpkgs/langenv.nix { inherit pkgs; };
{
  boot.loader = {
    grub.device = "/dev/sda";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos-pc";
    networkmanager.enable = true;
    connman = {
      enable = false;
      enableVPN = true;
    };
    wireless = {
      enable = false;
      networks = {
        SomeNetwork = {
          psk = "SomePassword";
        };
      };
      userControlled.enable = true;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    virtualbox.enableExtensionPack = true;
    firefox.enableAdobeFlash = true;
    chromium.enablePepperFlash = true;
    allowTexliveBuilds = true;
    wine.release = "unstable";
  };

  environment.systemPackages = with pkgs; [
    stdenv gnumake
    gitFull subversion
    wget
    xsel xclip xdotool
    neovim
    ed
    xscreensaver
    rxvt_unicode-with-plugins
    xlibs.xhost unclutter hsetroot xorg.xev xorg.xkill
    dmenu nox
    xfontsel
    man stdman man-pages posix_man_pages
    numlockx xkb_switch
    i3pystatus
    utillinuxCurses freetype
    gitAndTools.gitflow tig
    lm_sensors
    ack silver-searcher
    psmisc
    xdg_utils
    fzf
    pythonPackages.glances
    syslinux
    dmidecode lshw smartmontools pciutils usbutils
    htop iotop lsof inetutils
    mtr nethogs ngrep nmap bind iftop iptraf wireshark-cli proxychains
    sysstat dstat connect corkscrew torsocks socat wakelan
    pv
    tree file which mkpasswd
    openssl encfs
    dunst libnotify
    ocamlPackages.csv
    vifm
    fuse fuseiso fuse-7z-ng curlftpfs jmtpfs sshfsFuse archivemount
    pwgen
    bviplus
    dhex vbindiff
    universal-ctags
    unrar unzip zip p7zip
    python27Packages.pymetar
    wcalc jq
    xterm
    ntfs3g gparted xfsprogs
    tmux
    xchm
    youtube-dl
    libxml2
    ponysay
    ponymix
    fakeroot fakechroot debootstrap
    transmission
    wine winetricks
    scrot maim
    sdcv
    elinks
    httpie
    parallel
    mcomix
    glxinfo
    gnupg
    rtags
    ncdu
    androidsdk android-udev-rules
    screen tmux
    nix-repl
    patchutils
    samba
    pass
    pypi2nix cabal2nix cabal-install
    moreutils
    xorg.xwininfo
    trash-cli
    # gui
    davmail
    mpv
    pavucontrol
    gpicview
    dropbox-cli
    inkscape gimp
    xournal
    zathura
    ffmpeg-full
    freerdp
    (clawsMail.override {
      enablePluginFancy = true;
      enablePluginVcalendar = true;
      enableSpellcheck = true;
      enablePluginRssyl = true;
      enablePluginPdf = true;
      webkitgtk24x-gtk2 = webkitgtk216x;
    })
    libreoffice
    neovim-qt
    flashplayer-standalone
    networkmanagerapplet
    skype tdesktop
    google-chrome
    ((qutebrowser.overrideAttrs (oldAttrs: rec {
      postFixup = oldAttrs.postFixup + ''
        sed -i 's/\.qutebrowser-wrapped/qutebrowser/' $out/bin/..qutebrowser-wrapped-wrapped
      '';
    })).override {
      withWebEngineDefault = true;
    })
    # self packed
    #(import ./nixpkgs/qutebrowser/requirements.nix { }).packages.qutebrowser
    (import ./nixpkgs/thefuck/requirements.nix { }).packages.thefuck
  ] ++ my-environments;

  environment.etc = {
    "fuse.conf".text = ''
      user_allow_other
    '';
  };

  services = {
    openssh = {
      enable = true;
      forwardX11 = true;
      extraConfig = ''
        AllowTcpForwarding yes
        TCPKeepAlive yes
        PermitTunnel yes
      '';
    };
    openntpd.enable = true;
    printing.enable = true;
    nixosManual.showManual = true;
    tor.enable = true;
    atd.enable = true;
    redshift = {
      enable = true;
      latitude = "55.749792";
      longitude = "37.6324949";
    };
    polipo = {
      enable = true;
    };
    journald = {
      extraConfig = "SystemMaxUse=4G";
    };
    geoclue2.enable = true;
    teamviewer.enable = false;
    urxvtd.enable = true;
    xserver = {
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

      displayManager.slim = {
        enable = true;
      };

      windowManager = {
        default = "i3";
        i3 = {
          enable = true;
          package = pkgs.i3-gaps;
        };
      };
    };
    compton = {
      enable = true;
      vSync = "opengl";
      # https://github.com/chjj/compton/issues/152
      extraOptions = ''
        xrender-sync = true
        xrender-sync-fence = true
      '';
    };
    actkbd = {
      enable = true;
    };
    rogue.enable = true;
    logind.extraConfig = ''
      IdleAction=suspend
      IdleActionSec=30min
    '';
  };

  sound.mediaKeys.enable = true;

  virtualisation = {
    virtualbox.host.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      s3tcSupport = true;
      extraPackages = [ pkgs.vaapiVdpau ];
    };
    pulseaudio = {
      enable = true;
      systemWide = true;
      support32Bit = true;
      daemon.config = {
        flat-volumes = "no";
      };
    };
  };

  time.timeZone = "Europe/Moscow";

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
      terminus_font_ttf
      ttf_bitstream_vera
      inconsolata-lgc
      google-fonts
      anonymousPro
    ];
  };

  systemd.coredump = {
    enable = true;
    extraConfig = "Storage=external";
  };

  security = {
    sudo.enable = true;
    pam.loginLimits = [
      { domain = "*"; type = "hard"; item = "core"; value = "unlimited"; }
      { domain = "*"; type = "soft"; item = "core"; value = "unlimited"; }
    ];
    polkit.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "Fri 20:00";
    };
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
    '';
  };

  system.autoUpgrade = {
    enable = true;
    dates = "Fri 20:00";
  };

  programs.bash = {
    enableCompletion = true;
    shellAliases = {
      ls = "ls -h --color";
      "ls.pure" = "`which ls`";
      la = "ls -lta";
      ll = "ls -lt";
      grep = "grep --color";
      cal = "cal -m3";
      df = "df -h";
      wineru = "LC_ALL=ru_RU.UTF-8 wine";
      wineru64 = "WINEARCH=win64 WINEPREFIX=~/.wine64 wineru";
      fix = "TF_CMD=$(TF_ALIAS=fuck PYTHONIOENCODING=utf-8 TF_SHELL_ALIASES=$(alias) thefuck $(fc -ln -1)) && eval $TF_CMD && history -s $TF_CMD";
    };
    loginShellInit = ''
      export HISTCONTROL=ignoredups
      unset SSH_ASKPASS
      export EDITOR=nvim
      export BROWSER=qutebrowser
      export PDFVIEWER=zathura
      export PSVIEWER=$PDFVIEWER
      export DVIVIEWER=$PDFVIEWER
      export TERMINAL=urxvtc
    '';
  };
}
