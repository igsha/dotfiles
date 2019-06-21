{ config, pkgs, ... }:

{
  nixpkgs.config = import ./nixpkgs-config.nix;

  system.extraDependencies = with pkgs; [
    gccenv.env
    pythonenv.env
    pandocenv.env
    latexenv.env
    luaenv.env
  ];

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
    wcalc jq jo
    ntfs3g gparted xfsprogs
    youtube-dl
    libxml2
    ponysay ponymix
    fakeroot fakechroot debootstrap
    transmission
    sdcv
    links2
    httpie
    parallel
    gnupg
    rtags
    ncdu
    android-udev-rules
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
    taskwarrior
    glxinfo
    xdg_utils
    powerline-go
  ];
}
