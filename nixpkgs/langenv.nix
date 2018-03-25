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
    libjpeg zlib readline netpbm libxml2 ncurses SDL SDL_image imagemagick
    rpm
    opencv3
    ffmpeg
    bison flex
    amdappsdk
  ] ++ build-common;

  defaultPythonPackages = pkgs.python3Packages;
  python-docx = pkgs.callPackage ./python-docx.nix {
    pythonPackages = defaultPythonPackages;
  };
  opc-diag = pkgs.callPackage ./opc-diag.nix {
    pythonPackages = defaultPythonPackages;
  };
  docx-combine = pkgs.callPackage ./docx-combine.nix {
    pythonPackages = defaultPythonPackages;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    inherit python-docx;
  };
  docx-replace = pkgs.callPackage ./docx-replace.nix {
    pythonPackages = defaultPythonPackages;
    fetchFromGitHub = pkgs.fetchFromGitHub;
    inherit python-docx;
  };

  panflute = pkgs.callPackage ./panflute.nix {
    pythonPackages = defaultPythonPackages;
  };

  image-related = with pkgs; [
    ghostscript
    poppler_utils
    gnome3.libgxps
    imagemagick exif
    gnuplot
    aspell aspellDicts.en
    (aspellDicts.ru.overrideAttrs (oldAttrs: rec {
      postInstall = ''
        echo "special - -*-" >> $out/lib/aspell/ru.dat
      '';
    }))
    asymptote
  ];

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
      build-common
    ];
  };
  pandocenv = createEnv {
    name = "pandoc";
    buildInputs = with pkgs; [
      pandoc docx-combine opc-diag docx-replace
      (import ./pandoc-eqnos/requirements.nix { }).packages.pandoc-eqnos
      (import ./pandoc-fignos/requirements.nix { }).packages.pandoc-fignos
      (import ./pandoc-tablenos/requirements.nix { }).packages.pandoc-tablenos
      haskellPackages.pandoc-crossref
      haskellPackages.pandoc-citeproc
      graphviz
      pythonenv.buildInputs
      image-related
      build-common
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

in {
  environment.systemPackages = [ clangenv gccenv pandocenv pythonenv latexenv nodejsenv docenv ];
}
