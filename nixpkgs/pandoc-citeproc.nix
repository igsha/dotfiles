{ mkDerivation, aeson, aeson-pretty, attoparsec, base, bytestring
, Cabal, containers, data-default, directory, filepath, hs-bibutils
, mtl, old-locale, pandoc, pandoc-types, parsec, process, rfc5051
, setenv, split, stdenv, syb, tagsoup, temporary, text, time
, unordered-containers, vector, xml-conduit, yaml
}:
mkDerivation {
  pname = "pandoc-citeproc";
  version = "0.12.1";
  sha256 = "7f12b25b0cf2f7c1ffe376d54113b6a85da0548d7b73e52e6d66f5daf65fc2ac";
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  setupHaskellDepends = [ base Cabal ];
  libraryHaskellDepends = [
    aeson base bytestring containers data-default directory filepath
    hs-bibutils mtl old-locale pandoc pandoc-types parsec rfc5051
    setenv split syb tagsoup text time unordered-containers vector
    xml-conduit yaml
  ];
  executableHaskellDepends = [
    aeson aeson-pretty attoparsec base bytestring containers directory
    filepath mtl pandoc pandoc-types process syb temporary text vector
    yaml
  ];
  testHaskellDepends = [
    aeson base bytestring containers directory filepath mtl pandoc
    pandoc-types process temporary text yaml
  ];
  doCheck = false;
  homepage = "https://github.com/jgm/pandoc-citeproc";
  description = "Supports using pandoc with citeproc";
  license = stdenv.lib.licenses.bsd3;
}
