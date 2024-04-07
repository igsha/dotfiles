{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      alias = {
        st = "status";
        di = "difftool";
        br = "branch";
        co = "checkout";
        lg = "log --oneline";
        lg1 = "lg -1";
        sm = "submodule";
        ci = "commit";
        graph = "log --graph --oneline --all";
        logf = "log --pretty=fuller";
        logf1 = "logf -1";
      };
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

  environment.systemPackages = with pkgs; [
    tig
    git-crypt
  ];
}
