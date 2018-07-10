{ config, pkgs, ... }:

with import ./create-env.nix { inherit pkgs; };
let
  build-common = with pkgs; [
    cmake clang-tools
    pkgconfig
    libxslt
  ];

  cxx-common = with pkgs; [
    gdb valgrind doxygen graphviz openmpi
    boost catch cimg pngpp gtest
    libjpeg zlib readline netpbm libxml2 ncurses SDL SDL_image imagemagick7
    rpm
    opencv3
    ffmpeg
    bison flex
    amdappsdk
    dpkg
  ] ++ build-common;

  defaultPythonPackages = pkgs.python3Packages;
  docx-combine = import (builtins.fetchTarball https://api.github.com/repos/cvlabmiet/docx-combine/tarball/master) { pkgs = pkgs; };
  docx-replace = import (builtins.fetchTarball https://api.github.com/repos/cvlabmiet/docx-replace/tarball/master) { pkgs = pkgs; };

  panflute = pkgs.callPackage ./panflute.nix {
    pythonPackages = defaultPythonPackages;
  };
  pantable = pkgs.callPackage ./pantable.nix {
    pythonPackages = defaultPythonPackages;
    panflute = panflute;
  };
  pandoc-plantuml-filter = pkgs.callPackage ./pandoc-plantuml-filter.nix {
    pythonPackages = defaultPythonPackages;
    pandocfilters = defaultPythonPackages.pandocfilters;
  };

  image-related = with pkgs; [
    ghostscript
    poppler_utils
    gnome3.libgxps
    imagemagick7 exif
    gnuplot
    aspell aspellDicts.en
    (aspellDicts.ru.overrideAttrs (oldAttrs: rec {
      postInstall = ''
        echo "special - -*-" >> $out/lib/aspell/ru.dat
      '';
    }))
    asymptote
  ];

  pandocWithDeps = pkgs.haskell.packages.ghc843.ghcWithPackages (pkgs: with pkgs; [
    pandoc
    (pandoc-crossref.overrideAttrs (oldAttrs: { doCheck = false; }))
    pandoc-citeproc
    pandoc-placetable
    pandoc-filter-graphviz
    (pandoc-include-code.overrideAttrs (oldAttrs: rec { doCheck = false; }))
  ]);

  clangenv = createEnv {
    name = "clang";
    buildInputs = cxx-common ++ [ pkgs.clang ];
  };
  gccenv = createEnv {
    name = "gcc";
    buildInputs = with pkgs; cxx-common ++ [ gcc6 linuxPackages.kernel fuse3 ];
  };
  pythonenv = createEnv {
    name = "python";
    buildInputs = with defaultPythonPackages; [
      ipython (matplotlib.override { enableQt = true; }) scipy opencv3 jupyter
      pyside
      virtualenv
      pillow
      tabulate
      sphinx docutils
      future
      sympy
      pip
      python-docx
      panflute
      pandocfilters
      pantable
      build-common
      fusepy
      pandoc-plantuml-filter
    ];
  };
  pandocenv = createEnv {
    name = "pandoc";
    buildInputs = with pkgs; [
      docx-combine
      docx-replace
      plantuml
      graphviz
      pythonenv.buildInputs
      image-related
      build-common
      pandocWithDeps
    ];
  };
  latexenv = createEnv {
    name = "latex";
    buildInputs = with pkgs; [
      (texlive.combine {
        inherit (texlive) scheme-full metafont;
        pkgFilter = pkg: pkg.tlType == "run" || pkg.tlType == "bin" || pkg.pname == "core" || pkg.pname == "doc";
      })
      biber
      pythonenv.buildInputs
      image-related
      build-common
    ];
  };
  nodejsenv = createEnv {
    name = "nodejs";
    buildInputs = with pkgs; with nodePackages; [
      nodejs
      npm
      webpack
      browserify
    ];
  };
  docenv = createEnv {
    name = "docenv";
    buildInputs = pandocenv.buildInputs ++ latexenv.buildInputs;
  };
  luaenv = createEnv {
    name = "lua";
    buildInputs = with pkgs; [ love libGL lua ];
    shellHook = ''
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libGL}/lib
    '';
  };

in {
  environment.systemPackages = [ clangenv gccenv pandocenv pythonenv latexenv nodejsenv docenv luaenv ];
}
