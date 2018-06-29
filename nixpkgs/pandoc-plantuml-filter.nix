{ stdenv, pythonPackages, pandocfilters, fetchFromGitHub }:

pythonPackages.buildPythonPackage rec {
  pname = "pandoc-plantuml-filter";
  version = "0.1.1";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0ad905jmqadr5sg77w5j6r0yjmy13ccmywzmaj0r3xs6j8s14sff";
  };

  doCheck = false;
  propagatedBuildInputs = [ pandocfilters ];

  meta = with stdenv.lib; {
    homepage = https://github.com/timofurrer/pandoc-plantuml-filter;
    license = licenses.mit;
    description = "Pandoc Filter for plantuml";
  };
}
