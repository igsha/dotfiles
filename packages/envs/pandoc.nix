pkgs:

let
  pandocWithDeps = pkgs.haskell.packages.ghc843.ghcWithPackages (p: with p; [
    pandoc
    /*(pkgs.haskell.lib.overrideCabal pkgs.haskellPackages.pandoc-crossref (_: {
      version = "0.3.2.1";
      sha256 = "0rxinqgfri1zlq1di4dx949migm3j76lvb10hvmpa4rxz0fkq0l6";
      }))*/
    (pandoc-crossref.overrideAttrs (oldAttrs: { doCheck = false; }))
    pandoc-citeproc
    pandoc-placetable
    pandoc-filter-graphviz
    (pandoc-include-code.overrideAttrs (oldAttrs: rec { doCheck = false; }))
  ]);

in pkgs.stdenv.mkDerivation rec {
  name = "pandocenv";
  buildInputs = with pkgs; [
    docx-combine
    docx-replace
    (python3Packages.python.withPackages (p: [ p.python-docx panflute ]))
    plantuml
    graphviz
    pantable
    imagemagick7
    cmake
    gnumake
    pandocWithDeps
  ];

  env = pkgs.buildEnv {
    inherit name;
    paths = buildInputs;
  };
}
