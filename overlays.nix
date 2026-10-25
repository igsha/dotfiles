final: prev:

{
  my-tmux-plugins = prev.buildEnv {
    name = "my-tmux-plugins";
    paths = with prev.tmuxPlugins; [
      prefix-highlight
      sidebar
      urlview
      yank
      pain-control
      logging
      open
      copycat
      mycollection
    ];
    pathsToLink = [ "/share" ];
  };

  vimPlugins = prev.vimPlugins // {
    plantuml = prev.vimUtils.buildVimPlugin {
      pname = "plantuml";
      version = "2021-09-01";
      src = prev.fetchFromGitHub {
        owner = "aklt";
        repo = "plantuml-syntax";
        rev = "405186847a44c16dd039bb644541b4c8fbdab095";
        sha256 = "07s9wjls1rix7wyc2b2nfzsgcqd54slbv64fy7lyv3bkzrbdz8c0";
      };
    };
    smarthomekey = prev.vimUtils.buildVimPlugin {
      pname = "smarthomekey";
      version = "2012-10-26";
      src = prev.fetchFromGitHub {
        owner = "chenkaie";
        repo = "smarthomekey.vim";
        rev = "d607ad1d2c45869f159481a3cec33732f727d5e1";
        hash = "sha256-DBA/CWo/4b27nNFg56Qm59JrGqUssskQtz2rCgS7BD4=";
      };
    };
    jellybeans = prev.vimUtils.buildVimPlugin rec {
      pname = "jellybeans";
      version = "1.7";
      src = prev.fetchFromGitHub {
        owner = "nanotech";
        repo = "jellybeans.vim";
        rev = "v${version}";
        hash = "sha256-X+37Mlyt6+ZwfYlt4ZtdHPXDgcKtiXlUoUPZVb58w/8=";
      };
    };
    linediff-vim = prev.vimUtils.buildVimPlugin {
      pname = "linediff-vim";
      version = "2023-03-15";
      src = prev.fetchFromGitHub {
        owner = "AndrewRadev";
        repo = "linediff.vim";
        rev = "245d16328c47a132574e0fa4298d24a0f78b20b0";
        hash = "sha256-3VxpJpogPFBmo966GB90sQvcj/Ah56lGyR/y/WV3QT0=";
      };
    };
    supertab = prev.vimPlugins.supertab.overrideAttrs (old: {
      version = "2025-04-02";
      src = prev.fetchFromGitHub {
        owner = "ervandew";
        repo = "supertab";
        rev = "6ce779367e2c4947367fcce401b77251d2bb47ab";
        hash = "sha256-1le+8GVWSN2rHp9yqK4TKTBqGyd5UStbncVRHLFCQFE=";
      };
    });
  };

  my-vim-packages-list = with final.vimPlugins; [
    supertab
    tagbar
    vim-dirdiff
    denite-nvim
    vim-airline
    vim-nix
    vim-multiple-cursors
    plantuml
    vim-grammarous
    smarthomekey
    jellybeans
    linediff-vim
    telescope-nvim
    nvim-treesitter
    nvim-treesitter-parsers.vala
    vim-gnupg
    vim-tmux-clipboard
  ];

  # TODO: broken
  # max = final.nixpkgs-2605.callPackage ./max { };
  max = prev.makeDesktopItem {
    name = "max";
    desktopName = "MAX";
    exec = "google-chrome --app=https://web.max.ru";
    terminal = false;
    icon = "my-app-icon";
    categories = [ "Chat" "Network" "InstantMessaging" ];
  };
  aladdin-2fa = prev.callPackage ./aladdin-2fa { };
  tgwsproxy = prev.callPackage ./swgt { };

  # TODO: need > qt-6.12 to fix crash issue
  #qutebrowser = prev.qutebrowser.override {
  #  qt6Packages = final.nixpkgs-2605.qt6Packages;
  #  python3 = final.nixpkgs-2605.python3;
  #};

  # TODO: https://github.com/NixOS/nixpkgs/issues/575192
  linuxPackages = prev.linuxPackages.extend (lf: lp: {
    rtl88x2bu = lp.rtl88x2bu.overrideAttrs (old: {
      makeFlags = old.makeFlags ++ [
        "INSTALL_MOD_PATH=${placeholder "out"}"
        "INSTALL_MOD_DIR=kernel/drivers/misc"
        "DEPMOD=true"
      ];
      installFlags = [
        "-C"
        "${lp.kernel.dev}/lib/modules/${lp.kernel.modDirVersion}/build"
        "M=$(PWD)"
      ];
      installTargets = [ "modules_install" ];
      installPhase = "";
    });
    xpad-noone = lp.xpad-noone.overrideAttrs (old: {
      makeFlags = old.makeFlags ++ [
        "INSTALL_MOD_PATH=${placeholder "out"}"
        "INSTALL_MOD_DIR=kernel/drivers/misc"
        "DEPMOD=true"
      ];
      installFlags = [
        "-C"
        "${lp.kernel.dev}/lib/modules/${lp.kernel.modDirVersion}/build"
        "M=$(PWD)"
      ];
      installTargets = [ "modules_install" ];
      installPhase = "";
    });
  });

  # TODO:
  #qt6 = prev.qt6.overrideScope (qtFinal: qtPrev: {
  #  qtlottie = qtPrev.qtlottie.overrideAttrs (oldAttrs: {
  #    propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ qtFinal.qtquicktimeline ];
  #  });
  #});
}
