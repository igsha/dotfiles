{ pkgs, ... }:

let
  customPython = pkgs.python3.withPackages (pp: with pp; [
    ipykernel
    pandas
    scikit-learn
    scikitimage
    scipy
    matplotlib
    numpy
    tensorflow
    keras
    opencv4
    pillow
    python-gitlab
    bitstring
    sympy
  ]);
  python-lab = pkgs.writers.writeBashBin "python-lab" ''
    ${customPython.interpreter} "$@"
  '';

in {
  environment.systemPackages = [
    python-lab
  ];

  nixpkgs.overlays = [
    (_: prev: {
      myJupyter = prev.jupyter.override {
        definitions = prev.jupyter-kernel.default // {
          python3 = prev.jupyter-kernel.default.python3 // {
            argv = [ customPython.interpreter ]
            ++ builtins.tail prev.jupyter-kernel.default.python3.argv;
          };
        };
      };
    })
  ];
}
