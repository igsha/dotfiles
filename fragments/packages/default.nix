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
      (final: prev: with final; {
        qutebrowser = unstable.qutebrowser.override { enableVulkan = false; };
        mpv-unwrapped = unstable.mpv-unwrapped; # need for unstable.qutebrowser
        wrapMpv = unstable.wrapMpv.override { yt-dlp = final.yt-dlp; }; # need for mpv
        telegram-desktop = unstable.telegram-desktop;
        yt-dlp = unstable.yt-dlp.overridePythonAttrs (old: rec { # need for mpv
          propagatedBuildInputs = old.propagatedBuildInputs ++ [ unstable.python3Packages.lxml ];
          postPatch = ''
            cp ${./user_extractors.py} yt_dlp/extractor/user_extractors.py
            echo "from .user_extractors import *" >> yt_dlp/extractor/_extractors.py
          '';
        });
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
