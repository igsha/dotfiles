{ userName, userEmail }:

{
  inherit userName userEmail;

  enable = true;
  aliases = {
    st = "status";
    di = "difftool";
    br = "branch";
    co = "checkout";
    lg = "log --oneline";
    sm = "submodule";
    ci = "commit";
    graph = "log --graph --oneline --all";
    logf = "git log --pretty=fuller";
    logf1 = "git logf -1";
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
}
