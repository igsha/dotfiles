{ pkgs, ... }:

let
  customPython = pkgs.python3.withPackages (pp: with pp; [
    ipykernel
    ipython
    pandas
    scikit-learn
    scikitimage
    scipy
    matplotlib
    numpy
    opencv4
    pillow
    python-gitlab
    bitstring
    sympy
  ]);
  myJupyter = pkgs.jupyter.override {
    definitions = pkgs.jupyter-kernel.default // {
      python3 = pkgs.jupyter-kernel.default.python3 // {
        argv = [ customPython.interpreter ]
        ++ builtins.tail pkgs.jupyter-kernel.default.python3.argv;
      };
    };
  };
  pylab = pkgs.writers.writeBashBin "pylab" ''
    ${customPython.interpreter} "$@"
  '';
  ipylab = pkgs.writers.writeBashBin "ipylab" ''
    ${customPython}/bin/ipython "$@"
  '';
  jupylab = pkgs.writers.writeBashBin "jupylab" ''
    PATH+=:${myJupyter}/bin ${myJupyter}/bin/jupyter "$@"
  '';

in {
  environment.systemPackages = [
    pylab
    ipylab
    jupylab
  ];
}
