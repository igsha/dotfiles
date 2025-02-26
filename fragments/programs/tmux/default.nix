{ pkgs, ... }:

{
  environment = {
    defaultPackages = [ pkgs.tmux ];
    # need to use /run/current-system/sw/share
    etc.tmux.source = pkgs.my-tmux-plugins;
  };

  home-config.tmux = ./home-config;
}
