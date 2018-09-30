{ mkShell,
  buildEnv,
  ghcWithPackages,
  docproc,
  docx-combine,
  docx-replace,
  python3,
  plantuml,
  graphviz,
  pantable,
  panflute,
  imagemagick7,
  cmake,
  gnumake,
  PandocElements,
  pandoc-pipe
}:

let
  pandoc_p = p: p.pandoc_2_3.override { haddock-library = p.haddock-library_1_6_0; };
  pandoc_m = ghcWithPackages (p: [ (p.pandoc_2_3.override { haddock-library = p.haddock-library_1_6_0; }) ]);
  pandocWithDeps = ghcWithPackages (p: with p; [
    (pandoc-crossref.override { pandoc = pandoc_p p; })
    (pandoc-citeproc_0_14_4.override { pandoc = pandoc_p p; })
    pandoc-placetable
    (pandoc-include-code.overrideAttrs (old: rec { doCheck = false; }))
  ]);

in mkShell rec {
  name = "pandocenv";
  buildInputs = [
    docx-combine
    docx-replace
    (python3.withPackages (p: [ p.python-docx panflute ]))
    pantable
    pandocWithDeps
    docproc
    cmake
    gnumake
    plantuml
    graphviz
    imagemagick7
    PandocElements
    pandoc-pipe
  ];

  env = buildEnv {
    inherit name;
    paths = buildInputs;
  };
}
