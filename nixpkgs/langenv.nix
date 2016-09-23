with import <nixpkgs> {};
rec {
  gccenv = stdenv.mkDerivation {
    name = "gccenv";
    src = ./.;
    buildInputs = with pkgs; [
      stdenv
      cmake
      gnumake
      boost
      catch
      gcc
      ncurses
      SDL SDL_image
      gdb
      (opencv3.override { enableIpp = true; enableContrib = true; })
      gtest
      pkgconfig
      check
      libjpeg
      zlib
      readline
      libxml2
      netpbm
      ffmpeg
      opencl-headers
      bison
      flex
      cunit
      check
      doxygen
      valgrind
      amdappsdk # OpenCL
      openmpi
    ];
  };

  clangenv = clangStdenv.mkDerivation {
    name = "clangenv";
    src = ./.;
    buildInputs = with pkgs; [
      cmake
      gnumake
      boost
      libjpeg
      zlib
      openmpi
      catch
      clang
      gdb
      doxygen
      valgrind
    ];
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
