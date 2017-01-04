# generated using pypi2nix tool (version: 1.6.0)
#
# COMMAND:
#   pypi2nix -V 3.5 -e qutebrowser
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "Jinja2" = python.mkDerivation {
    name = "Jinja2-2.8.1";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/5f/bd/5815d4d925a2b8cbbb4b4960f018441b0c65f24ba29f3bdcfb3c8218a307/Jinja2-2.8.1.tar.gz"; sha256 = "35341f3a97b46327b3ef1eb624aadea87a535b8f50863036e085e7c426ac5891"; };
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
    name = "Pygments-2.1.3";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b8/67/ab177979be1c81bc99c8d0592ef22d547e70bb4c6815c383286ed5dec504/Pygments-2.1.3.tar.gz"; sha256 = "88e4c8a91b2af5962bfa5ea2447ec6dd357018e86e94c7d14bd8cacbc5b55d81"; };
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
    name = "qutebrowser-0.9.0";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/75/6f/96d70db37d15d395b135893fb4b3c5108c4a054e66088d591fc7ea900f48/qutebrowser-0.9.0.tar.gz"; sha256 = "df2c5e1f4de9473651b6fc8cbf1863ec2437f842f2e10473f13873b50c3f038f"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."Jinja2"
      self."PyYAML"
      self."Pygments"
      self."pyPEG2"
      pkgs.python35Packages.pyqt5
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.gpl3Plus;
      description = "A keyboard-driven, vim-like browser based on PyQt5 and QtWebKit.";
    };
  };

}
