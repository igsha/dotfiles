{ pkgs, ... }:

{
  environment = {
    homeBinInPath = true;
    systemPackages = with pkgs; [
      subversion tig
      wget links2 httpie
      ed
      catimg
      man stdman man-pages man-pages-posix
      util-linux freetype
      lm_sensors
      ripgrep
      psmisc
      fzf direnv
      sqlite
      syslinux
      dmidecode lshw smartmontools pciutils usbutils
      htop atop iotop lsof inetutils
      mtr nethogs ngrep nmap bind iftop wireshark-cli tcpdump
      sysstat dstat connect corkscrew torsocks socat wakelan
      pv
      tree file which mkpasswd
      openssl
      ocamlPackages.csv
      vifm
      fuse fuseiso curlftpfs jmtpfs sshfs-fuse archivemount rar2fs encfs
      pwgen
      bviplus dhex vbindiff hexyl hecate hexcurse
      universal-ctags
      unrar unzipNLS zip p7zip
      wcalc jq jo yq htmlq
      ntfs3g gparted xfsprogs
      libxml2
      ponysay
      fakeroot fakechroot debootstrap
      transmission
      parallel
      gnupg
      ncdu
      android-udev-rules
      tio
      patchutils
      samba
      pass
      moreutils
      trash-cli
      nix-bash-completions bash-completion
      gptfdisk parted
      cdrtools
      glxinfo
      cpufrequtils
      python3Packages.jsbeautifier
      openldap cifs-utils
      poke
      hydra-check
      stow
      novnc tigervnc
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowTexliveBuilds = true;
      android_sdk.accept_license = true;
      zathura.useMupdf = false;
      permittedInsecurePackages = [
        "python3.10-tensorflow-2.11.1"
        "tensorflow-2.11.1"
        "tensorflow-2.11.1-deps.tar.gz"
      ];
    };
    overlays = [
      (import (builtins.fetchTarball https://api.github.com/repos/igsha/nix-overlays/tarball/master))
      (_: _: { unstable = import <unstable> {}; })
      (final: prev: {
        qutebrowser = prev.unstable.qutebrowser;
        betterbird = prev.unstable.betterbird;
      })
    ];
  };

  services.smartd.notifications = {
    x11.enable = true;
    wall.enable = true;
  };

  home-config.packages = {
    packages = [ "vifm" "wcalc" "gdb" ];
    dir = builtins.toString ./home-config;
  };
}
