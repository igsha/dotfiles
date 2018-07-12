{ pkgs ? import <nixpkgs> { } }:

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

in rec {
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
      build-common
      fusepy
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
  luaenv = createEnv {
    name = "lua";
    buildInputs = with pkgs; [ love libGL lua ];
    shellHook = ''
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libGL}/lib
    '';
  };

  all-envs = [ clangenv gccenv pythonenv latexenv nodejsenv luaenv ];
}
