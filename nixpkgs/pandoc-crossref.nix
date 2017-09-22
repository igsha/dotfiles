{ mkDerivation, base, containers, data-accessor
, data-accessor-template, data-accessor-transformers, data-default
, directory, filepath, hspec, mtl, pandoc, pandoc-types
, roman-numerals, stdenv, syb, template-haskell, utility-ht
}:
mkDerivation {
  pname = "pandoc-crossref";
  version = "0.2.6.0";
  sha256 = "1mbv2840l6kjc878f6miar3vfbgx2mwllxaryjlj9y6s6001185b";
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    base containers data-accessor data-accessor-template
    data-accessor-transformers data-default directory filepath mtl
    pandoc pandoc-types roman-numerals syb template-haskell utility-ht
  ];
  executableHaskellDepends = [ base pandoc pandoc-types ];
  testHaskellDepends = [
    base containers data-accessor data-accessor-template
    data-accessor-transformers data-default directory filepath hspec
    mtl pandoc pandoc-types roman-numerals syb template-haskell
    utility-ht
  ];
  description = "Pandoc filter for cross-references";
  license = stdenv.lib.licenses.gpl2;
}
