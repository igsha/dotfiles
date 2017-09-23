{ pkgs }:

with import ./create-env.nix { inherit pkgs; };
rec {

  build-common = with pkgs; [
    cmake clang-tools
    pkgconfig
    libxslt
  ];

  cxx-common = with pkgs; [
    gdb valgrind doxygen openmpi
    boost catch cimg pngpp gtest
    libjpeg zlib readline netpbm libxml2 ncurses SDL SDL_image
    rpm
    opencv3
    ffmpeg
    bison flex
    amdappsdk
  ] ++ build-common;

  defaultPythonPackages = pkgs.python3Packages;
  python-docx = pkgs.callPackage ./python-docx.nix {
    pythonPackages = defaultPythonPackages;
  };
  opc-diag = pkgs.callPackage ./opc-diag.nix {
    pythonPackages = defaultPythonPackages;
  };
  combine-docx = pkgs.callPackage ./combine-docx.nix {
    pythonPackages = defaultPythonPackages;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    inherit python-docx;
  };
  pandoc-crossref = pkgs.haskell.packages.ghc802.callPackage ./pandoc-crossref.nix { };

  image-related = with pkgs; [
    ghostscript
    poppler_utils
    gnome3.libgxps
    imagemagick exif
    gnuplot
    aspell aspellDicts.en
    (aspellDicts.ru.overrideAttrs (oldAttrs: rec {
      postInstall = ''
        echo "special - -*-" >> $out/lib/aspell/ru.dat
      '';
    }))
    asymptote
  ];

  clangenv = createEnv {
    name = "clang";
    buildInputs = cxx-common ++ [ pkgs.clang ];
  };
  gccenv = createEnv {
    name = "gcc";
    buildInputs = cxx-common ++ [ pkgs.gcc6 ];
  };
  pythonenv = createEnv {
    name = "python";
    buildInputs = with defaultPythonPackages; [
      ipython matplotlib scipy opencv3
      pyside
      virtualenv
      pillow
      tabulate
      gnureadline
      sphinx docutils
      future
      sympy
      pip
      python-docx
      build-common
    ];
  };
  pandocenv = createEnv {
    name = "pandoc";
    buildInputs = with pkgs; [
      pandoc combine-docx opc-diag
      (import ./pandoc-eqnos/requirements.nix { }).packages.pandoc-eqnos
      (import ./pandoc-fignos/requirements.nix { }).packages.pandoc-fignos
      (import ./pandoc-tablenos/requirements.nix { }).packages.pandoc-tablenos
      pandoc-crossref
      pythonenv.buildInputs
      image-related
      build-common
    ];
  };
  latexenv = createEnv {
    name = "latex";
    buildInputs = with pkgs; [
      (texlive.combine {
        inherit (texlive) scheme-full metafont;
        pkgFilter = pkg: pkg.tlType == "run" || pkg.tlType == "bin" || pkg.pname == "core" || pkg.pname == "doc";
      })
      biber
      pythonenv.buildInputs
      image-related
      build-common
    ];
  };

  my-environments = [ clangenv gccenv pandocenv pythonenv latexenv ];
}
