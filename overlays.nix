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
    denite
    airline
    vim-nix
    multiple-cursors
    plantuml
    vim-grammarous
    smarthomekey
    jellybeans
    csv
    editorconfig-vim
    linediff-vim
    telescope-nvim
    nvim-treesitter
    nvim-treesitter-parsers.vala
    vim-gnupg
    vim-tmux-clipboard
  ];
}
