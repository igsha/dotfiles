user: { pkgs, ... }:

let
  password-file = pkgs.runCommandLocal "jupyter-password-file" { nativeBuildInputs = [ pkgs.pwgen ]; }''
    pwgen -1 > $out
  '';

in {
  services.jupyter = {
    enable = true;
    inherit user;
    password = "open('${password-file}', 'r', encoding='utf8').read().strip()";
    ip = "0.0.0.0";
    port = 8888;
    notebookDir = "~/";
    kernels = {
      python3 = let
        env = pkgs.python3.withPackages (pp: with pp; [
          ipykernel
          pandas
          scikitlearn
          scikitimage
          scipy
          matplotlib
          numpy
          tensorflow
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
        logo32 = "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
        logo64 = "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
      };
    };
  };
}
