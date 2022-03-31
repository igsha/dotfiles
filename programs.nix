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
      export VISUAL=nvim
      export BROWSER=qutebrowser
      export PDFVIEWER=zathura
      export PSVIEWER=$PDFVIEWER
      export DVIVIEWER=$PDFVIEWER
      export TERMINAL=alacritty
    '';
  };

  udevil.enable = true;
  adb.enable = true;
  steam.enable = true;
}
