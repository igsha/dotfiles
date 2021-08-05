{ pkgs }:

{
  bash = {
    enableCompletion = true;
    shellAliases = {
      ls = "ls -h --color";
      "ls.pure" = "`which ls`";
      la = "ls -lta";
      ll = "ls -lt";
      grep = "grep --color";
      cal = "cal -m";
      df = "df -h";
      fzf = "fzf-tmux";
    };
    loginShellInit = ''
      unset SSH_ASKPASS
      export EDITOR=nvim
      export BROWSER=qutebrowser
      export PDFVIEWER=zathura
      export PSVIEWER=$PDFVIEWER
      export DVIVIEWER=$PDFVIEWER
      export TERMINAL=termite
    '';
  };

  tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    shortcut = "a";
    baseIndex = 1;
    escapeTime = 0;
    extraConfig = ''
      run-shell ${pkgs.tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
      run-shell ${pkgs.tmuxPlugins.sidebar}/share/tmux-plugins/sidebar/sidebar.tmux
      run-shell ${pkgs.tmuxPlugins.urlview}/share/tmux-plugins/urlview/urlview.tmux
      run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
      run-shell ${pkgs.tmuxPlugins.pain-control}/share/tmux-plugins/pain-control/pain_control.tmux
      run-shell ${pkgs.tmuxPlugins.logging}/share/tmux-plugins/logging/logging.tmux
      run-shell ${pkgs.tmuxPlugins.open}/share/tmux-plugins/open/open.tmux
      run-shell ${pkgs.tmuxPlugins.copycat}/share/tmux-plugins/copycat/copycat.tmux

      set -g mouse on
      bind-key -T root MouseDown2Pane run-shell -b "xclip -o | tmux load-buffer - && tmux paste-buffer"
      set -g status-right '#{prefix_highlight} %a %Y-%m-%dT%H:%M'
      set -ga status-style "bg=black fg=white"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'

      bind-key -n Home send Escape "OH"
      bind-key -n End send Escape "OF"
    '';
  };

  udevil.enable = true;
  adb.enable = true;
  steam.enable = true;
}
