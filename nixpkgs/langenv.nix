with import <nixpkgs> {};
let
  common = with pkgs; [
    cmake gnumake
    boost
    catch
    gdb
    libjpeg
    zlib
    readline
    netpbm
    doxygen
    valgrind
    openmpi
    rpm
    cimg
    pngpp
    clang-tools
  ];
  defaultPythonPackages = python3Packages;
  python-docx = callPackage ./python-docx.nix {
    pythonPackages = defaultPythonPackages;
  };
  combine-docx = callPackage ./combine-docx.nix {
    pythonPackages = defaultPythonPackages;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    inherit python-docx;
  };
in rec {
  gccenv = stdenv.mkDerivation {
    name = "gccenv";
    src = ./.;
    hardeningDisable = [ "all" ];
    buildInputs = with pkgs; [
      gcc6
      ncurses
      SDL SDL_image
      opencv3
      gtest
      pkgconfig
      check
      libxml2
      ffmpeg
      bison
      flex
      cunit
      check
      amdappsdk
    ] ++ common;
  };

  clangenv = clangStdenv.mkDerivation {
    name = "clangenv";
    src = ./.;
    hardeningDisable = [ "all" ];
    buildInputs = with pkgs; [
      clang
    ] ++ common;
  };

  pythonenv = (defaultPythonPackages.python.buildEnv.override {
    extraLibs = with defaultPythonPackages; [
      matplotlib
      ipython
      scipy
      pyside
      virtualenv
      pillow
      tabulate
      readline
      sphinx
      docutils
      future
      sympy
      opencv3
      python-docx
      (import ./pandoc-eqnos/requirements.nix { }).packages.pandoc-eqnos
      combine-docx
    ];
  }).env;

  latexenv = stdenv.mkDerivation {
    name = "latexenv";
    src = ./.;
    buildInputs = with pkgs; [
      cmake
      gnumake
      (texlive.combine {
        inherit (texlive) scheme-full metafont;
        pkgFilter = pkg: pkg.tlType == "run" || pkg.tlType == "bin" || pkg.pname == "core" || pkg.pname == "doc";
      })
      ghostscript
      poppler_utils
      biber
      gnome3.libgxps
      pythonenv.buildInputs
    ];
  };
}
