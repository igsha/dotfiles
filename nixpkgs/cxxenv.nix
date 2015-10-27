with import <nixpkgs> {};
rec {
  cxxenv = stdenv.mkDerivation {
    name = "cxxenv";
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
      (opencv3.override { enableIpp = true; enableContrib = true; enableBloat = true; })
      gtest
      pkgconfig
    ];
  };
}

