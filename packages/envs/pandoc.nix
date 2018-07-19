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
  PandocElements
}:

let
  pandocWithDeps = ghcWithPackages (p: with p; [
    pandoc
    (pandoc-crossref.overrideAttrs (oldAttrs: { doCheck = false; }))
    pandoc-citeproc
    pandoc-placetable
    pandoc-filter-graphviz
    (pandoc-include-code.overrideAttrs (oldAttrs: rec { doCheck = false; }))
  ]);

in mkShell rec {
  name = "pandocenv";
  buildInputs = [
    docx-combine
    docx-replace
    (python3.withPackages (p: [ p.python-docx panflute ]))
    plantuml
    graphviz
    pantable
    imagemagick7
    cmake
    gnumake
    pandocWithDeps
    docproc
    PandocElements
  ];

  env = buildEnv {
    inherit name;
    paths = buildInputs;
  };
}
