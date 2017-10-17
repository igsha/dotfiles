{ stdenv, pythonPackages, python-docx, fetchFromGitHub }:

pythonPackages.buildPythonPackage rec {
  pname = "docx-combine";
  version = "0.2.4";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "cvlabmiet";
    repo = pname;
    rev = "v${version}";
    sha256 = "023wajp7d2xrp4765w61mb57cs3n0sfg95fqiz8n383y8fihlrh7";
  };

  propagatedBuildInputs = [ python-docx ];

  meta = with stdenv.lib; {
    homepage = https://github.com/cvlabmiet/docx-combine;
    license = licenses.mit;
    description = "Combine several docx files into one";
  };
}
