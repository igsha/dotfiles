with import <nixpkgs> {};
rec {
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
    ];
  };
}

