# generated using pypi2nix tool (version: 1.5.0)
#
# COMMAND:
#   pypi2nix -V 3 -e conan
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "PyJWT" = python.mkDerivation {
    name = "PyJWT-1.4.2";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/8f/10/9ce7e91d8ec9d852db6f9f2b076811d9f51ed7b0360602432d95e6ea4feb/PyJWT-1.4.2.tar.gz";
      sha256 = "87a831b7a3bfa8351511961469ed0462a769724d4da48a501cb8c96d1e17f570";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "JSON Web Token implementation in Python";
    };
  };



  "PyYAML" = python.mkDerivation {
    name = "PyYAML-3.12";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz";
      sha256 = "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "YAML parser and emitter for Python";
    };
  };



  "boto" = python.mkDerivation {
    name = "boto-2.43.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/68/4a/48b302989cbc3e6c64a16da5ec807bb7b36d8e8d3428579addde2eb1f671/boto-2.43.0.tar.gz";
      sha256 = "de4449cdc671939ecea6121c05587b25e73ac0c057bf1278a44bbc1974d5fd94";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Amazon Web Services Library";
    };
  };



  "bottle" = python.mkDerivation {
    name = "bottle-0.12.10";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/7e/b5/a8404cf922bdedb63b41e9b6f3ae64c93f99cf1accdf0fc265ae75f063a2/bottle-0.12.10.tar.gz";
      sha256 = "1308133647adc2d266f0ba5fea6684ba955cbf5e8133590cf0314c8beb814ff4";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Fast and simple WSGI-framework for small web-applications.";
    };
  };



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



  "conan" = python.mkDerivation {
    name = "conan-0.15.0";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/ce/83/3c6bba7598b06e97d5d84c93f2a3105932ed13f333536abc64876d0b8623/conan-0.15.0.tar.gz";
      sha256 = "c8efa5ef6024b06a472573e1bc370495e5d0f429cd0d4a4e3d6ea290c8b302d3";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."PyJWT"
      self."PyYAML"
      self."boto"
      self."bottle"
      self."colorama"
      self."fasteners"
      self."passlib"
      self."patch"
      self."requests"
      self."six"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Conan C/C++ package manager";
    };
  };



  "fasteners" = python.mkDerivation {
    name = "fasteners-0.14.1";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/f4/6f/41b835c9bf69b03615630f8a6f6d45dafbec95eb4e2bb816638f043552b2/fasteners-0.14.1.tar.gz";
      sha256 = "427c76773fe036ddfa41e57d89086ea03111bbac57c55fc55f3006d027107e18";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."monotonic"
      self."six"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = "License :: OSI Approved :: Apache Software License";
      description = "A python package that provides useful locks.";
    };
  };



  "monotonic" = python.mkDerivation {
    name = "monotonic-1.2";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/08/35/9e06c881c41962d7367e9466724beda2b1101439b149b7ff708d708890de/monotonic-1.2.tar.gz";
      sha256 = "c0e1ceca563ca6bb30b0fb047ee1002503ae6ad3585fc9c6af37a8f77ec274ba";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = "License :: OSI Approved :: Apache Software License";
      description = "An implementation of time.monotonic() for Python 2 & < 3.3";
    };
  };



  "passlib" = python.mkDerivation {
    name = "passlib-1.6.5";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/1e/59/d1a50836b29c87a1bde9442e1846aa11e1548491cbee719e51b45a623e75/passlib-1.6.5.tar.gz";
      sha256 = "a83d34f53dc9b17aa42c9a35c3fbcc5120f3fcb07f7f8721ec45e6a27be347fc";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "comprehensive password hashing framework supporting over 30 schemes";
    };
  };



  "patch" = python.mkDerivation {
    name = "patch-1.16";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/da/74/0815f03c82f4dc738e2bfc5f8966f682bebcc809f30c8e306e6cc7156a99/patch-1.16.zip";
      sha256 = "c62073f356cff054c8ac24496f1a3d7cfa137835c31e9af39a9f5292fd75bd9f";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Patch utility to apply unified diffs";
    };
  };



  "requests" = python.mkDerivation {
    name = "requests-2.11.1";
    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/2e/ad/e627446492cc374c284e82381215dcd9a0a87c4f6e90e9789afefe6da0ad/requests-2.11.1.tar.gz";
      sha256 = "5acf980358283faba0b897c73959cecf8b841205bb4b2ad3ef545f46eae1a133";
    };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.asl20;
      description = "Python HTTP for Humans.";
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

}