_:

{
  programs.bash = {
    completion.enable = true;
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
      export {EDITOR,VISUAL}=nvim
      export BROWSER=qutebrowser
      export {PDF,PS,DVI}VIEWER=zathura
      export TERMINAL=alacritty
      export {,MAN}PAGER=less
    '';
    interactiveShellInit = ''
      HISTCONTROL=ignoredups:ignorespace
      eval "$(direnv hook bash)"
    '';
  };
}
