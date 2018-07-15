pkgs:

let
  pythonWithLibs = pkgs.python3.buildEnv.override {
    ignoreCollisions = true;
    extraLibs = with pkgs.python3Packages; [
      ipython
      (matplotlib.override { enableQt = true; })
      scipy
      opencv3
      jupyter
      pyside
      virtualenv
      pillow
      tabulate
      sphinx
      docutils
      future
      sympy
      pip
      python-docx
      fusepy
    ];
  };

in pkgs.mkShell {
  name = "pythonenv";
  propagatedNativeBuildInputs = with pkgs; [ pythonWithLibs cmake gnumake ];
}
