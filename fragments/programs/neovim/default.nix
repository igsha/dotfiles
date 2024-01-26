{ pkgs, ... }:

let
  plantuml = pkgs.vimUtils.buildVimPlugin {
    pname = "plantuml";
    version = "2021-09-01";
    src = pkgs.fetchFromGitHub {
      owner = "aklt";
      repo = "plantuml-syntax";
      rev = "405186847a44c16dd039bb644541b4c8fbdab095";
      sha256 = "07s9wjls1rix7wyc2b2nfzsgcqd54slbv64fy7lyv3bkzrbdz8c0";
    };
  };
  smarthomekey = pkgs.vimUtils.buildVimPlugin {
    pname = "smarthomekey";
    version = "2012-10-26";
    src = pkgs.fetchFromGitHub {
      owner = "chenkaie";
      repo = "smarthomekey.vim";
      rev = "d607ad1d2c45869f159481a3cec33732f727d5e1";
      hash = "sha256-DBA/CWo/4b27nNFg56Qm59JrGqUssskQtz2rCgS7BD4=";
    };
  };
  jellybeans = pkgs.vimUtils.buildVimPlugin rec {
    pname = "jellybeans";
    version = "1.7";
    src = pkgs.fetchFromGitHub {
      owner = "nanotech";
      repo = "jellybeans.vim";
      rev = "v${version}";
      hash = "sha256-X+37Mlyt6+ZwfYlt4ZtdHPXDgcKtiXlUoUPZVb58w/8=";
    };
  };
  linediff-vim = pkgs.vimUtils.buildVimPlugin {
    pname = "linediff-vim";
    version = "2023-03-15";
    src = pkgs.fetchFromGitHub {
      owner = "AndrewRadev";
      repo = "linediff.vim";
      rev = "245d16328c47a132574e0fa4298d24a0f78b20b0";
      hash = "sha256-3VxpJpogPFBmo966GB90sQvcj/Ah56lGyR/y/WV3QT0=";
    };
  };

in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      # https://github.com/NixOS/nixpkgs/issues/177375
      customRC = ''
        source ~/.config/nvim/init.lua
      '';
      packages.myVimPackage = {
        start = with pkgs.vimPlugins; [
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
        ];
        opt = [ ];
      };
    };
  };

  home-config.nvim = {
    packages = [ "nvim" ];
    dir = builtins.toString ./home-config;
  };
}
