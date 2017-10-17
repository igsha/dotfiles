{ stdenv, pythonPackages, python-docx, fetchFromGitHub }:

pythonPackages.buildPythonPackage rec {
  pname = "docx-replace";
  version = "0.1.2";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "cvlabmiet";
    repo = pname;
    rev = "v${version}";
    sha256 = "1iblkhn57wj4yx4q92vc67fxizs3lrplgrfj3nqzcqhfbnq8gs6b";
  };

  propagatedBuildInputs = [ python-docx ];

  meta = with stdenv.lib; {
    homepage = https://github.com/cvlabmiet/docx-replace;
    license = licenses.mit;
    description = "Replace text inside docx file";
  };
}
