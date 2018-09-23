pkgs:

let
  fetchMaster = user-repo: builtins.fetchTarball "https://api.github.com/repos/${user-repo}/tarball/master";

in rec {
  qutebrowser = pkgs.qutebrowser.overrideAttrs (oldAttrs: rec {
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.libGL ];
    postFixup = oldAttrs.postFixup + ''
      wrapProgram $out/bin/qutebrowser --suffix LD_LIBRARY_PATH : "${pkgs.libGL}/lib"
      sed -i 's/\.qutebrowser-wrapped/qutebrowser/' $out/bin/..qutebrowser-wrapped-wrapped
    '';
  });

  clawsMail = pkgs.clawsMail.override {
    enablePluginFancy = true;
    enablePluginVcalendar = true;
    enableSpellcheck = true;
    enablePluginRssyl = true;
    enablePluginPdf = true;
    webkitgtk24x-gtk2 = pkgs.webkitgtk;
  };

  matplotlib = pkgs.python3Packages.matplotlib.overrideAttrs (oldAttrs: rec {
    enableQt = true;
  });

  neovim = pkgs.neovim.override {
    configure = import ../vimrcConfig.nix { inherit (pkgs) vimUtils vimPlugins fetchFromGitHub; };
  };

  clang-tools = pkgs.clang-tools.override {
    llvmPackages = pkgs.llvmPackages_6;
  };

  docx-combine = import (fetchMaster "cvlabmiet/docx-combine") { inherit pkgs; };
  docx-replace = import (fetchMaster "cvlabmiet/docx-replace") { inherit pkgs; };

  panflute = pkgs.callPackage ./panflute {
    pythonPackages = pkgs.python3Packages;
  };
  pantable = pkgs.callPackage ./pantable {
    pythonPackages = pkgs.python3Packages;
    panflute = panflute;
  };

  inherit (pkgs.callPackage ./perl-packages {}) PandocElements;
  docproc = pkgs.callPackage (fetchMaster "igsha/docproc") { };
  pandoc-pipe = pkgs.callPackage (fetchMaster "igsha/pandoc-pipe") { };

  pandocenv = pkgs.callPackage ./envs/pandoc.nix { inherit (pkgs.haskell.packages.ghc843) ghcWithPackages; };
  gccenv = pkgs.callPackage ./envs/gcc.nix pkgs;
  pythonenv = pkgs.callPackage ./envs/python.nix pkgs;
  latexenv = pkgs.callPackage ./envs/latex.nix pkgs;
  luaenv = pkgs.callPackage ./envs/lua.nix pkgs;
}
