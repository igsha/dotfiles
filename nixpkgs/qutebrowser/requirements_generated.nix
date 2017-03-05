# generated using pypi2nix tool (version: 1.6.0)
#
# COMMAND:
#   pypi2nix -V 3.5 -e qutebrowser
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "Jinja2" = python.mkDerivation {
    name = "Jinja2-2.9.5";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/71/59/d7423bd5e7ddaf3a1ce299ab4490e9044e8dfd195420fc83a24de9e60726/Jinja2-2.9.5.tar.gz"; sha256 = "702a24d992f856fa8d5a7a36db6128198d0c21e1da34448ca236c42e92384825"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."MarkupSafe"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "A small but fast and easy to use stand-alone template engine written in pure python.";
    };
  };



  "MarkupSafe" = python.mkDerivation {
    name = "MarkupSafe-0.23";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz"; sha256 = "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Implements a XML/HTML/XHTML Markup safe string for Python";
    };
  };



  "PyYAML" = python.mkDerivation {
    name = "PyYAML-3.12";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"; sha256 = "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "YAML parser and emitter for Python";
    };
  };



  "Pygments" = python.mkDerivation {
    name = "Pygments-2.2.0";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz"; sha256 = "dbae1046def0efb574852fab9e90209b23f556367b5a320c0bcb871c77c3e8cc"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Pygments is a syntax highlighting package written in Python.";
    };
  };



  "pyPEG2" = python.mkDerivation {
    name = "pyPEG2-2.15.2";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f9/bd/10398e2c2d2070cc8a9c7153abfbd4ddb2895a2c52a32722ab8689e0cc7d/pyPEG2-2.15.2.tar.gz"; sha256 = "2b2d4f80d8e1a9370b2a91f4a25f4abf7f69b85c8da84cd23ec36451958a1f6d"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.gpl2;
      description = "An intrinsic PEG Parser-Interpreter for Python";
    };
  };



  "qutebrowser" = python.mkDerivation {
    name = "qutebrowser-0.10.0";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/91/02/a61e644ffab9eb93428cf7d408a4261ad0fa6cd0e3ee6e542f0fdb4edb18/qutebrowser-0.10.0.tar.gz"; sha256 = "b5f3516b8f886a972e5028858a9508a6d1adaf89190b38de27f6177998592b70"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."Jinja2"
      self."PyYAML"
      self."Pygments"
      self."pyPEG2"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.gpl3Plus;
      description = "A keyboard-driven, vim-like browser based on PyQt5.";
    };
  };

}