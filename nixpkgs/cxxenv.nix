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
      gcc5
      ncurses
      SDL SDL_image
      gdb
    ];
  };
}

