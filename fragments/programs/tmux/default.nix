{ config, pkgs, ... }:

let
  loadavg = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "loadavg";
    rtpFilePath = "tmux-loadavg.tmux";
    version = "unstable-2018-05-30";
    src = pkgs.fetchFromGitHub {
      owner = "jamesoff";
      repo = "tmux-loadavg";
      rev = "91319eff74ee677efb77c882dcc8e3b8780dc3a2";
      hash = "sha256-JW/O/bVryDILlFCnWYRC+B7nrCIsGYEJDozzu0odX+U=";
    };
  };

in {
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
      loadavg
    ];
    extraConfigBeforePlugins = let
      battery = "[#(cat /sys/class/power_supply/BAT0/capacity)]";
      batteryline = if config.custom-args.battery or false then "${battery} " else "";
      sysstat = "#{sysstat_mem}[#{sysstat_swap}]";
      datetime = "%a %Y-%m-%d %H:%M";
      la = "#{load_short}";
      statusline = "#{prefix_highlight} ${batteryline}${la} ${sysstat} #{net_speed} | ${datetime} | #H";
    in ''
      set -g status-right '${statusline}'
    '';
  };

  home-config.tmux = {
    packages = [ "tmux" ];
    dir = builtins.toString ./home-config;
  };
}
