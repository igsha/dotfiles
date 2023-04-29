user:
{ pkgs, ... }:

{
  services.jupyter = {
    enable = true;
    inherit user;
    group = "users";
    password = "'argon2:$argon2id$v=19$m=10240,t=10,p=8$oTt1F61n/XuB0hK0oFjcbQ$Zd8tyVpryo85hNqOqe8lxm4UVh6jNEqtVM9xpLcySt0'";
    notebookDir = "/home/${user}";
    kernels = {
      python3 = let
        env = pkgs.python3.withPackages (pp: with pp; [
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
      in {
        displayName = "Python3";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        language = "python";
      };
    };
  };
}
