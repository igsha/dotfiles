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
        nox
        vim_configurable
        ack
        psmisc
        xdg_utils
        xkb_switch
      ];
    };

    mygui = buildEnv {
      name = "mygui";
      paths = [
        firefoxWrapper thunderbird
        vlc
        pavucontrol
        sxiv viewnior
        mpv
        dropbox-cli
        inkscape
        xournal
        zathura
        ffmpeg-full
        cinnamon.zenity
        galculator
      ];
    };

    mymisc = buildEnv {
      name = "mymisc";
      paths = [
        transmission
        wine winetricks
        xflux
        scrot
        sdcv
        elinks
        httpie
        parallel
        ctags
        vbindiff
      ];
    };

    mytools = buildEnv {
      name = "mytools";
      paths = [
        vifm
        truecrypt
        fuse fuseiso
        archivemount
        pwgen
        bviplus dhex
        file
        unrar unzip
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
        perl-biber
      ];
    };

  };
}

