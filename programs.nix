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
      cal = "cal -m3";
      df = "df -h";
      fzf = "fzf-tmux";
    };
    loginShellInit = ''
      export HISTCONTROL=ignoredups
      unset SSH_ASKPASS
      export EDITOR=nvim
      export BROWSER=qutebrowser
      export PDFVIEWER=zathura
      export PSVIEWER=$PDFVIEWER
      export DVIVIEWER=$PDFVIEWER
      export TERMINAL=alacritty
    '';
  };

  tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "screen-256color";
    shortcut = "a";
    extraTmuxConf = ''
      run-shell ${pkgs.tmuxPlugins.prefix-highlight}/share/tmux-plugins/prefix-highlight/prefix_highlight.tmux
      run-shell ${pkgs.tmuxPlugins.sidebar}/share/tmux-plugins/sidebar/sidebar.tmux
      run-shell ${pkgs.tmuxPlugins.urlview}/share/tmux-plugins/urlview/urlview.tmux
      run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
      run-shell ${pkgs.tmuxPlugins.pain-control}/share/tmux-plugins/pain-control/pain_control.tmux
      run-shell ${pkgs.tmuxPlugins.logging}/share/tmux-plugins/logging/logging.tmux
      run-shell ${pkgs.tmuxPlugins.open}/share/tmux-plugins/open/open.tmux
      run-shell ${pkgs.tmuxPlugins.copycat}/share/tmux-plugins/copycat/copycat.tmux
      ${builtins.readFile ./configs/tmux.conf}
    '';
  };
}
