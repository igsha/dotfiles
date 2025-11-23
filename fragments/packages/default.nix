{ pkgs, ... }:

{
  environment = {
    homeBinInPath = true;
    systemPackages = with pkgs; [
      subversion
      ed inotify-tools
      catimg
      man stdman man-pages man-pages-posix
      util-linux freetype
      lm_sensors
      ripgrep
      psmisc
      fzf direnv
      sqlite
      syslinux
      dmidecode lshw smartmontools pciutils usbutils inxi
      htop atop iotop lsof inetutils
      sysstat connect corkscrew torsocks socat wakelan
      pv
      tree file which mkpasswd
      openssl
      ocamlPackages.csv
      vifm
      fuse fuseiso curlftpfs jmtpfs sshfs archivemount rar2fs encfs afuse
      pwgen
      dhex vbindiff hexyl hecate hexcurse
      universal-ctags
      unrar unzipNLS zip p7zip
      wcalc jq jo yq htmlq
      ntfs3g gparted xfsprogs
      libxml2
      ponysay
      fakeroot fakechroot debootstrap proot
      transmission_4
      parallel
      ncdu
      tio
      patchutils
      moreutils
      trash-cli
      nix-bash-completions bash-completion
      gptfdisk parted
      cdrtools
      mesa-demos
      cpufrequtils
      python3Packages.jsbeautifier
      openldap
      poke
      hydra-check
      novnc tigervnc
      zx cling
      nh nix-output-monitor nvd
      pavucontrol
      fd
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowTexliveBuilds = true;
      android_sdk.accept_license = true;
      zathura.useMupdf = false;
    };
  };

  services.smartd.notifications = {
    x11.enable = true;
    wall.enable = true;
  };

  home-config.packages = ./home-config;
}
