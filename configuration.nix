# use it in /etc/nixos/configuration.nix:
# imports = [ /home/user/.dotfiles/configuration.nix ];

{ config, pkgs, ... }:

{
  boot.loader = {
    grub.device = "/dev/sda";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos-pc";
    networkmanager.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    virtualbox.enableExtensionPack = true;
    firefox.enableAdobeFlash = true;
    chromium.enablePepperFlash = true;
    allowTexliveBuilds = true;
    wine.release = "stable";
  };

  environment.systemPackages = with pkgs; [
    stdenv
    gitFull subversion
    wget
    xsel xclip xdotool
    neovim
    ed
    cmake
    gnumake
    xscreensaver
    rxvt_unicode-with-plugins
    xlibs.xhost unclutter hsetroot xorg.xev xorg.xkill
    dmenu nox
    wpa_supplicant_gui
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
    python27Packages.glances
    syslinux
    dmidecode lshw smartmontools pciutils usbutils
    htop iotop lsof inetutils
    mtr nethogs ngrep nmap bind iftop iptraf wireshark-cli proxychains
    sysstat dstat connect corkscrew torsocks socat
    pv
    xcompmgr
    tree file which mkpasswd
    openssl encfs
    dunst libnotify
    ocamlPackages.csv
    vifm
    fuse fuseiso fuse_zip fuse-7z-ng curlftpfs jmtpfs sshfsFuse archivemount fusesmb
    pwgen
    bviplus
    dhex ctags vbindiff
    unrar unzip zip p7zip
    python27Packages.pymetar
    wcalc jq
    xterm
    ntfs3g gparted xfsprogs
    tmux
    wakelan
    xchm
    python27Packages.youtube-dl
    libxml2
    ponysay
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
    pandoc
    patchutils
    samba4Full
    # gui
    davmail qutebrowser
    vlc mpv
    pavucontrol
    sxiv viewnior
    dropbox-cli
    inkscape gimp
    xournal
    zathura
    ffmpeg-full
    freerdp
    (clawsMail.override { enablePluginFancy = true; enablePluginVcalendar = true; enableSpellcheck = true; })
    libreoffice
    kde4.kruler
    neovim-qt
    flashplayer
    networkmanagerapplet
    skype tdesktop
    # latex
    (texlive.combine { inherit (texlive) scheme-full metafont; })
    imagemagick
    ghostscript
    poppler_utils
    biber
    gnuplot
    wdiff
    gnome3.libgxps
    aspell aspellDicts.en aspellDicts.ru
  ];

  services = {
    openssh = {
      enable = true;
      forwardX11 = true;
    };
    ntp.enable = true;
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
      socksParentProxy = "localhost:9050";
    };
    journald = {
      extraConfig = "SystemMaxUse=4G";
    };
    geoclue2.enable = true;
    samba = {
      enable = true;
      package = pkgs.samba4Full;
    };
    teamviewer.enable = true;
  };

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
      extraConfig = ''
        flat-volumes = no
      '';
    };
  };

  services.xserver = {
    autorun = true;
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:sclk_toggle,grp:shift_caps_toggle,grp_led:scroll,keypad:pointerkeys";

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
      i3.enable = true;
    };
  };

  time.timeZone = "Europe/Moscow";

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    enableCoreFonts = true;
    fontconfig.defaultFonts.monospace = ["Terminus"];
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      freefont_ttf
      terminus_font
      ttf_bitstream_vera
      inconsolata-lgc
    ];
  };

  programs.bash.enableCompletion = true;

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
      dates = "08:00";
    };
    extraOptions = ''
      gc-keep-outputs = true
      gc-keep-derivations = true
    '';
  };
}
