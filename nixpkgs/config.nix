{
  allowUnfree = true;
  virtualbox.enableExtensionPack = true;
  firefox = {
    enableAdobeFlash = true;
  };
  chromium = {
    enablePepperFlash = true;
  };
  allowTexliveBuilds = true;
  wine = {
    release = "stable";
  };
  nix.useSandbox = true;

  packageOverrides = pkgs_: with pkgs_; with pkgs; {
    latexenv = buildEnv {
      name = "latexenv";
      paths = [
        (texlive.combine { inherit (texlive) scheme-full scheme-gust xdvi; })
        imagemagick
        ghostscript
        cmake
        gnumake
        poppler_utils
        biber
        gnuplot
        wdiff
        gnome3.libgxps
      ];
    };
  };
}

