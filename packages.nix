{ config, pkgs, ... }:

{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      qutebrowser = pkgs.qutebrowser.overrideAttrs (oldAttrs: rec {
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.libGL ];
        postFixup = oldAttrs.postFixup + ''
          wrapProgram $out/bin/qutebrowser --suffix LD_LIBRARY_PATH : "${pkgs.libGL}/lib"
          sed -i 's/\.qutebrowser-wrapped/qutebrowser/' $out/bin/..qutebrowser-wrapped-wrapped
        '';
      });

      clawsMail = pkgs.clawsMail.override {
        enablePluginFancy = true;
        enablePluginVcalendar = true;
        enableSpellcheck = true;
        enablePluginRssyl = true;
        enablePluginPdf = true;
        webkitgtk24x-gtk2 = pkgs.webkitgtk;
      };

      matplotlib = pkgs.python3Packages.matplotlib.overrideAttrs (oldAttrs: rec {
        enableQt = true;
      });
    };

    allowUnfree = true;
    virtualbox.enableExtensionPack = true;
    firefox.enableAdobeFlash = true;
    chromium.enablePepperFlash = true;
    allowTexliveBuilds = true;
    permittedInsecurePackages = [
      "polipo-1.1.1"
    ];
  };

  environment.etc = {
    "fuse.conf".text = ''
      user_allow_other
    '';
  };

  environment.systemPackages = with pkgs; [
    stdenv gnumake
    gitFull subversion
    wget
    xsel xclip xdotool
    neovim ed
    xlibs.xhost hsetroot xorg.xev xorg.xkill
    dmenu nox
    xfontsel
    man stdman man-pages posix_man_pages
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
    ocamlPackages.csv
    vifm fuse fuseiso fuse-7z-ng curlftpfs jmtpfs sshfsFuse archivemount
    pwgen
    bviplus dhex vbindiff
    universal-ctags
    unrar unzip zip p7zip
    wcalc jq
    ntfs3g gparted xfsprogs
    xchm
    youtube-dl
    libxml2
    ponysay ponymix
    fakeroot fakechroot debootstrap
    transmission
    wine winetricks
    maim
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
    screen
    nix-repl
    patchutils
    samba
    pass
    pypi2nix cabal2nix cabal-install
    moreutils
    xorg.xwininfo
    trash-cli
    nix-bash-completions
    gptfdisk parted
    cdrtools
    # gui
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
    virtinst virtmanager virt-viewer
  ];
}
