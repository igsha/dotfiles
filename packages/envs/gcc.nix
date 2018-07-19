pkgs:

with pkgs;
let
  compiling = [ clang-tools pkgconfig cmake gnumake dpkg rpm ];
  debugging = [ gdb valgrind strace ltrace binutils ];
  documenting = [ doxygen graphviz plantuml ];
  testing = [ catch gtest ];
  image = [ cimg pngpp libjpeg netpbm SDL SDL_image imagemagick7 ];
  generic = [ boost openmpi ];
  huge = [ ffmpeg opencv3 ncurses sfml ];

in pkgs.mkShell rec {
  name = "gccenv";
  buildInputs = [
    libxslt
    libxml2
    zlib
    readline
    bison
    flex
    fuse3
  ] ++ testing ++ image ++ generic ++ huge;

  propagatedNativeBuildInputs = [ gcc8 ] ++ debugging ++ documenting ++ compiling;

  env = buildEnv {
    inherit name;
    paths = buildInputs ++ propagatedNativeBuildInputs;
  };
}
