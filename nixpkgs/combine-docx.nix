{ stdenv, pythonPackages, python-docx, fetchFromGitHub }:

pythonPackages.buildPythonPackage rec {
  pname = "combine-docx";
  version = "0.2.3";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "igsha";
    repo = pname;
    rev = "v${version}";
    sha256 = "0gg04s1cpnx3h9j300r4dpijhwphz9x04rhq3fg8l6939n7xkpw7";
  };

  propagatedBuildInputs = [ python-docx ];

  meta = with stdenv.lib; {
    homepage = https://github.com/igsha/combine-docx;
    license = licenses.mit;
    description = "Combine several docx files into one";
  };
}
