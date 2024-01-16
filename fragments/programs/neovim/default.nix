{ pkgs, ... }:

let
  /*nvimCmd = pkgs.writeScript "nvim-desktop.sh" ''
    #!/usr/bin/env sh
    $TERMINAL --class editor -e nvim "$1"
  '';
  customVim = (pkgs.neovim.override {
    configure = import ./vimrcConfig.nix { inherit (pkgs) vimUtils vimPlugins fetchFromGitHub python3Packages; };
  }).overrideAttrs (old: rec {
    buildCommand = old.buildCommand + ''
      substitute $out/share/applications/nvim.desktop $out/share/applications/nvim.desktop \
        --replace 'Exec=nvim' "Exec=${nvimCmd} %U"
    '';
  });*/
  customConfigs = {
    ackConf = ''
      nnoremap <Leader>q :cclose<CR>
      nnoremap <Leader>n :cnext<CR>
      nnoremap <Leader>p :cprev<CR>
      nnoremap <Leader>o :copen<CR>
      nnoremap <Leader>g :Ack<CR>
      command -nargs=* AckWord :Ack <cword> <args>
    '';
    tagbarConf = ''
      nnoremap <Leader>t :TagbarToggle<cr>
      let g:tagbar_left = 0
      let g:tagbar_autoclose = 1
    '';
    localvimrcConf = ''
      let g:localvimrc_sandbox = 0
      let g:localvimrc_ask = 0
      let g:localvimrc_name = [ ".lvimrc", ".git/localvimrc" ]
    '';
    airlineConf = "let g:airline_section_z = '%3p%% (0x%2B) %#__accent_bold#%4l%#__restore__#:%3c'";
    hybridConf = "let g:hybrid_reduced_contrast = 1";
    buffergator = ''
      let g:buffergator_suppress_keymaps = 1
      let g:buffergator_viewport_split_policy = 'T'
      nnoremap <Leader>b :BuffergatorToggle<CR>
    '';
    color = ''
      colorscheme jellybeans
      let g:jellybeans_overrides = {'background':{'ctermbg':'none','256ctermbg':'none','guibg':'none'}}
      set background=
    '';
  };
  vimCustom = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-custom";
    version = "2022-03-22";
    src = ./vim-custom;
  };
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
      customRC = ''
        ${builtins.readFile ./init.vim}
        ${builtins.concatStringsSep "\n" (builtins.attrValues customConfigs)}
      '';
      packages.myVimPackage = {
        start = with pkgs.vimPlugins; [
          ack-vim
          supertab
          tagbar
          vim-localvimrc
          vim-dirdiff
          denite
          airline
          vim-nix
          multiple-cursors
          vimCustom
          plantuml
          vim-buffergator
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
}
