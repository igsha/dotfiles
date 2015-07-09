with import <nixpkgs> {};
rec {
  cxxenv = stdenv.mkDerivation {
    name = "cxxenv";
    src = ./.;
    buildInputs = with pkgs; [
      stdenv
      cmake
      boost
      catch
      gcc5
      SDL SDL_image
    ];
  };
}

