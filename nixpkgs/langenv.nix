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
    openmpi # OpenCL
    rpm
    clib
  ];
in rec {
  gccenv = stdenv.mkDerivation {
    name = "gccenv";
    src = ./.;
    hardeningDisable = [ "all" ];
    buildInputs = with pkgs; [
      stdenv
      gcc
      ncurses
      SDL SDL_image
      (opencv3.override { enableIpp = true; enableContrib = true; })
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
      opencl-headers
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
    ];
  };

  latexenv = stdenv.mkDerivation {
    name = "latexenv";
    src = ./.;
    buildInputs = with pkgs; [
      cmake
      gnumake
      (texlive.combine { inherit (texlive) scheme-full metafont; })
      ghostscript
      poppler_utils
      biber
      gnome3.libgxps
      pythonenv.nativeBuildInputs
    ];
  };
}
