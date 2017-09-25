{ stdenv, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname = "python-docx";
  version = "0.8.6";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "55ece6fd4a4fa3389909fa0e51400fce428e1fb6f6ef3599cbba31673441f184";
  };

  doCheck = false;
  propagatedBuildInputs = [ pythonPackages.lxml ];

  meta = with stdenv.lib; {
    homepage = https://github.com/python-openxml/python-docx;
    license = license.mit;
    description = "Create and update Microsoft Word .docx files.";
  };
}
