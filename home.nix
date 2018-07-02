{ pkgs, ... }:

{
  home.packages = [
    pkgs.atool
  ];

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName  = "Igor Sharonov";
      userEmail = "igsha@users.noreply.github.com";
      aliases = {
        st = "status";
        di = "difftool";
        br = "branch";
        co = "checkout";
        lg = "log --oneline";
        sm = "submodule";
        ci = "commit";
        graph = "log --graph --oneline --all";
      };
      extraConfig = {
        core.editor = "nvim";
        color = {
          status = "auto";
          branch = "auto";
          diff = "auto";
        };
        diff.tool = "nvimdiff2";
        "difftool \"nvimdiff2\"".cmd = "nvim -d $LOCAL $REMOTE -c '$wincmd w'";
        difftool.prompt = false;
        merge.tool = "nvimdiff3";
        "mergetool \"nvimdiff3\"".cmd = "nvim -d $BASE $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
        push.default = "current";
        pull.rebase = true;
        credential.helper = "cache --timeout=3600";
      };
    };
    fzf.enable = true;
  };

  home.file = {
    ".config/matplotlib".source = configs/matplotlib;
    ".config/vifm/vifmrc".source = configs/vifmrc;
    ".config/qutebrowser/config.py".source = configs/qutebrowser/config.py;
    ".config/qutebrowser/scrollbar.css".source = configs/qutebrowser/scrollbar.css;
    ".wcalcrc".source = configs/wcalcrc;
    ".gdbinit".source = configs/gdbinit;
    ".Xdefaults".source = configs/Xdefaults;
    ".git-prompt.sh".source = configs/git-prompt.sh;
    ".bashrc".source = configs/bashrc;
  };
}
