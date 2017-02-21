# generated using pypi2nix tool (version: 1.6.0)
#
# COMMAND:
#   pypi2nix -V 2.7 -e MarkdownPP
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "MarkdownPP" = python.mkDerivation {
    name = "MarkdownPP-1.3";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/46/51/591c76a7616f8a69cc04b55cd1a6bd8bd597058159c031d6e418b5475514/MarkdownPP-1.3.tar.gz"; sha256 = "86a0a4346ce9e7caea19bd0874c9e16465b88ff75e5d7fc82effd21e0ad02354"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."watchdog"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Markdown preprocessor";
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



  "argh" = python.mkDerivation {
    name = "argh-0.26.2";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e3/75/1183b5d1663a66aebb2c184e0398724b624cecd4f4b679cb6e25de97ed15/argh-0.26.2.tar.gz"; sha256 = "e9535b8c84dc9571a48999094fda7f33e63c3f1b74f3e5f3ac0105a58405bb65"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.lgpl2;
      description = "An unobtrusive argparse wrapper with natural syntax";
    };
  };



  "pathtools" = python.mkDerivation {
    name = "pathtools-0.1.2";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e7/7f/470d6fcdf23f9f3518f6b0b76be9df16dcc8630ad409947f8be2eb0ed13a/pathtools-0.1.2.tar.gz"; sha256 = "7c35c5421a39bb82e58018febd90e3b6e5db34c5443aaaf742b3f33d4655f1c0"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "File system general utilities";
    };
  };



  "watchdog" = python.mkDerivation {
    name = "watchdog-0.8.3";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/54/7d/c7c0ad1e32b9f132075967fc353a244eb2b375a3d2f5b0ce612fd96e107e/watchdog-0.8.3.tar.gz"; sha256 = "7e65882adb7746039b6f3876ee174952f8eaaa34491ba34333ddf1fe35de4162"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."PyYAML"
      self."argh"
      self."pathtools"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.asl20;
      description = "Filesystem events monitoring";
    };
  };

}