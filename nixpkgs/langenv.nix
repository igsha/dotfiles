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
    clib
  ];
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

  pythonenv = stdenv.mkDerivation {
    name = "pythonenv";
    src = ./.;
    buildInputs = with pythonPackages; [
      pkgs.pythonFull
      matplotlib
      pyside
      ipython
      scipy
      virtualenv
      pillow
      tabulate
      readline
      docutils
    ];
  };

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
      pythonenv.nativeBuildInputs
    ];
  };
}
