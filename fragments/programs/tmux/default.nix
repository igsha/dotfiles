{ config, pkgs, ... }:

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
      battery
    ];
    extraConfigBeforePlugins = let
      battery = "#{battery_color_charge_bg}#{battery_percentage}[#{battery_remain}]#[default]";
      batteryline = if config.custom-args.battery or false then "${battery} " else "";
      sysstat = "#{sysstat_cpu} #{sysstat_mem}[#{sysstat_swap}]";
      datetime = "%a %Y-%m-%d %H:%M";
      statusline = "#{prefix_highlight} ${batteryline}${sysstat} #{net_speed} | ${datetime} | #H";
    in ''
      set -g status-right '${statusline}'
    '';
  };

  home-config.tmux = {
    packages = [ "tmux" ];
    dir = builtins.toString ./home-config;
  };
}
