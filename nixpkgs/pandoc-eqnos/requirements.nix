# generated using pypi2nix tool (version: 1.8.0)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 3.6 -e pandoc-eqnos
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python36;
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python36-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -f $prog ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs);
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "pandoc-attributes" = python.mkDerivation {
      name = "pandoc-attributes-0.1.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c2/0a/442cc9237dc997cd88155bdcb54bf86e703e699881f4134ecb733ccd670c/pandoc-attributes-0.1.7.tar.gz"; sha256 = "69221502dac74f5df1317011ce62c85a83eef5da3b71c63b1908e98224304a8c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pandocfilters"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "BSD 2-Clause";
        description = "An Attribute class to be used with pandocfilters";
      };
    };



    "pandoc-eqnos" = python.mkDerivation {
      name = "pandoc-eqnos-0.18.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a3/8e/6e502337db44e77bff589d8d32192857d26aa14c346b2c3341c8829cc9d0/pandoc-eqnos-0.18.1.tar.gz"; sha256 = "412217f2dc7b4f1320e7a7e0d065f69ab3e79710d9090c544d0294d737a6590d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pandoc-attributes"
      self."pandoc-xnos"
      self."pandocfilters"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.gpl3;
        description = "Equation number filter for pandoc";
      };
    };



    "pandoc-xnos" = python.mkDerivation {
      name = "pandoc-xnos-0.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/97/5f/a13950664e8a0171e47eb301ead38b7a9336a5c135944be27e56a9921b90/pandoc-xnos-0.10.tar.gz"; sha256 = "4e9838a966ccd5179fdd1dfbba1e7a48fbb0ef997cde5841f1672add9b434550"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pandoc-attributes"
      self."pandocfilters"
      self."psutil"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.gpl3;
        description = "Library code for the pandoc-fignos/eqnos/tablenos filters.";
      };
    };



    "pandocfilters" = python.mkDerivation {
      name = "pandocfilters-1.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4c/ea/236e2584af67bb6df960832731a6e5325fd4441de001767da328c33368ce/pandocfilters-1.4.2.tar.gz"; sha256 = "b3dd70e169bb5449e6bc6ff96aea89c5eea8c5f6ab5e207fc2f521a2cf4a0da9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Utilities for writing pandoc filters in python";
      };
    };



    "psutil" = python.mkDerivation {
      name = "psutil-5.3.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1c/da/555e3ad3cad30f30bcf0d539cdeae5c8e7ef9e2a6078af645c70aa81e418/psutil-5.3.0.tar.gz"; sha256 = "a3940e06e92c84ab6e82b95dad056241beea93c3c9b1d07ddf96485079855185"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "psutil is a cross-platform library for retrieving information onrunning processes and system utilization (CPU, memory, disks, network)in Python.";
      };
    };

  };
  overrides = import ./requirements_override.nix { inherit pkgs python; };
  commonOverrides = [

  ];

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            ([overrides] ++ commonOverrides)
         )
   )