with import <nixpkgs> {};
rec {
  pythonenv = stdenv.mkDerivation {
    name = "pythonenv";
    src = ./.;
    buildInputs = with pkgs; [
      python27Full
      python27Packages.pygtk
      python27Packages.matplotlib
      python27Packages.ipython
      python27Packages.scipy
    ];
  };
}

