# generated using pypi2nix tool (version: 1.6.0)
#
# COMMAND:
#   pypi2nix -V 3.5 -e thefuck
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "colorama" = python.mkDerivation {
    name = "colorama-0.3.7";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f0/d0/21c6449df0ca9da74859edc40208b3a57df9aca7323118c913e58d442030/colorama-0.3.7.tar.gz"; sha256 = "e043c8d32527607223652021ff648fbb394d5e19cba9f1a698670b338c9d782b"; };
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
    name = "decorator-4.0.11";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cc/ac/5a16f1fc0506ff72fcc8fd4e858e3a1c231f224ab79bb7c4c9b2094cc570/decorator-4.0.11.tar.gz"; sha256 = "953d6bf082b100f43229cf547f4f97f97e970f5ad645ee7601d55ff87afdfe76"; };
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
    name = "psutil-5.2.1";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b8/47/c85fbcd23f40892db6ecc88782beb6ee66d22008c2f9821d777cb1984240/psutil-5.2.1.tar.gz"; sha256 = "fe0ea53b302f68fca1c2a3bac289e11344456786141b73391ed4022b412d5455"; };
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
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"; sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"; };
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
    name = "thefuck-3.15";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/87/f1/d159c8351b4220384630904cb13bded28f1564eaef7f9a0eb6d3080487a6/thefuck-3.15.tar.gz"; sha256 = "c1da9f9b705c864362316de34a1494df0c803699e587e6cf925407e42966b4aa"; };
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