{ stdenv, pythonPackages, python-docx, fetchFromGitHub }:

pythonPackages.buildPythonPackage rec {
  pname = "combine-docx";
  version = "master";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "igsha";
    repo = pname;
    rev = "${version}";
    sha256 = "0yn2fc40gkaiw6x063ba431sk5b5vj2bpywfvvwzpybx3g4vqafq";
  };

  propagatedBuildInputs = [ python-docx ];

  meta = with stdenv.lib; {
    homepage = https://github.com/igsha/combine-docx;
    license = "The MIT License (MIT)";
    description = "Combine several docx files into one";
  };
}
