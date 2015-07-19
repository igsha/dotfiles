with import <nixpkgs> {};
rec {
  latexenv = stdenv.mkDerivation {
    name = "latexenv";
    src = ./.;
    buildInputs = with pkgs; [
      texLiveFull
      imagemagick
      ghostscript
#texstudio
    ];
  };
}

