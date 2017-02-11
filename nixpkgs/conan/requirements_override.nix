{ pkgs, python }:

self: super: {

  "patch" = python.overrideDerivation super."patch" (old: {
    src = pkgs.fetchzip {
      url = builtins.head old.src.urls;
      sha256 = "1nj55hvyvzax4lxq7vkyfbw91pianzr3hp7ka7j12pgjxccac50g";
      stripRoot = false;
    };
  });

}
