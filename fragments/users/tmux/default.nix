{ pkgs, ... }:

{
  environment = {
    defaultPackages = [ pkgs.tmux ];
    # need to use /run/current-system/sw/share
    etc.tmux.source = pkgs.symlinkJoin {
      name = "tmux-plugins";
      paths = with pkgs.tmuxPlugins; [
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
    };
  };

  home-config.tmux = {
    packages = [ "tmux" ];
    dir = builtins.toString ./home-config;
  };
}
