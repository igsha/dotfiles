{ config, pkgs, ... }:

let
  mycollection = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "mycollection";
    version = "unstable-2024-05-01";
    src = pkgs.fetchFromGitHub {
      owner = "igsha";
      repo = "tmux-mycollection";
      rev = "8288f8d89dc74a3f797976cbeb63ac7aa156d490";
      hash = "sha256-VJXvcQBFYPwvO1dKN/N5+LsD0h3hP2PmShvChEglDcQ=";
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
