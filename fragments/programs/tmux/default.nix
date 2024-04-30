{ config, pkgs, ... }:

let
  mycollection = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "mycollection";
    version = "unstable-2024-04-30";
    src = pkgs.fetchFromGitHub {
      owner = "igsha";
      repo = "tmux-mycollection";
      rev = "b3528484d99aa41d9aafd371ede4147553e5123f";
      hash = "sha256-oCbOwATpLBdyb0pWgEWn3pdcTgHv3dvlTH/8kU22QWA=";
    };
  };

in {
  environment = {
    systemPackages = [ pkgs.tmux ];
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
