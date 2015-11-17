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
    build = "wine32";
  };

  packageOverrides = pkgs_: with pkgs_; with pkgs; {
    mybase = buildEnv {
      name = "mybase";
      paths = [
        smartmontools pciutils
        utillinuxCurses freetype
        gitAndTools.gitflow tig
        lm_sensors
        vim_configurable
        ack
        psmisc
        xdg_utils
        numlockx
        xorg.xev
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
        cinnamon.zenity
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
      ];
    };

    mytools = buildEnv {
      name = "mytools";
      paths = [
        vifm
        truecrypt
        fuse fuseiso fuse_zip fuse-7z-ng
        archivemount
        pwgen
        bviplus dhex ctags vbindiff
        file
        unrar unzip
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
      ];
    };

  };
}

