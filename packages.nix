{ config, pkgs, ... }:

{
  nixpkgs.config = {
    packageOverrides = import ./packages;

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
    neovim ed
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
    youtube-dl
    libxml2
    ponysay ponymix
    fakeroot fakechroot debootstrap
    transmission
    maim
    sdcv
    elinks
    httpie
    parallel
    mcomix
    gnupg
    rtags
    ncdu
    androidsdk android-udev-rules
    screen
    patchutils
    samba
    pass
    pypi2nix cabal2nix cabal-install
    moreutils
    trash-cli
    nix-bash-completions
    gptfdisk parted
    cdrtools
    # X11
    xsel xclip xdotool
    xlibs.xhost hsetroot xorg.xev xorg.xkill
    dmenu
    xfontsel
    xorg.xwininfo
    glxinfo
    xchm
    # gui
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
    virtinst virtmanager virt-viewer
  ];
}
