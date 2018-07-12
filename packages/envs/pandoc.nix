{ pkgs }:

let
  pandocWithDeps = pkgs.haskell.packages.ghc843.ghcWithPackages (pkgs: with pkgs; [
    pandoc
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
