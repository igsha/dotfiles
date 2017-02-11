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
    name = "psutil-5.1.3";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/78/0a/aa90434c6337dd50d182a81fe4ae4822c953e166a163d1bf5f06abb1ac0b/psutil-5.1.3.tar.gz"; sha256 = "959bd58bdc8152b0a143cb3bd822d4a1b8f7230617b0e3eb2ff6e63812120f2b"; };
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
    name = "thefuck-3.14";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/92/dc/c03623252b8a165257ba6bbcf3c87117c92807c27ab42cf933018d97722e/thefuck-3.14.tar.gz"; sha256 = "0d00217a3b90af50d7c88806cf560b0ac59071c115df4c2a67800f6ea1f1be4d"; };
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