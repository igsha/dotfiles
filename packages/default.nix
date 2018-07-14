pkgs:

rec {
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
    configure = import ../vimrcConfig.nix { pkgs = pkgs; };
  };

  docx-combine = import (builtins.fetchTarball https://api.github.com/repos/cvlabmiet/docx-combine/tarball/master) {
    inherit pkgs;
  };
  docx-replace = import (builtins.fetchTarball https://api.github.com/repos/cvlabmiet/docx-replace/tarball/master) {
    inherit pkgs;
  };

  panflute = pkgs.callPackage ./panflute {
    pythonPackages = pkgs.python3Packages;
  };
  pantable = pkgs.callPackage ./pantable {
    pythonPackages = pkgs.python3Packages;
    panflute = panflute;
  };

  pandocenv = pkgs.callPackage ./envs/pandoc.nix {
    pkgs = pkgs // { inherit docx-combine docx-replace pantable panflute; };
  };

  gccenv = pkgs.callPackage ./envs/gcc.nix pkgs;
}
