{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      # https://github.com/NixOS/nixpkgs/issues/177375
      customRC = ''
        source ~/.config/nvim/init.lua
      '';
      packages.myVimPackage = {
        start = pkgs.my-vim-packages-list;
        opt = [ ];
      };
    };
  };

  home-config.nvim = ./home-config;
}
