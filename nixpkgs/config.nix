{
  allowUnfree = true;
  virtualbox.enableExtensionPack = true;
  firefox = {
    enableAdobeFlash = true;
  };
  chromium = {
    enablePepperFlash = true;
  };
  allowTexliveBuilds = true;
  wine = {
    release = "unstable";
    build = "wineWow";
  };
  nix.useChroot = true;

  packageOverrides = pkgs_: with pkgs_; with pkgs; {
    mybase = buildEnv {
      name = "mybase";
      paths = [
        smartmontools pciutils
        utillinuxCurses freetype
        gitAndTools.gitflow tig
        lm_sensors
        vim_configurable
        ack silver-searcher
        psmisc
        xdg_utils
        numlockx
        xorg.xev
        fzf
        python27Packages.glances
        syslinux
        dmidecode lshw
        dstat
        mtr
        nethogs ngrep
        sysstat
        usbutils
        pv
        xcompmgr
        tree
        openssl
        dunst libnotify
        encfs
        nmap
        ocamlPackages.csv
        xss-lock
        bind
      ];
    };

    mygui = buildEnv {
      name = "mygui";
      paths = [
        firefoxWrapper thunderbird davmail
        vlc
        pavucontrol
        sxiv viewnior
        mpv
        dropbox-cli
        inkscape gimp
        xournal
        zathura
        ffmpeg-full
        freerdp
        qutebrowser clawsMail
      ];
    };

    mymisc = buildEnv {
      name = "mymisc";
      paths = [
        transmission
        wine winetricks
        scrot
        sdcv
        elinks
        httpie
        parallel
        mcomix
        glxinfo
        gnupg
        radare2
        rtags
        ncdu
      ];
    };

    mytools = buildEnv {
      name = "mytools";
      paths = [
        vifm
        truecrypt
        fuse fuseiso fuse_zip fuse-7z-ng curlftpfs jmtpfs sshfsFuse
        archivemount
        pwgen
        bviplus dhex ctags vbindiff
        file
        unrar unzip zip p7zip
        python27Packages.pymetar
        wcalc
        xterm
        iftop iptraf wireshark-cli
        jq
        ntfs3g gparted xfsprogs
        tmux
        wakelan
        xchm
        python27Packages.youtube-dl
        libxml2
        ponysay
        fakeroot fakechroot debootstrap
      ];
    };

    myheavy = buildEnv {
      name = "myheavy";
      paths = [
        libreoffice
      ];
    };

    latexenv = buildEnv {
      name = "latexenv";
      paths = [
        texLiveFull
        imagemagick
        ghostscript
        cmake
        gnumake
        poppler_utils
        biber
        gnuplot
        wdiff
        gnome3.libgxps
      ];
    };
  };
}

