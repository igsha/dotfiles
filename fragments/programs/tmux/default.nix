{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    terminal = "xterm-256color";
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
    ];
    extraConfig = ''
      set -g mouse on
      set -g status-right '#{prefix_highlight} %a %Y-%m-%dT%H:%M'
      set -ga status-style "bg=black fg=white"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set -g @yank_selection 'primary'

      bind-key -n Home send Escape "OH"
      bind-key -n End send Escape "OF"
    '';
  };
}
