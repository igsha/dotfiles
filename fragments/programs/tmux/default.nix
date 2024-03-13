{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "screen-256color";
    keyMode = "vi";
    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    plugins = with pkgs.tmuxPlugins; [
      prefix-highlight
      sidebar
      urlview
      yank
      pain-control
      logging
      open
      copycat
      sysstat
      net-speed
    ];
    extraConfigBeforePlugins = ''
      set -g status-right '#{prefix_highlight} #{sysstat_cpu} #{sysstat_mem}[#{sysstat_swap}] #{net_speed} | %a %Y-%m-%d %H:%M | #H'
    '';
  };

  home-config.tmux = {
    packages = [ "tmux" ];
    dir = builtins.toString ./home-config;
  };
}
