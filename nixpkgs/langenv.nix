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
    amdappsdk
    opencl-headers
    openmpi # OpenCL
    rpm
  ];
in rec {
  gccenv = stdenv.mkDerivation {
    name = "gccenv";
    src = ./.;
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
    ] ++ common;
  };

  clangenv = clangStdenv.mkDerivation {
    name = "clangenv";
    src = ./.;
    buildInputs = with pkgs; [
      clang
    ] ++ common;
  };

  pythonenv = stdenv.mkDerivation {
    name = "pythonenv";
    src = ./.;
    buildInputs = with pkgs; [
      python27Full
      python27Packages.matplotlib
      pyside
      python27Packages.ipython
      python27Packages.scipy
      python27Packages.virtualenv
      python27Packages.pillow
      python27Packages.tabulate
      python27Packages.readline
    ];
  };
}
