# generated using pypi2nix tool (version: 1.5.0)
#
# COMMAND:
#   pypi2nix -V 3.5 -e thefuck
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "colorama" = python.mkDerivation {
    name = "colorama-0.3.7";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/f0/d0/21c6449df0ca9da74859edc40208b3a57df9aca7323118c913e58d442030/colorama-0.3.7.tar.gz";
      sha256 = "e043c8d32527607223652021ff648fbb394d5e19cba9f1a698670b338c9d782b";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Cross-platform colored terminal text.";
    };
  };



  "decorator" = python.mkDerivation {
    name = "decorator-4.0.10";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/13/8a/4eed41e338e8dcc13ca41c94b142d4d20c0de684ee5065523fee406ce76f/decorator-4.0.10.tar.gz";
      sha256 = "9c6e98edcb33499881b86ede07d9968c81ab7c769e28e9af24075f0a5379f070";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Better living through Python with decorators";
    };
  };



  "psutil" = python.mkDerivation {
    name = "psutil-5.0.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/93/7f/347309562d30c688299727e65f4d76ef34180c406dfb6f2c7b6c8d746e13/psutil-5.0.0.zip";
      sha256 = "5411e22c63168220f4b8cc42fd05ea96f5b5e65e08b93b675ca50653aea482f8";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "psutil is a cross-platform library for retrieving information onrunning processes and system utilization (CPU, memory, disks, network)in Python.";
    };
  };



  "six" = python.mkDerivation {
    name = "six-1.10.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz";
      sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Python 2 and 3 compatibility utilities";
    };
  };



  "thefuck" = python.mkDerivation {
    name = "thefuck-3.11";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/60/79/be88fab918f5b1004174d51c3bdcdf69768d9f5d66a148c6214b1a1ddb13/thefuck-3.11.tar.gz";
      sha256 = "a7a7145699b3f6a5054f9bdb2979a74f63869803eb72125325c68991ea9a966b";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."colorama"
      self."decorator"
      self."psutil"
      self."six"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Magnificent app which corrects your previous console command";
    };
  };

}