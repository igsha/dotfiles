{ stdenv, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname = "opc-diag";
  version = "1.0.0";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "061e3f8b9238343da9b262ab2f7fc94085007480d307a10550aa0fda60d0cc45";
  };

  doCheck = false;
  propagatedBuildInputs = [ pythonPackages.lxml ];

  meta = with stdenv.lib; {
    homepage = https://github.com/python-openxml/opc-diag;
    license = "The MIT License (MIT)";
    description = "Browse and diff Microsoft Office .docx, .xlsx, and .pptx files.";
  };
}
