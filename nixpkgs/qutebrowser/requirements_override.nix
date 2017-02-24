{ pkgs, python }:

let
  pdfjs = pkgs.stdenv.mkDerivation rec {
    name = "pdfjs-${version}";
    version = "1.7.225";

    src = pkgs.fetchurl {
      url = "https://github.com/mozilla/pdf.js/releases/download/v${version}/${name}-dist.zip";
      sha256 = "1n8ylmv60r0qbw2vilp640a87l4lgnrsi15z3iihcs6dj1n1yy67";
    };

    nativeBuildInputs = [ pkgs.unzip ];

    buildCommand = ''
      mkdir $out
      unzip -d $out $src
    '';
  };
in

self: super: {

  "qutebrowser" = python.overrideDerivation super."qutebrowser" (old: {
      buildInputs = with pkgs; old.buildInputs ++ [ asciidoc docbook_xml_dtd_45 docbook_xsl libxml2 libxslt ];

      propagatedBuildInputs = old.propagatedBuildInputs ++ [ pkgs.python35Packages.pyqt5 ];

      postPatch = ''
        sed -i "s,/usr/share/qutebrowser,$out/share/qutebrowser,g" qutebrowser/utils/standarddir.py
        sed -i "s,/usr/share/pdf.js,${pdfjs},g" qutebrowser/browser/pdfjs.py
      '';

      postBuild = ''
        a2x -f manpage doc/qutebrowser.1.asciidoc
      '';

      postInstall = ''
        install -Dm644 doc/qutebrowser.1 "$out/share/man/man1/qutebrowser.1"
        install -Dm644 qutebrowser.desktop \
            "$out/share/applications/qutebrowser.desktop"
        for i in 16 24 32 48 64 128 256 512; do
            install -Dm644 "icons/qutebrowser-''${i}x''${i}.png" \
                "$out/share/icons/hicolor/''${i}x''${i}/apps/qutebrowser.png"
        done
        install -Dm644 icons/qutebrowser.svg \
            "$out/share/icons/hicolor/scalable/apps/qutebrowser.svg"
        install -Dm755 -t "$out/share/qutebrowser/userscripts/" misc/userscripts/*
      '';
  });

}
