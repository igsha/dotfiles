pkgs:

let
  pythonPkgs = pkgs.python3.buildEnv.override {
    ignoreCollisions = true;
    extraLibs = with pkgs.python3Packages; [
      scipy
      pyside
      tabulate
      future
      sympy
    ];
  };

in pkgs.mkShell {
  name = "latexenv";
  propagatedNativeBuildInputs = with pkgs; [
    (texlive.combine {
      inherit (texlive) scheme-full metafont;
      pkgFilter = pkg: pkg.tlType == "run" || pkg.tlType == "bin" || pkg.pname == "core" || pkg.pname == "doc";
    })
    biber
    pythonPkgs
    ghostscript
    poppler_utils
    gnome3.libgxps
    imagemagick7
    exif
    gnuplot
    aspell
    aspellDicts.en
    (aspellDicts.ru.overrideAttrs (oldAttrs: rec {
      postInstall = ''
        echo "special - -*-" >> $out/lib/aspell/ru.dat
      '';
    }))
    asymptote
    cmake gnumake
  ];
}
