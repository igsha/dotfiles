{ pkgs }:

let
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
      nmap <Leader>t :TagbarToggle<cr>
      let g:tagbar_left = 1
      let g:tagbar_autoclose = 1
    '';
    easybufferConf = "nmap <Leader>b :EasyBuffer<CR>";
    localvimrcConf = ''
      let g:localvimrc_sandbox = 0
      let g:localvimrc_ask = 0
      let g:localvimrc_name = [ ".lvimrc", ".git/localvimrc" ]
    '';
    buftabsConf = ''
      set laststatus=2
      "let g:buftabs_in_statusline = 0
      let g:buftabs_only_basename = 1
      let g:buftabs_separator = ":"
      let g:buftabs_marker_start = "["
      let g:buftabs_marker_end = "]"
      let g:buftabs_marker_modified = ""
      "set statusline=%{buftabs#statusline()}\ %=%h%m%r\ %-14.(%l,%c%V%)\ %P
    '';
    airlineConf = "let g:airline_section_z = '%3p%% (0x%2B) %#__accent_bold#%4l%#__restore__#:%3c'";
    hybridConf = "let g:hybrid_reduced_contrast = 1";
  };
  bdall = pkgs.vimUtils.buildVimPlugin {
    name = "bdall";
    src = ./configs/nvim/bdall;
  };
  plantuml = pkgs.vimUtils.buildVimPlugin {
    name = "plantuml";
    src = pkgs.fetchFromGitHub {
      owner = "aklt";
      repo = "plantuml-syntax";
      rev = "41eeca5";
      sha256 = "1v11dj4vwk5hyx0zc8qkl0a5wh91zfmwhcq2ndl8zwp78h9yf5wr";
    };
  };

in rec {
  customRC = ''
    ${builtins.readFile configs/nvim/init.vim}
    ${builtins.concatStringsSep "\n" (builtins.attrValues customConfigs)}
  '';

  packages.myVimPackage = with pkgs.vimPlugins; {
    start = [
      ack-vim
      supertab
      tagbar
      vim-localvimrc
      vim-dirdiff
      denite
      airline
      vim-nix
      multiple-cursors
      bdall
      plantuml
    ];
    opt = [ ];
  };
}
