{ stdenv, pythonPackages, python-docx, fetchFromGitHub }:

pythonPackages.buildPythonPackage rec {
  pname = "combine-docx";
  version = "0.2";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "igsha";
    repo = pname;
    rev = "v${version}";
    sha256 = "1bl8cpdw93xg47xs0cx6krx79sk82bggbls7ajvhgp2c7sb42pl9";
  };

  propagatedBuildInputs = [ python-docx ];

  meta = with stdenv.lib; {
    homepage = https://github.com/igsha/combine-docx;
    license = "The MIT License (MIT)";
    description = "Combine several docx files into one";
  };
}
