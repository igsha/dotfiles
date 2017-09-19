{ stdenv, pythonPackages, python-docx, fetchFromGitHub }:

pythonPackages.buildPythonPackage rec {
  pname = "combine-docx";
  version = "master";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "igsha";
    repo = pname;
    rev = "${version}";
    sha256 = "11navjq7avibpdmmqzx26yx17143idvlqm2pmd2lhf2xcr873r7k";
  };

  propagatedBuildInputs = [ python-docx ];

  meta = with stdenv.lib; {
    homepage = https://github.com/igsha/combine-docx;
    license = "The MIT License (MIT)";
    description = "Combine several docx files into one";
  };
}
