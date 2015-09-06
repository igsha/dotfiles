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

  packageOverrides = pkgs_: with pkgs_; {
    all = with pkgs; buildEnv {
      name = "all";
      paths = [
        skype firefoxWrapper thunderbird
        zathura
        gcc gnumake cmake
        smartmontools pciutils pavucontrol truecrypt vifm vlc
        ctags
        utillinuxCurses freetype fuse pwgen
        gitAndTools.gitflow
        vim_configurable
        archivemount
        bvi dhex
        dropbox-cli
        file
        inkscape
        lm_sensors
        nox
        ack
        psmisc
        sxiv
        tig
        transmission
        unrar
        unzip
        vbindiff
        winetricks
        wineStaging
        xdg_utils
        xflux
        xournal
        zathura
        ffmpeg-full
        scrot
        sdcv
        cinnamon.zenity
        galculator
        elinks
      ];
    };

    latexenv = with pkgs; buildEnv {
      name = "latexenv";
      paths = [
        texLiveFull
        imagemagick
        ghostscript
      ];
    };

  };
}

