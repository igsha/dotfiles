{ pkgs }:

with pkgs;
let
  customNeovim = (neovim.override {
    configure = import ./vimrcConfig.nix { inherit (pkgs) vimUtils vimPlugins fetchFromGitHub python3Packages; };
  }).overrideAttrs (old: rec {
    buildCommand = old.buildCommand + ''
      substitute $out/share/applications/nvim.desktop $out/share/applications/nvim.desktop \
        --replace 'Exec=nvim' "Exec=termite --class editor -e nvim"
    '';
  });

in [
  stdenv gnumake
  gitFull subversion
  wget
  customNeovim ed aerc
  catimg
  man stdman man-pages posix_man_pages
  utillinuxCurses freetype
  gitAndTools.gitflow tig
  lm_sensors
  ack silver-searcher
  psmisc
  fzf
  syslinux
  dmidecode lshw smartmontools pciutils usbutils
  htop iotop lsof inetutils
  mtr nethogs ngrep nmap bind iftop wireshark-cli proxychains tcpdump proxytunnel
  sysstat dstat connect corkscrew torsocks socat wakelan
  pv
  tree file which mkpasswd
  openssl encfs
  ocamlPackages.csv
  vifm fuse fuseiso fuse-7z-ng curlftpfs jmtpfs sshfsFuse archivemount
  pwgen
  bviplus dhex vbindiff
  universal-ctags
  unrar unzipNLS zip p7zip
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
  moreutils
  trash-cli
  nix-bash-completions bash-completion
  gptfdisk parted
  cdrtools
  glxinfo
  xdg_utils
  powerline-go
  virtviewer virtmanager
  xf86_input_wacom libwacom wacomtablet
  cpufrequtils
  nixFlakes
  python3Packages.jsbeautifier
]
