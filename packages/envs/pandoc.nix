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
  pandoc_p = p: p.pandoc_2_3_1.override {
    haddock-library = p.haddock-library_1_6_0;
    hslua = p.hslua_1_0_1;
    hslua-module-text = p.hslua-module-text_0_2_0.override { hslua = p.hslua_1_0_1; };
  };
  pandoc_m = ghcWithPackages (p: [ (pandoc_p p) ]);
  pandocWithDeps = ghcWithPackages (p: with p; [
    (pandoc-crossref.override { pandoc = pandoc_p p; })
    (pandoc-citeproc.override { pandoc = pandoc_p p; })
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
